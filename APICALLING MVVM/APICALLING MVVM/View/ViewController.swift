//
//  ViewController.swift
//  APICALLING MVVM
//
//  Created by Droisys on 16/02/26.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let refreshControl = UIRefreshControl()
    
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        
        activityIndicator.startAnimating()
        viewModel.fetchUsers()
    }
    
    func setupUI() {
        
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        
        tableView.frame = view.bounds
        activityIndicator.center = view.center
        
        tableView.register(UserTableViewCell.self,
                           forCellReuseIdentifier: "UserCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self,
                                 action: #selector(refreshData),
                                 for: .valueChanged)
    }

    @objc func refreshData() {
        viewModel.fetchUsers()
        refreshControl.endRefreshing()
    }

    func setupBinding() {
        
        viewModel.reloadTableView = { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
        
        viewModel.showError = { error in
            print("Error:", error)
        }
    }

    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell",
                                                 for: indexPath) as! UserTableViewCell
        
        let user = viewModel.userAt(index: indexPath.row)
        cell.nameLabel.text = user.name
        cell.emailLabel.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let user = viewModel.userAt(index: indexPath.row)
        let detailVC = DetailViewController()
        detailVC.user = user
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
