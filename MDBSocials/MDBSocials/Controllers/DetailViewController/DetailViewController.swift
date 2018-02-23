//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/19/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit
import CoreGraphics

class DetailViewController: UIViewController {
    
    var post: Post!
    
    var firstBlockView: UIView!
    var mainImageView: UIImageView!
    
    var secondBlockView: UIView!
    var descriptionLabel: UILabel!
    var posterNameLabel: UILabel!

    var thirdBlockView: UIView!
    var interestedButton: UIButton!
    var interestedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFirstBlock()
        setupSecondBlock()
        setupThirdBlock()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = post.eventName!
        mainImageView.image = post.image ?? UIImage(named: "defaultImage")
        setInterestedButtonState()
        populateLabelInfo()
    }
    
    func setupFirstBlock(){
        firstBlockView = UIView(frame: CGRect(x: 15, y: 85, width: view.frame.width - 30, height: 200))
        firstBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        firstBlockView.layer.cornerRadius = 10
        view.addSubview(firstBlockView)
        
        mainImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: firstBlockView.frame.width - 20, height: firstBlockView.frame.height - 20))
        mainImageView.contentMode = .scaleAspectFit
        firstBlockView.addSubview(mainImageView)
    }
    
    func setupSecondBlock(){
        secondBlockView = UIView(frame: CGRect(x: 15, y: 310, width: view.frame.width - 30, height: 150))
        secondBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        secondBlockView.layer.cornerRadius = 10
        view.addSubview(secondBlockView)
        
        posterNameLabel = UILabel(frame: CGRect(x: 15, y: 5, width: view.frame.width - 30, height: 30))
        posterNameLabel.textAlignment = .left
        posterNameLabel.textColor = .white
        secondBlockView.addSubview(posterNameLabel)
        
        let divider = UIView(frame: CGRect(x: 15, y: 40, width: secondBlockView.frame.width - 30, height: 3))
        divider.backgroundColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        secondBlockView.addSubview(divider)
        
        descriptionLabel = UILabel(frame: CGRect(x: 15, y: 40, width: secondBlockView.frame.width - 30, height: secondBlockView.frame.height - 40))
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        secondBlockView.addSubview(descriptionLabel)
    }
    
    func setupThirdBlock(){
        thirdBlockView = UIView(frame: CGRect(x: 15, y: 480, width: view.frame.width - 30, height: 125))
        thirdBlockView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        thirdBlockView.layer.cornerRadius = 10
        view.addSubview(thirdBlockView)
        
        interestedLabel = UILabel(frame: CGRect(x: 15, y: 5, width: thirdBlockView.frame.width - 30, height: 30))
        interestedLabel.textColor = .white
        thirdBlockView.addSubview(interestedLabel)
        
        let divider = UIView(frame: CGRect(x: 15, y: 40, width: thirdBlockView.frame.width - 30, height: 3))
        divider.backgroundColor = #colorLiteral(red: 0.9885228276, green: 0.8447954059, blue: 0.2268863916, alpha: 1)
        thirdBlockView.addSubview(divider)

        interestedButton = UIButton(frame: CGRect(x: thirdBlockView.frame.width/2 - 90, y: 60, width: 180, height: 50))
        interestedButton.addTarget(self, action: #selector(tappedInterested), for: .touchUpInside)
        interestedButton.layer.cornerRadius = 10
        thirdBlockView.addSubview(interestedButton)
        
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
            interestedButton.setTitle("Im Already Interested", for: .normal)
            interestedButton.setTitleColor(.darkGray, for: .normal)
            interestedButton.backgroundColor = .clear
            interestedButton.isUserInteractionEnabled = false
        }
        else{
            interestedButton.setTitle("I'm Interested!", for: .normal)
            interestedButton.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
            interestedButton.backgroundColor = .white
            interestedButton.isUserInteractionEnabled = true
        }
    }
    
    @objc func tappedInterested(){
        FirebaseDatabaseHelper.updateInterested(postId: post.id!, userId: (FirebaseAuthHelper.getCurrentUser()?.uid)!) {
            print("Updated interested")
            interestedButton.setTitle("Already Interested", for: .normal)
            interestedButton.setTitleColor(.darkGray, for: .normal)
            interestedButton.isUserInteractionEnabled = false
            post.interestedIds.append((FirebaseAuthHelper.getCurrentUser()?.uid)!)
            interestedLabel.text = "Members Interested: " + String(describing: post.interestedIds.count)
        }
    }
}
