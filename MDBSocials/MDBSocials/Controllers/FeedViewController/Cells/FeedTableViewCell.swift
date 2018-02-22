//
//  FeedTableViewCell.swift
//  MDBSocials
//
//  Created by Will Oakley on 2/20/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    var mainImageView: UIImageView!
    var eventNameLabel: UILabel!
    var posterNameLabel: UILabel!
    var interestedLabel: UILabel!
    var activityIndicator: UIActivityIndicatorView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 40, y: contentView.frame.height/2 - 20, width: 40, height: 40))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = (UIColor (white: 0.3, alpha: 0.8))
        activityIndicator.layer.cornerRadius = 5
        addSubview(activityIndicator)
        
        mainImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 120, height: contentView.frame.height - 20))
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFit
        addSubview(mainImageView)
        
        eventNameLabel = UILabel(frame: CGRect(x: 140, y: 10, width: contentView.frame.width - 140, height: 30))
        eventNameLabel.font = UIFont(name: "Helvetica Bold", size: 20)
        addSubview(eventNameLabel)
        
        posterNameLabel = UILabel(frame: CGRect(x: 140, y: 40, width: contentView.frame.width - 140, height: 20))
        posterNameLabel.font = UIFont(name: "Helvetica", size: 12)
        addSubview(posterNameLabel)
        
        interestedLabel = UILabel(frame: CGRect(x: 140, y: 60, width: contentView.frame.width - 140, height: contentView.frame.height - 60))
        addSubview(interestedLabel)
    }

    func startLoadingView() {
        activityIndicator.startAnimating()
    }
    
    func stopLoadingView() {
        activityIndicator.stopAnimating()
    }

}
