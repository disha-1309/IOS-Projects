//
//  UserViewModel.swift
//  APICALLING MVVM
//
//  Created by Droisys on 16/02/26.
//

import Foundation

class UserViewModel {
    
    var users: [User] = []
    
    var reloadTableView: (() -> Void)?
    var showError: ((String) -> Void)?
    
    func fetchUsers() {
        
        APIService.shared.fetchUsers { [weak self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                    
                case .success(let users):
                    self?.users = users
                    self?.reloadTableView?()
                    
                case .failure(let error):
                    self?.showError?(error.localizedDescription)
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        return users.count
    }
    
    func userAt(index: Int) -> User {
        return users[index]
    }
}
