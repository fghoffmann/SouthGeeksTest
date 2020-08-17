//
//  MainViewController.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    fileprivate var viewModel: MainViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Methods
    func setupView() {
        registerCells()
        title = "Users"
    }
    
    func initData() {
        viewModel = MainViewModel(self)
        viewModel?.loadData()
    }
    
    func registerCells() {
        let nib = UINib(nibName: String(describing: UserTableViewCell.self),
                            bundle: nil)
        tableView.register(nib,
                           forCellReuseIdentifier: String(describing: UserTableViewCell.self))
    }
    
}

// MARK: - MainViewModel Delegate
extension MainViewController: MainViewModelDelegate {
    
    func onDataDidLoad() {
        tableView.reloadData()
    }
    
}

// MARK: - TableView Delegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? UserTableViewCell {
            cell.animateIn()
        }
    }
    
}

// MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self), for: indexPath) as! UserTableViewCell
        
        cell.setData(withUser: viewModel?.userForRowInSection(indexPath))
        
        return cell
    }
    
}
