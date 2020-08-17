//
//  MainCollectionViewController.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 15/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import UIKit

class MainCollectionViewController: ExpandingViewController {

    // MARK: - Outlets
    //@IBOutlet var pageLabel: UILabel!
    
    // MARK: - Variables
    fileprivate var viewModel: MainViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 460)
        super.viewDidLoad()
        setupView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let views: [UserCollectionViewCell?] = self.view.subviews.map { $0 as? UserCollectionViewCell }
        for view in views {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                view?.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Methods
    func setupView() {
        registerCells()
        addGesture(to: collectionView!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "repeat"), style: .plain, target: self, action: #selector(reload))
        title = "Users"
    }
    
    func initData() {
        viewModel = MainViewModel(self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.viewModel?.loadData()
        }
    }
    
    @objc func reload() {
        viewModel?.loadData(force: true)
    }
}

// MARK: - Helpers

extension MainCollectionViewController {

    fileprivate func registerCells() {
        let nib = UINib(nibName: String(describing: UserCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: UserCollectionViewCell.self))
    }

    fileprivate func getViewController(withUser user: User?) -> UserProfileViewController {
        let vc = UserProfileViewController()
        vc.user = user
        return vc
    }
    
}

// MARK: - Gesture
extension MainCollectionViewController {

    fileprivate func addGesture(to view: UIView) {
        let upGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(MainCollectionViewController.swipeHandler(_:)))) {
            $0.direction = .up
        }

        let downGesture = Init(UISwipeGestureRecognizer(target: self, action: #selector(MainCollectionViewController.swipeHandler(_:)))) {
            $0.direction = .down
        }
        view.addGestureRecognizer(upGesture)
        view.addGestureRecognizer(downGesture)
    }

    @objc func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? UserCollectionViewCell,
            let _ = viewModel?.userForRowInSection(indexPath) else { return }
        
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController(withUser: viewModel?.userForRowInSection(indexPath)))
        } else if !cell.isOpened && sender.direction == .up {
            cell.animateIn()
        }

        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        viewModel?.setCellIsOpen(for: indexPath, isOpen: cell.isOpened)
    }
}

// MARK: UIScrollViewDelegate

extension MainCollectionViewController {

    func scrollViewDidScroll(_: UIScrollView) {
        //pageLabel.text = "\(currentIndex + 1)/\(items.count)"
    }
}

// MARK: UICollectionViewDataSource

extension MainCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? UserCollectionViewCell else { return }

        let index = indexPath.row % (viewModel?.numberOfRowsInSection(indexPath.section) ?? 0)
        let user = viewModel?.userForRowInSection(IndexPath(item: index, section: 0))
        
        cell.setData(withUser: user,
                     isOpen: viewModel?.cellIsOpen(indexPath) ?? false)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? UserCollectionViewCell,
            currentIndex == indexPath.row,
            let _ = viewModel?.userForRowInSection(indexPath)else { return }

        if cell.isOpened == false {
            cell.cellIsOpen(true)
            cell.animateIn()
        } else {
            pushToViewController(getViewController(withUser: viewModel?.userForRowInSection(indexPath)))
        }
        
        viewModel?.setCellIsOpen(for: indexPath, isOpen: cell.isOpened)
    }
}

// MARK: UICollectionViewDataSource

extension MainCollectionViewController {

    override func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCollectionViewCell.self), for: indexPath)
    }
}

// MARK: - MainViewModel Delegate
extension MainCollectionViewController: MainViewModelDelegate {
    
    func onDataDidLoad() {
        collectionView?.reloadData()
    }
    
}

