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
    fileprivate var scrollOffsetY: CGFloat = 0
    var user: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    @IBAction func onBackButtonTap(_: AnyObject) {
        
        let viewControllers: [UserProfileViewController?] = navigationController?.viewControllers.map { $0 as? UserProfileViewController } ?? []

        for viewController in viewControllers {
            if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
                rightButton.animationSelected(false)
            }
        }
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
        //navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    }
    
}

// MARK: UIScrollView Delegate
extension UserProfileViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -25 , let navigationController = navigationController {
            // buttonAnimation
            for case let viewController as UserProfileViewController in navigationController.viewControllers {
                if case let rightButton as AnimatingBarButton = viewController.navigationItem.rightBarButtonItem {
                    rightButton.animationSelected(false)
                }
            }
            popTransitionAnimation()
        }
        scrollOffsetY = scrollView.contentOffset.y
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
