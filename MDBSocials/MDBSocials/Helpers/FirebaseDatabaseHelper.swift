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
    
    static func newPostWithImage(selectedImage: UIImage, name: String, description: String, date: Date, completion: @escaping ()->()){
        let data = UIImagePNGRepresentation(selectedImage)!
        let imageRef = Storage.storage().reference().child("postImages/" + name.trimmingCharacters(in: .whitespaces) + ".png")
        
        let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("Error uploading")
                return
            }
            let downloadURL = String(describing: metadata.downloadURL()!)
            print(downloadURL)
            newPost(name: name, description: description, pictureURL: downloadURL, date: date, completion: completion)
        }
    }
    
    static private func newPost(name: String, description: String, pictureURL: String, date: Date, completion: @escaping ()->()) {
        let posterId = FirebaseAuthHelper.getCurrentUser()?.uid
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy at h:mm a"
        let dateString = dateFormatter.string(from: date)
        let postsRef = Database.database().reference().child("Posts")
        let newPost = ["name": name, "pictureURL": pictureURL, "posterId": posterId!, "description": description, "date": dateString] as [String : Any]
        let key = postsRef.childByAutoId().key
        let childUpdates = ["/\(key)/": newPost]
        postsRef.updateChildValues(childUpdates)
        print("Post created!")
        completion()
    }
    
    static func fetchPosts(withBlock: @escaping ([Post]) -> ()){
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            withBlock([post])
            
        })
    }
    
}
