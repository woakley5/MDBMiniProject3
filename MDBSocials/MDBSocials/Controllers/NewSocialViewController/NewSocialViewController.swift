//
//  NewSocialViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import MKSpinner

class NewSocialViewController: UIViewController {

    var backgroundImage: UIImageView!
    var backgroundBlur: UIVisualEffectView!
    
    var eventNameField: UITextField!
    var eventDescriptionView: UITextView!
    var datePicker: UIDatePicker!
    var selectLibraryImageButton: UIButton!
    var selectCameraImageButton: UIButton!
    var selectedImageView: UIImageView!
    var submitButton: UIButton!
    
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        self.navigationItem.title = "New Post"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewPost))
        
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.image = #imageLiteral(resourceName: "gradientLogo")
        backgroundImage.contentMode = .scaleAspectFit
        view.addSubview(backgroundImage)
        
        backgroundBlur = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundBlur.effect = UIBlurEffect(style: UIBlurEffectStyle.light)
        view.addSubview(backgroundBlur)
        
        eventNameField = UITextField(frame: CGRect(x: 30, y: 85, width: view.frame.width - 60, height: 40))
        eventNameField.placeholder = "Event Name"
        view.addSubview(eventNameField)
        
        eventDescriptionView = UITextView(frame: CGRect(x: 30, y: 150, width: view.frame.width - 60, height: 100))
        eventDescriptionView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(eventDescriptionView)
        
        selectCameraImageButton = UIButton(frame: CGRect(x: 30, y: 270, width: 150, height: 50))
        selectCameraImageButton.setTitle("Take Picture", for: .normal)
        selectCameraImageButton.setTitleColor(.blue, for: .normal)
        selectCameraImageButton.addTarget(self, action: #selector(selectPictureFromCamera), for: .touchUpInside)
        view.addSubview(selectCameraImageButton)
        
        selectLibraryImageButton = UIButton(frame: CGRect(x: 30, y: 330, width: 150, height: 50))
        selectLibraryImageButton.setTitle("Select Picture", for: .normal)
        selectLibraryImageButton.setTitleColor(.blue, for: .normal)
        selectLibraryImageButton.addTarget(self, action: #selector(selectPictureFromLibrary), for: .touchUpInside)
        view.addSubview(selectLibraryImageButton)
        
        selectedImageView = UIImageView(frame: CGRect(x: view.frame.width/2, y: 250, width: view.frame.width/2 - 25, height: 150))
        selectedImageView.contentMode = .scaleAspectFit
        view.addSubview(selectedImageView)
        
        datePicker = UIDatePicker(frame: CGRect(x: 30, y: view.frame.height * 0.6, width: view.frame.width - 60, height: 200))
        view.addSubview(datePicker)
        
        submitButton = UIButton(frame: CGRect(x: 30, y: view.frame.height * 0.6 + 210, width: view.frame.width - 60, height: 50))
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
    
    @objc func selectPictureFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func selectPictureFromCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func newPost() {
        if eventNameField.hasText && eventDescriptionView.hasText && selectedImage != nil {
            MKFullSpinner.show("Uploading Post", animated: true)
            FirebaseDatabaseHelper.newPostWithImage(selectedImage: selectedImage, name: eventNameField.text!, description: eventDescriptionView.text, date: datePicker.date) {
                MKFullSpinner.hide()
                self.dismiss(animated: true, completion: {
                    print("Post Complete")
                })
            }
        }
        else{
            let alertController = UIAlertController(title: "Fields Blank", message:
                "Make sure you enter all required information.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
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
