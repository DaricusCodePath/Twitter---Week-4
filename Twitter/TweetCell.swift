//
//  TweetCell.swift
//  Twitter
//
//  Created by DrDunkan on 2/20/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            
        profileView.setImageWithURL(NSURL(string: tweet.user!.profileUrlString!)!)
        usernameLabel.text = tweet.user!.name as? String
        nameLabel.text = "@\(tweet.user!.screenname!)"
        
        
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileView.layer.cornerRadius = 5
        profileView.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
