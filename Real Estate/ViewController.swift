//
//  ViewController.swift
//  Real Estate
//
//  Created by Droisys on 19/09/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var facebookView: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial styles for both buttons
        setupButtonStyles()
        
        // Add separate actions for each button
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide Navigation Bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // This function sets the initial style of the buttons
    func setupButtonStyles() {
        
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.clipsToBounds = true
        loginButton.layer.borderWidth = 1
        
        
        signupButton.layer.borderColor = UIColor.lightGray.cgColor
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
        signupButton.clipsToBounds = true
        signupButton.layer.borderWidth = 1
    }
    
    // Action for the login button
    @objc func loginButtonTapped() {
        //print("Login button tapped")
        
        // Set login button to active style
        loginButton.backgroundColor = .black
        loginButton.tintColor = .white
        loginButton.layer.borderColor = UIColor.black.cgColor
        
        // Reset sign-up button to inactive style
        signupButton.backgroundColor = .white
        signupButton.tintColor = .black
        signupButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // Action for the sign-up button
    @objc func signUpButtonTapped() {
        //print("Sign up button tapped")
        
        // Set sign-up button to active style
        signupButton.backgroundColor = .black
        signupButton.tintColor = .white
        signupButton.layer.borderColor = UIColor.black.cgColor
        
        // Reset login button to inactive style
        loginButton.backgroundColor = .white
        loginButton.tintColor = .black
        loginButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        // Login Button
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.clipsToBounds = true
        
        // Sign Up Button
        
        signupButton.layer.cornerRadius = signupButton.frame.height / 2
        signupButton.clipsToBounds = true
        
        // This function will apply the same styling to all views
        func styleView(_ view: UIView) {
            view.backgroundColor = .white
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.lightGray.cgColor // Use a light gray color
            view.layer.cornerRadius = view.frame.height / 2
            view.clipsToBounds = true
        }
        
        // Apply styling to all the views
        styleView(googleView)
        styleView(appleView)
        styleView(facebookView)
        
    }
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
        guard let LoginVC = storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginViewController else {
            return
        }
        navigationController?.pushViewController(LoginVC, animated: true)
        

    }
    
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        guard let SignUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpViewController else {
            return
        }
        navigationController?.pushViewController(SignUpVC, animated: true)

    }
}
