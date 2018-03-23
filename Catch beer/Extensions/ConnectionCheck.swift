//
//  ConnectionCheck.swift
//  Catch beer
//
//  Created by phuongpro Imac on 3/10/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import Foundation
import Alamofire

public class NetworkManager {
    
    //shared instance
    static let shared = NetworkManager()
    
    var isconnected: Bool = false
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    
    func startNetworkReachabilityObserver() {
        
        
        reachabilityManager?.listener = { status in
            switch status {

            case .notReachable:
                print("The network is not reachable")
                MainMenuScene.sharedInstance.view?.makeToast("You are not conected internet", duration: 1.5, position: .bottom)
            case .unknown :
                print("It is unknown whether the network is reachable")
                MainMenuScene.sharedInstance.view?.makeToast("You are not conected internet", duration: 1.5, position: .bottom)
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                MainMenuScene.sharedInstance.handleGetUserInfo()
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                MainMenuScene.sharedInstance.handleGetUserInfo()
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
        
    }
}
