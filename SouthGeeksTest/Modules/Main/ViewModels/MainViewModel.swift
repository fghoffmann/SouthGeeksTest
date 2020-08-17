//
//  MainViewModel.swift
//  SouthGeeksTest
//
//  Created by Fabio Gustavo Hoffmann on 14/08/2020.
//  Copyright © 2020 FabioGustavoHoffmann. All rights reserved.
//

import Foundation

// MARK: - MainViewModel Delegate
protocol MainViewModelDelegate: class {
    func onDataDidLoad()
}

class MainViewModel {
    
    // MARK: - Observables
    fileprivate var users: Users?
    fileprivate var usersService: UsersService = UsersService()
    fileprivate let loadingCellsCount: Int = 10
    fileprivate weak var delegate: MainViewModelDelegate?
    fileprivate var cellsIsOpen = [Bool]()
    fileprivate var isInitialized = false
    
    // MARK: - Lifecycle
    init(_ delegate: MainViewModelDelegate) {
        self.delegate = delegate
    }
    
}

// MARK: - Private Methods
extension MainViewModel {
    
    private func fetchUsers(force: Bool) {
        usersService.fetchUsers(force: force) { (users, error) in
            DispatchQueue.main.async { [weak self] in
                self?.users = users
                self?.cellsIsOpen = Array(repeating: false, count: users?.items.count ?? self?.loadingCellsCount ?? 0)
                self?.delegate?.onDataDidLoad()
            }
        }
    }
    
}

// MARK: - Public Methods
extension MainViewModel {
    
    func loadData(force: Bool = false) {
        if !force, users != nil {
            delegate?.onDataDidLoad()
            return
        }
        
        if force { users = nil }
        
        // Set loading cells
        isInitialized = true
        delegate?.onDataDidLoad()
        
        fetchUsers(force: force)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        if !isInitialized { return 0 }
        return users?.items.count ?? loadingCellsCount
    }
    
    func userForRowInSection(_ indexPath: IndexPath) -> User? {
        if users?.items.count ?? 0 > indexPath.row {
            return users?.items[indexPath.row]
        }
        return nil
    }
    
    func cellIsOpen(_ indexPath: IndexPath) -> Bool {
        if cellsIsOpen.count > indexPath.row {
            return cellsIsOpen[indexPath.row]
        }
        return false
    }
    
    func setCellIsOpen(for indexPath: IndexPath, isOpen: Bool) {
        if cellsIsOpen.count > indexPath.row {
            cellsIsOpen[indexPath.row] = isOpen
        }
    }
    
}
