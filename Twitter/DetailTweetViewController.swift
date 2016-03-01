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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
