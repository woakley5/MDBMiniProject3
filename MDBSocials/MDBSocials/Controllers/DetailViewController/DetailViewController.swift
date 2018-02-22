//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var post: Post!
    var mainImageView: UIImageView!
    var interestedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainImageView = UIImageView(frame: CGRect(x: 20, y: 85, width: view.frame.width - 40, height: (view.frame.width - 40) * 9/16))
        view.addSubview(mainImageView)
        
        interestedButton = UIButton(frame: CGRect(x: 50, y: 300, width: view.frame.width - 100, height: 50))
        interestedButton.setTitle("Im Interested!", for: .normal)
        interestedButton.setTitleColor(.blue, for: .normal)
        interestedButton.addTarget(self, action: #selector(tappedInterested), for: .touchUpInside)
        view.addSubview(interestedButton)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = post.eventName!
        mainImageView.image = post.image!
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @objc func tappedInterested(){
        FirebaseDatabaseHelper.updateInterested(postId: post.id!, userId: (FirebaseAuthHelper.getCurrentUser()?.uid)!) {
            print("Updated interested")
            //post.interested?.append()
        }
    }
}
