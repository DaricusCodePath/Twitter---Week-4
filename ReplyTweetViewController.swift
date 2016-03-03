//
//  ReplyTweetViewController.swift
//  Twitter
//
//  Created by DrDunkan on 2/28/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit

class ReplyTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var tweetText: UITextView!
    @IBOutlet var tweetButton: UIButton!
    @IBOutlet var characterCountLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetText.delegate = self
        
        
        
        tweetText.layer.borderWidth = 1
        tweetText.layer.cornerRadius = 8
        tweetText.layer.borderColor = UIColor .lightGrayColor().CGColor
        tweetText.insertText((tweet.user?.screenname)!)
        tweetButton.layer.cornerRadius = 2
        usernameLabel.text = tweet.user?.name
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        var len = textView.text.characters.count
        characterCountLabel.text = String(140-len)
        
        if len > 140 {
            characterCountLabel.textColor = UIColor .redColor()
            
        } else {
            characterCountLabel.textColor = UIColor .grayColor()
        }
        
    }
    @IBAction func onReply(sender: AnyObject) {
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
