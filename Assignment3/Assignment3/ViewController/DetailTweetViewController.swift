//
//  DetailTweetViewController.swift
//  Assignment3
//
//  Created by Ngoc Do on 3/27/16.
//  Copyright © 2016 com.appable. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {

    var tweet:Tweet?
    
    @IBAction func btnback(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblRetweetsCount: UILabel!
    @IBOutlet weak var lblFavoritesCount: UILabel!
    
    
    @IBOutlet weak var btnReply: UIButton!
    
    @IBAction func btnReply(sender: AnyObject) {
    }
    
    @IBOutlet weak var btnRetweet: UIButton!
    
    @IBAction func btnRetweet(sender: AnyObject) {
    }
    @IBOutlet weak var btnFavorite: UIButton!
    
    @IBAction func btnFavortie(sender: AnyObject) {
        let id = tweet?.id
        btnFavorite.selected = !btnFavorite.selected
        let isCreate:Bool =  btnFavorite.selected
        TwitterClient.shareInstance.favoriteTweet(isCreate,id: id!) { (error) in
            if( error  == nil){
                
            }else{
                print("error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setImage()
        
    }
    
    func setImage(){
        btnFavorite.setImage(UIImage(named:"favorite" ), forState: .Normal)
        
        btnFavorite.setImage(UIImage(named:"liked" ), forState: .Selected)
        btnRetweet.setImage(UIImage(named:"retweet" ), forState: .Normal)
        btnRetweet.setImage(UIImage(named:"retweeted" ), forState: .Selected)
    }
    
    
    func loadData(){
        self.view.showLoading()
        avatar.setImageWithURL((tweet?.userPosted?.profileURL)!)
        lblName.text = tweet?.userPosted?.name
        lblLocation.text = tweet?.userPosted?.location
        let strDate = tweet?.timestamp
        lblTime.text = tweet?.parseTwitterDate(strDate!, outputDateFormat: "EEE, MM dd")
        lblText.text = tweet?.text
        lblRetweetsCount.text = "\((tweet?.retweetCount)!)"
        lblFavoritesCount.text = "\((tweet?.favoriteCount)!)"
        btnFavorite.selected = (tweet?.favorited)!
        btnRetweet.selected = (tweet?.retweeted)!
        self.view.hideLoading()
        
    }


}
