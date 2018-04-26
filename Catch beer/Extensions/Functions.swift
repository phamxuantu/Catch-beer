//
//  Functions.swift
//  Catch beer
//
//  Created by phuongpro Imac on 4/3/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import Foundation
import Alamofire

func printTest() {
    print("are you ok!")
}



func updateTokenLogin() {
    if let tokenLogin = defaults.string(forKey: "tokenLogin") {
        let parameters = [
            "token": tokenLogin
        ]
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/check-token", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
            if let responseData = respond.result.value as! [String: Any]? {
                if ((responseData["token"] as? String) != nil) {
                    print("hello updateTokenLogin")
                    defaults.set(responseData["token"] as! String, forKey: "tokenLogin")
                    MainMenuScene.sharedInstance.handleGetUserInfo()
                }
            }
        })
    }
}

func checkUpdateItem() {
    // check flag #1 is connect server update item
    if let _ = defaults.string(forKey: "tokenLogin") {
        //
        let parameters = [
            "itemBom": defaults.integer(forKey: "itemBom"),
            "itemSlow": defaults.integer(forKey: "itemSlow"),
            "itemProtect": defaults.integer(forKey: "itemProtect"),
            "itemCoin": defaults.integer(forKey: "itemCoin"),
            "itemHeart": defaults.integer(forKey: "itemHeart"),
            "best_score": defaults.integer(forKey: "bestScore"),
            "coin": defaults.integer(forKey: "coinCollect"),
            "token": defaults.string(forKey: "tokenLogin")!,
            "user_type": defaults.string(forKey: "userType") ?? "1"
            ] as [String : Any]
        
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/update-coin-item", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { (respond) in
            print("respond check update \(respond)")
            if let responseData = respond.result.value as! [String: Any]? {
                if (responseData["state"] as? String) ?? "" == "Success" {
                    defaults.set(0, forKey: "flag")
                    print("update item ssuccess")
                } else {
                    if (responseData["token"] != nil) {
                        // save tokenLogin to local
                        print("update token")
                        defaults.set(responseData["token"] as! String, forKey: "tokenLogin")
//                        MainMenuScene.sharedInstance.handleGetUserInfo()
                        checkUpdateItem()
                    } else {
                        print("update item failed")
                        defaults.set(0, forKey: "flag")
                        defaults.set(0, forKey: "itemBom")
                        defaults.set(0, forKey: "itemSlow")
                        defaults.set(0, forKey: "itemProtect")
                        defaults.set(0, forKey: "itemCoin")
                        defaults.set(0, forKey: "itemHeart")
                        defaults.set(0, forKey: "bestScore")
                        defaults.set(0, forKey: "coinCollect")
                        MainMenuScene.sharedInstance.bestScoreLabel?.text = "0"
                        MainMenuScene.sharedInstance.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                        defaults.removeObject(forKey: "tokenLogin")
                        MainMenuScene.sharedInstance.textLogin?.text = "Login"
                        MainMenuScene.sharedInstance.LogoutSocial()
                    }
                    defaults.set(1, forKey: "flag")
                }
            } else {
                defaults.set(1, forKey: "flag")
            }
        })
    }
}






