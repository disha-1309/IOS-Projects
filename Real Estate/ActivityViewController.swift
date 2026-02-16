//
//  ActivityViewController.swift
//  Real Estate
//
//  Created by Droisys on 03/10/25.
//

import UIKit
import Combine

class ActivityViewController: UIViewController {
    
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var clientName: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = ProductAPIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        loadAccountData()
    }
    
    func loadAccountData() {
        apiService.fetchAccountData()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print(" API call completed successfully")
                case .failure(let error):
                    print(" Error:", error)
                    self.activityName.text = "Error"
                    self.clientName.text = "Failed to load data"
                }
            }, receiveValue: { [weak self] accounts in
                guard let self = self else { return }
                
                if let firstAccount = accounts.first {
                    self.activityName.text = firstAccount.accountName
                    self.clientName.text = firstAccount.clientName
                    
                    print("Account Name:", firstAccount.accountName)
                    print("Client Name:", firstAccount.clientName)
                } else {
                    self.activityName.text = "No Account Found"
                    self.clientName.text = ""
                }
            })
            .store(in: &cancellables)
    }
}
