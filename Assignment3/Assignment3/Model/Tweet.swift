//
//  Tweet.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit
import Social

class Tweet: NSObject {
    var id:Int?
    var userPosted:User?
    var text:String?
    var timestamp:String?
    var retweetCount:Int = 0
    var favoriteCount:Int = 0
    var favorited:Bool?
    var retweeted:Bool?
    
    init(dict:NSDictionary) {
        id = dict["id"] as? Int
        text = dict["text"] as? String
        retweetCount = (dict["retweet_count"] as! Int) ?? 0
        favoriteCount = (dict["favorite_count"] as! Int) ?? 0
        favorited = dict["favorited"] as? Bool
        retweeted = dict["retweeted"] as? Bool
        let timeString = dict["created_at"] as? String
        if let timeString = timeString{
            
            timestamp = timeString
        }
        let user = dict["user"] as? NSDictionary
        if let user = user{
            userPosted = User(dict: user)
        }
        
    }
    
    class func tweetFromArray(dicts:[NSDictionary]) -> [Tweet]{
        var tweets:[Tweet] = []
        for dict in dicts{
            let tweet = Tweet(dict: dict)
            tweets.append(tweet)
        }
        return tweets
    }
    
    func parseTwitterDate(twitterDate:String, outputDateFormat:String)->String?{
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        
        let indate = formatter.dateFromString(twitterDate)
        let outputFormatter = NSDateFormatter()
        outputFormatter.dateFormat = "hh:mm a EEE, MM d"
        var outputDate:String?
        if let d = indate {
            outputDate = outputFormatter.stringFromDate(d)
        }
        return outputDate;
    }
}
