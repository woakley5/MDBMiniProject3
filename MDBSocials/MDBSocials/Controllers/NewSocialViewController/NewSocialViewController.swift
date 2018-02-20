//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class NewSocialViewController: UIViewController {

    var eventNameField: UITextField!
    var eventDescriptionView: UITextView!
    var datePicker: UIDatePicker!
    var selectImageButton: UIButton!
    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "New Post"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewPost))
        
        eventNameField = UITextField(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 40))
        eventNameField.placeholder = "Event Name"
        view.addSubview(eventNameField)
        
        eventDescriptionView = UITextView(frame: CGRect(x: 30, y: 150, width: view.frame.width - 60, height: 100))
        eventDescriptionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(eventDescriptionView)
        
        datePicker = UIDatePicker(frame: CGRect(x: 30, y: view.frame.height * 0.5, width: view.frame.width - 60, height: 200))
        view.addSubview(datePicker)
    }
    
    @objc func cancelNewPost(){
        self.dismiss(animated: true) {
            print("Back to feed")
        }
    }
}
