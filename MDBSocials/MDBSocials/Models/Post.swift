//
//  Post.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/20/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class Post {
    var date: String?
    var description: String?
    var eventName: String?
    var imageUrl: String?
    var posterId: String?
    var id: String?
    var image: UIImage?
    var interested: [String]?
    
    init(id: String, postDict: [String:Any]?, successBlock: @escaping () -> ()) {
        self.id = id
        if postDict != nil {
            if let date = postDict!["date"] as? String {
                self.date = date
            }
            if let description = postDict!["description"] as? String {
                self.description = description
            }
            if let name = postDict!["name"] as? String {
                self.eventName = name
            }
            if let imageUrl = postDict!["pictureURL"] as? String {
                self.imageUrl = imageUrl
            }
            if let posterId = postDict!["posterId"] as? String {
                self.posterId = posterId
            }
            getPicture(withBlock: successBlock)
        }
    }
    
    func getPicture(withBlock: @escaping () -> ()) {
        let urlReference = Storage.storage().reference(forURL: imageUrl!)
        urlReference.getData(maxSize: 30 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error getting image")
                print(error.localizedDescription)
            } else {
                self.image = UIImage(data: data!)
                withBlock()
            }
        }
    }
}