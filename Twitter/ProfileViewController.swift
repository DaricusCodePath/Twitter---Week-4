//
//  ProfileViewController.swift
//  Twitter
//
//  Created by DrDunkan on 3/2/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var tweet: Tweet!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var FollowingCount: UILabel!
    @IBOutlet weak var TweetCount: UILabel!
    @IBOutlet weak var BackgroundProfile: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWithURL(NSURL(string: tweet.user!.profileUrlString!)!)
        followersCount.text = String(tweet.user!.followersCount! as Int)
        FollowingCount.text = String(tweet.user!.followingCount! as Int)
        TweetCount.text = String(tweet.user!.TweetCount! as Int)
        BackgroundProfile.setImageWithURL(NSURL(string: tweet.user!.BackGround!)!)
        //print(tweet.user?.followersCount)
  

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
