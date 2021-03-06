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
    var posterName: String?
    var id: String?
    var image: UIImage?
    var interestedIds: [String] = []
    
    init(id: String, postDict: [String:Any]?) {
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
            if let interestedIDs = postDict!["Interested"] {
                for (_, val) in interestedIDs as! Dictionary<String, Any>{
                    //print(String(describing: val))
                    self.interestedIds.append(String(describing: val))
                }
            }
        }
    }
    
    func getPicture(withBlock: @escaping () -> ()) {
        if self.image == nil {
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
}
