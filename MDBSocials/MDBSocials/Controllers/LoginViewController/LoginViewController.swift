//
//  LoginViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {

    var emailField: SkyFloatingLabelTextField!
    var passwordField: SkyFloatingLabelTextField!
    var logInButton: UIButton!
    var signUpButton: UIButton!
    var logoImage: UIImageView!
    var logoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setupLogo()
        setupEmailField()
        setupPasswordField()
        setupLogInButton()
        setupMakeAccountButton()
    }
    
    func setupLogo(){
        logoImage = UIImageView(frame: CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 300))
        logoImage.contentMode = .scaleAspectFit
        logoImage.image = #imageLiteral(resourceName: "whiteLogoOutline")
        view.addSubview(logoImage)
        
        logoLabel = UILabel(frame: CGRect(x: view.frame.width/2 - 40, y: 180, width: 220, height: 140))
        logoLabel.text = "SOCIALS"
        logoLabel.textColor = .white
        logoLabel.font = UIFont(name: "ArialRoundedMTBold", size: 45)
        view.addSubview(logoLabel)
    }
    
    func setupEmailField(){
        emailField = SkyFloatingLabelTextField(frame: CGRect(x: 30, y: 320, width: view.frame.width - 60, height: 40))
        emailField.placeholder = "Email"
        emailField.title = "Email"
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
        passwordField = SkyFloatingLabelTextField(frame: CGRect(x: 30, y: 390, width: view.frame.width - 60, height: 40))
        passwordField.placeholder = "Password"
        passwordField.title = "Password"
        passwordField.selectedTitleColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.selectedLineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.textColor = .white
        passwordField.placeholderColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.lineColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        passwordField.titleColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        passwordField.tintColor = .white
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
    }
    
    func setupLogInButton(){
        logInButton = UIButton(frame: CGRect(x: 30, y: 500, width: view.frame.width/2 - 60, height: 60))
        logInButton.setTitle("Log In!", for: .normal)
        logInButton.backgroundColor = .white
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(tappedLogin), for: .touchUpInside)
        logInButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        view.addSubview(logInButton)
    }
    
    func setupMakeAccountButton(){
        signUpButton = UIButton(frame: CGRect(x: view.frame.width/2 + 30, y: 500, width: view.frame.width/2 - 60, height: 60))
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        signUpButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        view.addSubview(signUpButton)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
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

