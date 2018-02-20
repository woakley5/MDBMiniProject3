//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var emailField: UITextField!
    var passwordField: UITextField!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Log In"
        
        emailField = UITextField(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        view.addSubview(emailField)
        
        passwordField = UITextField(frame: CGRect(x: 30, y: 150, width: view.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        
        logInButton = UIButton(frame: CGRect(x: 30, y: 200, width: view.frame.width - 60, height: 60))
        logInButton.setTitle("Log In!", for: .normal)
        logInButton.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        logInButton.setTitleColor(.blue, for: .normal)
        view.addSubview(logInButton)
        
        signUpButton = UIButton(frame: CGRect(x: 30, y: 250, width: view.frame.width - 60, height: 60))
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        signUpButton.setTitleColor(.blue, for: .normal)
        view.addSubview(signUpButton)
    }
    
    @objc func tappedLogin(){
        if emailField.hasText && passwordField.hasText{
            FirebaseAuthHelper.logIn(email: emailField.text!, password: passwordField.text!, view: self, withBlock: { (user) in
                self.dismiss(animated: true, completion: {
                    print("Successfully logged in!")
                })
            })
        }
    }
    
    @objc func tappedSignUp(){
        self.performSegue(withIdentifier: "showSignup", sender: self)
    }
}

