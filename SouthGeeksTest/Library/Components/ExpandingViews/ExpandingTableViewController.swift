//
//  ExpandingTableViewController.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

open class ExpandingTableViewController: UITableViewController {

    // MARK: - Variables
    open var headerHeight: CGFloat = 360
    var transitionDriver: TransitionDriver?
}

// MARK: - Helpers
extension ExpandingTableViewController {

    fileprivate func getScreen() -> UIImage? {
        let height = (headerHeight - tableView.contentOffset.y) < 0 ? 0 : (headerHeight - tableView.contentOffset.y)
        let backImageSize = CGSize(width: view.bounds.width, height: view.bounds.height - height + getTabBarHeight())
        let backImageOrigin = CGPoint(x: 0, y: height + tableView.contentOffset.y)
        return view.takeSnapshot(CGRect(origin: backImageOrigin, size: backImageSize))
    }

    fileprivate func getTabBarHeight() -> CGFloat {
        guard let navigationController = self.navigationController else {
            return 0
        }

        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let insets = tableView.contentInsetAdjustmentBehavior == .automatic
        let tabBarHeight = insets == true ? navigationController.navigationBar.frame.size.height : 0
        let stausBarHeight = insets == true ? keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 : 0
        return tabBarHeight + stausBarHeight
    }
}

// MARK: - Methods
extension ExpandingTableViewController {

    public func popTransitionAnimation() {
        guard let transitionDriver = self.transitionDriver else {
            return
        }

        let backImage = getScreen()
        var offset = tableView.contentOffset.y > headerHeight ? headerHeight : tableView.contentOffset.y

        offset += getTabBarHeight()

        transitionDriver.popTransitionAnimationContantOffset(offset, backImage: backImage)
        _ = navigationController?.popViewController(animated: false)
    }
    
}
