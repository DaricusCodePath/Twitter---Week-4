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
    
    @IBOutlet weak var favouriteLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var Faved = false
    var Tweeted = false
    
 
    var tweetID: Int = 0
    var tweet: Tweet! {
        didSet {
            
        profileView.setImageWithURL(NSURL(string: tweet.user!.profileUrlString!)!)
        usernameLabel.text = tweet.user!.name 
        nameLabel.text = "@\(tweet.user!.screenname!)"
        tweetLabel.text = tweet.text
        tweetLabel.sizeToFit()
        timeLabel.text = tweet.timeSince
        
        
            tweetID = (tweet.tweetID as? Int)!
            retweetLabel.text = String(tweet.retweetCount!)
            favouriteLabel.text = String(tweet.favouritesCount!)
            
            
            //retweetButton.setImage(UIImage(named: "retweet-action-on-pressed"), forState: .Highlighted)
            //favouriteButton.setImage(UIImage(named: "like-action-on-pressed"), forState: .Highlighted)
            
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
    
    @IBAction func onFavourite(sender: AnyObject) {
        TwitterClient.sharedInstance.favTweet(Int(tweetID), params: nil, completion: {(error) -> () in
            
            
            if (self.favouriteButton.currentImage == UIImage(named: "like-action") ) {
                self.favouriteLabel.text = String(self.tweet.favouritesCount! + 1)
                self.favouriteButton.setImage(UIImage(named: "like-action-on"), forState: .Normal)
                
            }else{
                
                self.favouriteLabel.text = String(self.tweet.favouritesCount!)
                self.favouriteButton.setImage(UIImage(named: "like-action"), forState: .Normal )
            }
            
        })
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
    TwitterClient.sharedInstance.retweet(Int(tweetID), params: nil, completion: {(error) -> () in
        
        if (self.retweetButton.currentImage == UIImage(named: "retweet-action") ) {
            self.retweetLabel.text = String(self.tweet.retweetCount! + 1)
            self.retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
            
        }else{
            
            self.retweetLabel.text = String(self.tweet.retweetCount!)
            self.retweetButton.setImage(UIImage(named: "retweet-action"), forState: .Normal )
        }
        
        
        
        
            
            

        
        
        
        
        
    })
    }
}

