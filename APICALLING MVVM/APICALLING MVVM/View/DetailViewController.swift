//
//  DetailViewController.swift
//  APICALLING MVVM
//
//  Created by Droisys on 16/02/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let label = UILabel(frame: view.bounds)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        label.text = "Name: \(user?.name ?? "")\nEmail: \(user?.email ?? "")"
        
        view.addSubview(label)
    }
}
