//
//  SignUpViewController.swift
//  Real Estate
//
//  Created by Droisys on 07/10/25.
//

import UIKit
import CryptoKit // For hashing password securely

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        
        //  Check empty fields
        guard let email = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty,
              let password = txtPassword.text, !password.isEmpty,
              let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty else {
            showAlert("Please fill all fields.")
            return
            
        }
        
        //  Password match check
        guard password == confirmPassword else {
            showAlert("Passwords do not match.")
            return
        }
        
        //  Check if user already exists
        if CoreDataManager.shared.fetchUser(email: email) != nil {
            showAlert("User already exists. Please login instead.")
            return
        }
        
        //  Hash the password
        let passwordHash = hashPassword(password)
        
        //  Register user
        CoreDataManager.shared.registerUser(email: email, passwordHash: passwordHash)
        
        //  Save login info for auto-login
        UserDefaults.standard.set(email, forKey: "currentUserEmail")
        
        guard let LoginVC = storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else {
            return
        }
        navigationController?.pushViewController(LoginVC, animated: true)
        
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
        
        // Instantiate the Tab Bar Controller
        let homeTabBar = storyboard.instantiateViewController(withIdentifier: "vc")
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = homeTabBar
            window.makeKeyAndVisible()
        }
    }
}
