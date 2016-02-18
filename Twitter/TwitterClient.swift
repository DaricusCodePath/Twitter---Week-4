//
//  TwitterClient.swift
//  Twitter
//
//  Created by DrDunkan on 2/15/16.
//  Copyright © 2016 Daricus Duncan. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


let twitterConsumerKey = "AwvzOdrWDL4ZGDUpgulzdYKU7"
let twitterConsumerSecret = "JzcM0JuFbUmmH8KGetCuJRuwfI5NLGiFLK6MKbj9mzHhPxfwgj"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient{
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }

}
