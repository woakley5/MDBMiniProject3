//
//  SignupViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignupViewController: UIViewController {
    
    var fullNameField: SkyFloatingLabelTextField!
    var usernameField: SkyFloatingLabelTextField!
    var emailField: SkyFloatingLabelTextField!
    var passwordField: SkyFloatingLabelTextField!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    var signupTitleLabel: UILabel!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setupTitleLabel()
        setupFullNameField()
        setupUsernameField()
        setupEmailField()
        setupPasswordField()
        setupSignupButton()
        setupBackButton()
    }
    
    func setupTitleLabel(){
        signupTitleLabel = UILabel(frame: CGRect(x: 30, y: 30, width: view.frame.width - 60, height: 80))
        signupTitleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        signupTitleLabel.text = "Sign Up"
        signupTitleLabel.textColor = .white
        signupTitleLabel.textAlignment = .center
        view.addSubview(signupTitleLabel)
    }
    
    func setupFullNameField(){
        fullNameField = SkyFloatingLabelTextField(frame: CGRect(x: 30, y: 125, width: view.frame.width - 60, height: 40))
        fullNameField.placeholder = "Full Name"
        fullNameField.title = "Full Name"
        fullNameField.textColor = .white
        fullNameField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        fullNameField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        fullNameField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        fullNameField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        fullNameField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        fullNameField.tintColor = .white
        view.addSubview(fullNameField)
    }
    
    func setupUsernameField(){
        usernameField = SkyFloatingLabelTextField(frame: CGRect(x: 30, y: 175, width: view.frame.width - 60, height: 40))
        usernameField.placeholder = "Username"
        usernameField.title = "Username"
        usernameField.textColor = .white
        usernameField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        usernameField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        usernameField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        usernameField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        usernameField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        usernameField.tintColor = .white
        view.addSubview(usernameField)
    }
    
    func setupEmailField(){
        emailField = SkyFloatingLabelTextField(frame: CGRect(x: 30, y: 225, width: view.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        usernameField.title = "Email"
        emailField.textColor = .white
        emailField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        emailField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        emailField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        emailField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        emailField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        emailField.tintColor = .white
        view.addSubview(emailField)
    }
    
    func setupPasswordField(){
        passwordField = SkyFloatingLabelTextField(frame: CGRect(x: 30, y: 275, width: view.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.title = "Password"
        passwordField.textColor = .white
        passwordField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        passwordField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.tintColor = .white
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
    }
    
    func setupSignupButton(){
        signUpButton = UIButton(frame: CGRect(x: view.frame.width/2 - 100, y: 375, width: 200, height: 60))
        signUpButton.setTitle("Create Account", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(tappedCreateAccount), for: .touchUpInside)
        signUpButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        view.addSubview(signUpButton)
    }
    
    func setupBackButton(){
        backButton = UIButton(frame: CGRect(x: view.frame.width/2 - 50, y: 450, width: 100, height: 60))
        backButton.setTitle("Cancel", for: .normal)
        backButton.backgroundColor = .white
        backButton.layer.cornerRadius = 10
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        backButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        view.addSubview(backButton)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        fullNameField.resignFirstResponder()
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
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
            let alertController = UIAlertController(title: "Fields Blank", message:
                "Make sure you enter all required information.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedBackButton(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
