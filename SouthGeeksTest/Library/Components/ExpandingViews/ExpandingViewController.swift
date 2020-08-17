//
//  ExpandingViewController.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

open class ExpandingViewController: UIViewController {

    // MARK: - Variables
    open var itemSize = CGSize(width: 256, height: 460)
    open var collectionView: UICollectionView?
    fileprivate var transitionDriver: TransitionDriver?

    open var currentIndex: Int {
        guard let collectionView = self.collectionView else { return 0 }

        let startOffset = (collectionView.bounds.size.width - itemSize.width) / 2
        guard let collectionLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }

        let minimumLineSpacing = collectionLayout.minimumLineSpacing
        let a = collectionView.contentOffset.x + startOffset + itemSize.width / 2
        let b = itemSize.width + minimumLineSpacing
        return Int(a / b)
    }
    
    // MARK: - Lifecicle
    open override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
}

// MARK: - Transition
public extension ExpandingViewController {
    
    func pushToViewController(_ viewController: ExpandingTableViewController) {
        guard let collectionView = self.collectionView,
            let navigationController = self.navigationController else {
            return
        }

        viewController.transitionDriver = transitionDriver
        let insets = viewController.tableView.contentInsetAdjustmentBehavior == .automatic
        let tabBarHeight = insets == true ? navigationController.navigationBar.frame.size.height : 0
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let stausBarHeight = insets == true ? keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 : 0
        
        let backImage = getBackImage(viewController, headerHeight: viewController.headerHeight)

        transitionDriver?.pushTransitionAnimationIndex(currentIndex,
                                                       collecitionView: collectionView,
                                                       backImage: backImage,
                                                       headerHeight: viewController.headerHeight,
                                                       insets: tabBarHeight + stausBarHeight) { headerView in
            viewController.tableView.tableHeaderView = headerView
            let footerView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: UIScreen.main.bounds.width,
                                            height: 30))
            footerView.backgroundColor = .clear
            viewController.tableView.tableFooterView = footerView
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}

// MARK: Create
extension ExpandingViewController {

    fileprivate func commonInit() {

        let layout = PageCollectionLayout(itemSize: itemSize)
        collectionView = PageCollectionView.createOnView(view,
                                                         layout: layout,
                                                         height: itemSize.height,
                                                         dataSource: self,
                                                         delegate: self)
        collectionView?.isPrefetchingEnabled = false
        transitionDriver = TransitionDriver(view: view)
        
    }
}

// MARK: - Helpers

extension ExpandingViewController {

    fileprivate func getBackImage(_ viewController: UIViewController, headerHeight: CGFloat) -> UIImage? {
        let imageSize = CGSize(width: viewController.view.bounds.width, height: viewController.view.bounds.height - headerHeight)
        let imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
        return viewController.view.takeSnapshot(imageFrame)
    }
}

// MARK: UICollectionViewDataSource

extension ExpandingViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    open func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt _: IndexPath) {
        guard case let cell as BasePageCollectionCell = cell else {
            return
        }

        cell.configureCellViewConstraintsWithSize(itemSize)
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    open func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        fatalError("need emplementation in subclass")
    }

    open func collectionView(_: UICollectionView, cellForItemAt _: IndexPath) -> UICollectionViewCell {
        fatalError("need emplementation in subclass")
    }
}

