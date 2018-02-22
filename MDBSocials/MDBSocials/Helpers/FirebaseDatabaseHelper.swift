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
    
    static var postsRef = Database.database().reference()
    
    static func newPostWithImage(selectedImage: UIImage, name: String, description: String, date: Date, completion: @escaping ()->()){
        let data = UIImagePNGRepresentation(selectedImage)!
        let imageRef = Storage.storage().reference().child("postImages/" + name.trimmingCharacters(in: .whitespaces) + ".png")
        
        imageRef.putData(data, metadata: nil) { (metadata, error) in
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
        dateFormatter.dateFormat = "MMM d, h:mm a"
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
        postsRef.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            withBlock([post])
        })
    }
    
    static func removeObserversForPostRef(){
        postsRef.removeAllObservers()
    }
    
    static func createNewUser(name: String, username: String, email: String, completionBlock: @escaping () -> ()) {
        let usersRef = Database.database().reference().child("User")
        let newUser = ["name": name, "username": username, "email": email] as [String : Any]
        let childUpdates = ["/\(String(describing: FirebaseAuthHelper.getCurrentUser()!.uid))/": newUser]
        usersRef.updateChildValues(childUpdates)
        completionBlock()
    }
    
    static func getUserWithId(id: String, withBlock: @escaping (UserModel) -> ()) {
        let usersRef = Database.database().reference().child("User")
        usersRef.child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let user = UserModel(id: id, username: (value?["username"] as? String)!, name: (value?["name"] as? String)!, email: (value?["email"] as? String)!)
            withBlock(user)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func updateInterested(postId: String, userId: String, withBlock: () -> ()){
        let postRef = Database.database().reference().child("Posts").child(postId).child("Interested")
        let newInterestedUser = [postRef.childByAutoId().key: userId] as [String : Any]
        postRef.updateChildValues(newInterestedUser)
        withBlock()
    }
    
    static func getInterestedUsers(postId: String, withBlock: @escaping ([String]) -> ()){
        let ref = Database.database().reference()
        ref.child("Posts").child(postId).child("Interested").observeSingleEvent(of: .value, with: { (snapshot) in
            var users: [String] = []
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let value = snap.value as! String
                users.append(value)
            }
            withBlock(users)
        })
    }
}
