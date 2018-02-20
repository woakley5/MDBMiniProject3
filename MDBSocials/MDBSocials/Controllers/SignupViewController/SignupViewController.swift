//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    var fullNameField: UITextField!
    var usernameField: UITextField!
    var emailField: UITextField!
    var passwordField: UITextField!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Sign Up"

        fullNameField = UITextField(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 40))
        fullNameField.placeholder = "Full Name"
        view.addSubview(fullNameField)
        
        usernameField = UITextField(frame: CGRect(x: 30, y: 150, width: view.frame.width - 60, height: 40))
        usernameField.placeholder = "Username"
        view.addSubview(usernameField)
        
        emailField = UITextField(frame: CGRect(x: 30, y: 200, width: view.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        view.addSubview(emailField)
        
        passwordField = UITextField(frame: CGRect(x: 30, y: 250, width: view.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        
        signUpButton = UIButton(frame: CGRect(x: 30, y: 300, width: view.frame.width - 60, height: 60))
        signUpButton.setTitle("Create Account", for: .normal)
        signUpButton.addTarget(self, action: #selector(tappedCreateAccount), for: .touchUpInside)
        signUpButton.setTitleColor(.blue, for: .normal)
        view.addSubview(signUpButton)
    }
    
    @objc func tappedCreateAccount(){
        if fullNameField.hasText && usernameField.hasText && emailField.hasText && passwordField.hasText{
            print("Creating account")
            FirebaseAuthHelper.signUp(name: fullNameField.text!, username: usernameField.text!, email: emailField.text!, password: passwordField.text!, view: self, withBlock: { (user) in
                self.dismiss(animated: true, completion: {
                    print("Finished creating user!")
                })
            })
        }
        else{
            print("Fields Missing")
        }
    }
    
}
