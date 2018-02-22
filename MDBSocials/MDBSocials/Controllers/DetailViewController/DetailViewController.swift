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
    var descriptionLabel: UILabel!
    var posterNameLabel: UILabel!
    var interestedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupInterestedButton()
        setupDesctiptionLabel()
        setupPosterNameLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = post.eventName!
        mainImageView.image = post.image ?? UIImage(named: "defaultImage")
        setInterestedButtonState()
        populateLabelInfo()
    }
    
    func setupImageView(){
        mainImageView = UIImageView(frame: CGRect(x: 20, y: 85, width: view.frame.width - 40, height: (view.frame.width - 40) * 9/16))
        mainImageView.contentMode = .scaleAspectFit
        view.addSubview(mainImageView)
    }
    
    func setupInterestedButton(){
        interestedButton = UIButton(frame: CGRect(x: view.frame.width/2 +  20, y: view.frame.height - 75, width: view.frame.width / 2 - 20, height: 50))
        interestedButton.addTarget(self, action: #selector(tappedInterested), for: .touchUpInside)
        view.addSubview(interestedButton)
        
        interestedLabel = UILabel(frame: CGRect(x: 20, y: view.frame.height - 75, width: view.frame.width/2 - 40, height: 50))
        view.addSubview(interestedLabel)
    }
    
    func setupDesctiptionLabel(){
        descriptionLabel = UILabel(frame: CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 300))
        descriptionLabel.numberOfLines = 5
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
    }
    
    func setupPosterNameLabel(){
        posterNameLabel = UILabel(frame: CGRect(x: 20, y: 290, width: view.frame.width - 40, height: 25))
        posterNameLabel.textAlignment = .center
        view.addSubview(posterNameLabel)
    }
    
    func populateLabelInfo(){
        descriptionLabel.text = post.description
        interestedLabel.text = "Members Interested: " + String(describing: post.interestedIds.count)
        posterNameLabel.text = "Posted By: " + post.posterName!
    }
    
    func setInterestedButtonState(){
        var userHasSaidInterested = false
        for id in post.interestedIds {
            if id == FirebaseAuthHelper.getCurrentUser()?.uid {
                userHasSaidInterested = true
                break
            }
        }
        
        if userHasSaidInterested {
            interestedButton.setTitle("Already Interested", for: .normal)
            interestedButton.setTitleColor(.darkGray, for: .normal)
            interestedButton.isUserInteractionEnabled = false
        }
        else{
            interestedButton.setTitle("I'm Interested!", for: .normal)
            interestedButton.setTitleColor(.blue, for: .normal)
            interestedButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func tappedInterested(){
        FirebaseDatabaseHelper.updateInterested(postId: post.id!, userId: (FirebaseAuthHelper.getCurrentUser()?.uid)!) {
            print("Updated interested")
            interestedButton.setTitle("Already Interested", for: .normal)
            interestedButton.setTitleColor(.darkGray, for: .normal)
            interestedButton.isUserInteractionEnabled = false
        }
    }
}
