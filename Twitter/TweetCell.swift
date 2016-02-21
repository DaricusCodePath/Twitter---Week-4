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
        //  nameLabel.text = "@" + ((User.currentUser?.screenname)! as String)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
