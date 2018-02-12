//
//  GetSceneForDevice.swift
//  Catch beer
//
//  Created by Xuan Tu on 2/8/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import Foundation
import UIKit

class GetSceneForDevice {
    
    func getScene(deviceName: String) -> [String] {
        switch deviceName {
        case "iPhone 4s":
            return ["MainMenu4s", "GameplayScene4s"]
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE":
            return ["MainMenuSE", "GameplaySceneSE"]
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return ["MainMenu6s", "GameplayScene6s"]
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return ["MainMenu6sPlus", "GameplayScene6sPlus"]
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return ["MainMenuIpad97", "GameplaySceneIpad97"]
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return ["MainMenuIpad12", "GameplaySceneIpad12"]
        default:
            return ["MainMenu", "GameplayScene"]
        }
    }
    
    func getScale(deviceName: String) -> (bom: CGFloat, beer: CGFloat, beerGold: CGFloat, heart: CGFloat, coin: CGFloat) {
        switch deviceName {
        case "iPhone 4s":
            return (bom: 0.065, beer: 0.25, beerGold: 0.25, heart: 0.012, coin: 0.25)
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return (bom: 0.08, beer: 0.3, beerGold: 0.3, heart: 0.013, coin: 0.3)
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return (bom: 0.1, beer: 0.35, beerGold: 0.35, heart: 0.016, coin: 0.4)
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return (bom: 0.11, beer: 0.4, beerGold: 0.4, heart: 0.019, coin: 0.43)
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return (bom: 0.17, beer: 0.6, beerGold: 0.6, heart: 0.03, coin: 0.6)
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return (bom: 0.23, beer: 0.8, beerGold: 0.8, heart: 0.04, coin: 0.8)
        default:
            return (bom: 0.18, beer: 0.6, beerGold: 0.6, heart: 0.033, coin: 0.68)
        }
    }
}
