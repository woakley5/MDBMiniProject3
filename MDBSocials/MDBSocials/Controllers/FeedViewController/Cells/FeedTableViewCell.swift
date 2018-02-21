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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 200, height: contentView.frame.height - 20))
        mainImageView.clipsToBounds = true
        mainImageView.contentMode = .scaleAspectFit
        addSubview(mainImageView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
