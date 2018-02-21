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
    var selectedImageView: UIImageView!
    var submitButton: UIButton!
    
    var selectedImage: UIImage!
    
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
        
        selectImageButton = UIButton(frame: CGRect(x: 30, y: 270, width: 100, height: 50))
        selectImageButton.setTitle("Select Picture", for: .normal)
        selectImageButton.setTitleColor(.blue, for: .normal)
        selectImageButton.addTarget(self, action: #selector(selectPicture), for: .touchUpInside)
        view.addSubview(selectImageButton)
        
        selectedImageView = UIImageView(frame: CGRect(x: view.frame.width/2, y: 270, width: view.frame.width - 25, height: 150))
        selectedImageView.contentMode = .scaleAspectFit
        view.addSubview(selectedImageView)
        
        datePicker = UIDatePicker(frame: CGRect(x: 30, y: view.frame.height * 0.65, width: view.frame.width - 60, height: 200))
        view.addSubview(datePicker)
        
        submitButton = UIButton(frame: CGRect(x: 30, y: view.frame.height * 0.8, width: view.frame.width - 60, height: 50))
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(.blue, for: .normal)
        submitButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        view.addSubview(submitButton)
    }
    
    @objc func cancelNewPost() {
        self.dismiss(animated: true) {
            print("Back to feed")
        }
    }
    
    @objc func selectPicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func newPost() {
        if eventNameField.hasText && eventDescriptionView.hasText && selectedImage != nil {
            FirebaseDatabaseHelper.newPostWithImage(selectedImage: selectedImage, name: eventNameField.text!, description: eventDescriptionView.text, date: datePicker.date)
        }
        else{
            print("Need to fill all fields")
        }
    }
}

extension NewSocialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        selectedImageView.image = selectedImage
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
