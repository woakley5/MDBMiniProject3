//
//  FirebaseDatabaseHelper.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/20/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

class FirebaseDatabaseHelper {
    
    static func newPostWithImage(selectedImage: UIImage, name: String, description: String, date: Date){
        let data = UIImagePNGRepresentation(selectedImage)!
        
        let imageRef = Storage.storage().reference().child("postImages/" + name.trimmingCharacters(in: .whitespaces) + ".png")
        
        let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("Error uploading")
                return
            }
            let downloadURL = String(describing: metadata.downloadURL()!)
            print(downloadURL)
            newPost(name: name, description: description, pictureURL: downloadURL, date: date)
        }
    }
    
    static func newPost(name: String, description: String, pictureURL: String, date: Date) {
        let posterId = FirebaseAuthHelper.getCurrentUser()?.uid
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let dateString = dateFormatter.string(from: date)
        let postsRef = Database.database().reference().child("Posts")
        let newPost = ["name": name, "pictureURL": pictureURL, "posterId": posterId!, "description": description, "date": dateString, "interested": 0] as [String : Any]
        let key = postsRef.childByAutoId().key
        let childUpdates = ["/\(key)/": newPost]
        postsRef.updateChildValues(childUpdates)
        print("Post created!")
    }
    
    func downloadPicture(withURL: String){
        
    }
    
    func getPosts(){
        
    }

}
