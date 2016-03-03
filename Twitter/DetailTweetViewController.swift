//
//  DetailTweetViewController.swift
//  Twitter
//
//  Created by DrDunkan on 2/22/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    var tweet: Tweet!
    var tweetID: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.user!.name
        nameLabel.sizeToFit()
        
        profileView.setImageWithURL(NSURL(string: tweet.user!.profileUrlString!)!)
        usernameLabel.text = "@\(tweet.user!.screenname!)"
        tweetLabel.text = tweet.text
        tweetLabel.sizeToFit()
        timeLabel.text = tweet.timeSince
   
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if (self.retweetButton.currentImage == UIImage(named: "retweet-action") ) {
            TwitterClient.sharedInstance.retweet(Int(self.tweetID), params: nil, completion: {(error) -> () in
            })
            self.retweetLabel.text = String(self.tweet.retweetCount! + 1)
            self.retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: .Normal)
            
        }else{
            TwitterClient.sharedInstance.unretweet(Int(self.tweetID), params: nil, completion: {(error) -> () in
            })
            self.retweetLabel.text = String(self.tweet.retweetCount!)
            self.retweetButton.setImage(UIImage(named: "retweet-action"), forState: .Normal )
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
