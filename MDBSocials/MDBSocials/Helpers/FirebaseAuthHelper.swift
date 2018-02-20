//
//  FirebaseAuthHelper.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthHelper {
    
    static func logIn(email: String, password: String, view: UIViewController, withBlock: @escaping (User?)->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                withBlock(user)
            }
            else{
                print(error.debugDescription)
                showAlert(title: "Log In Error", message: error.debugDescription, currentView: view)

            }
        })
    }
    
    static func signUp(name: String, username: String, email: String, password: String, view: UIViewController, withBlock: @escaping (User?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                withBlock(user)
            }
            else {
                print(error.debugDescription)
                showAlert(title: "Sign Up Error", message: error.debugDescription, currentView: view)
            }
        })
    }
    
    static func logOut(view: UIViewController, withBlock: @escaping ()->()) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            withBlock()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            showAlert(title: "Error Logging Out", message: signOutError.debugDescription, currentView: view)
        }
    }
    
    static func isLoggedIn() -> Bool {
        if Auth.auth().currentUser != nil{
            print("Logged in")
            return true
        }
        else {
            print("Not Logged In")
            return false
        }
    }
    
    static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    static private func showAlert(title: String, message: String, currentView: UIViewController) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        currentView.present(alertController, animated: true, completion: nil)
    }
}
