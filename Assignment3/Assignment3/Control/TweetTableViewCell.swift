//
//  TweetTableViewCell.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var id:Int?
    var tweet:Tweet?{
        didSet{
            id = tweet?.id
            avatar.setImageWithURL((tweet?.userPosted?.profileURL)!)
            name.text = tweet?.userPosted?.name
            let strDate = tweet?.timestamp
            timestamp.text = tweet?.parseTwitterDate(strDate!, outputDateFormat: "EEE, MM dd")
            content.text = tweet?.text
            btnFavorite.selected = (tweet?.favorited)!

            
        }
    }
    
    @IBOutlet weak var btnRetweet: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBAction func btnReply(sender: AnyObject) {
    }
    
    @IBAction func btnRetweet(sender: AnyObject) {
        btnRetweet.selected = !btnRetweet.selected
        let isCreate:Bool =  btnRetweet.selected
        TwitterClient.shareInstance.retweetTweet(isCreate,id: id!) { (error) in
            if( error  == nil){
                
            }else{
                print("error")
            }
        }
    }
    
    @IBAction func btnFavorite(sender: AnyObject) {
        btnFavorite.selected = !btnFavorite.selected
        var isCreate:Bool =  btnFavorite.selected
        TwitterClient.shareInstance.favoriteTweet(isCreate,id: id!) { (error) in
            if( error  == nil){
                
            }else{
                print("error")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnFavorite.setImage(UIImage(named:"favorite" ), forState: .Normal)
        btnFavorite.setImage(UIImage(named:"liked" ), forState: .Selected)
        
        btnRetweet.setImage(UIImage(named:"retweet" ), forState: .Normal)
        btnRetweet.setImage(UIImage(named:"retweeted" ), forState: .Selected)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
