//
//  MyViewController.swift
//  Real Estate
//
//  Created by Droisys on 22/09/25.
//

import UIKit

class MyViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 18.5, *) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                self.traitOverrides.horizontalSizeClass = .compact
            }
        }
    }
    
    
}
