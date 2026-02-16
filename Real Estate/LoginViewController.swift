//
//  LoginViewController.swift
//  Real Estate
//
//  Created by Droisys on 07/10/25.
//

import UIKit
import CryptoKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        // Validation
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty,
              let password = txtPassword.text, !password.isEmpty else {
            showAlert("Please enter email and password.")
            return
            
        }
        
        //  Fetch user from database
        guard let user = CoreDataManager.shared.fetchUser(email: email) else {
            showAlert("User not found. Please sign up.")
            return
        }
        
        //  Check password
        let enteredHash = hashPassword(password)
        if user.password == enteredHash {
            // Mark user logged in (optional flag)
            user.isLoggedIn = true
            CoreDataManager.shared.saveContext()
            
            // Save user in UserDefaults
            UserDefaults.standard.set(email, forKey: "currentUserEmail")
            goToHome()
            
        } else {
            showAlert("Invalid password. Please try again.")
        }
    }
    
    // MARK: - Helper Functions
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }
    
    func goToHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the Tab Bar Controller instead of HomeVC
        let homeTabBar = storyboard.instantiateViewController(withIdentifier: "vc")
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = homeTabBar
            window.makeKeyAndVisible()
        }
    }
}
