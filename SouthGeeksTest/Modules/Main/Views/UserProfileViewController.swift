//
//  UserProfileViewController.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 16/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class UserProfileViewController: ExpandingTableViewController {

    // MARK: - Lifecycle
    var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Actions
    @IBAction func onBackButtonTap(_: AnyObject) {
        
        let _: [UserProfileViewController?] = navigationController?.viewControllers.map { $0 as? UserProfileViewController } ?? []
        
        popTransitionAnimation()
    }
}

// MARK: - Helpers
extension UserProfileViewController {
    
    fileprivate func setupView() {
        configureNavBar()
        registerCells()
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    fileprivate func registerCells() {
        let nib = UINib(nibName: String(describing: UserProfileTableViewCell.self),
                            bundle: nil)
        tableView.register(nib,
                           forCellReuseIdentifier: String(describing: UserProfileTableViewCell.self))
    }
    
    fileprivate func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(UserProfileViewController.onBackButtonTap))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
    
}

// MARK: UIScrollView Delegate
extension UserProfileViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -25 , let _ = navigationController {
            popTransitionAnimation()
        }
    }
}

// MARK: - UITableView Delegate
extension UserProfileViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? UserProfileTableViewCell {
            cell.animateIn()
        }
    }
    
}

// MARK: - UITableView DataSource
extension UserProfileViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UserProfileTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserProfileTableViewCell.self), for: indexPath) as! UserProfileTableViewCell
        
        cell.setData(withUser: user)
        
        return cell
    }
}
