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
    
    func getScaleItem(deviceName: String) -> (bom: CGFloat, beer: CGFloat, beerGold: CGFloat, heart: CGFloat, coin: CGFloat) {
        switch deviceName {
        case "iPhone 4s":
            return (bom: 0.065, beer: 0.25, beerGold: 0.25, heart: 0.25, coin: 0.25)
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return (bom: 0.08, beer: 0.3, beerGold: 0.3, heart: 0.3, coin: 0.3)
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return (bom: 0.1, beer: 0.35, beerGold: 0.35, heart: 0.4, coin: 0.4)
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return (bom: 0.11, beer: 0.4, beerGold: 0.4, heart: 0.45, coin: 0.43)
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return (bom: 0.17, beer: 0.6, beerGold: 0.6, heart: 0.7, coin: 0.6)
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return (bom: 0.23, beer: 0.8, beerGold: 0.8, heart: 0.8, coin: 0.8)
        default:
            return (bom: 0.18, beer: 0.6, beerGold: 0.6, heart: 0.8, coin: 0.68)
        }
    }
    
    func getScaleSetting(deviceName: String) -> (x: CGFloat, y: CGFloat) {
        switch deviceName {
        case "iPhone 4s":
            return (x: 0.4, y: 0.4)
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return (x: 0.533, y: 0.667)
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return (x: 0.711, y: 0.727)
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return (x: 0.711, y: 0.733)
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return (x: 1.244, y: 1.067)
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return (x: 1.778, y: 1.467)
        default:
            return (x: 1, y: 1)
        }
    }
    
    func getScaleHighScore(deviceName: String) -> CGFloat {
        switch deviceName {
        case "iPhone 4s":
            return 0.35
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return 0.37
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return 0.43
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return 0.48
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return 0.75
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return 1
        default:
            return 0.87
        }
    }
    
    func getScaleShop(deviceName: String) -> CGFloat {
        switch deviceName {
        case "iPhone 4s":
            return 0.35
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return 0.37
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return 0.5
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return 0.48
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return 0.95
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return 1
        default:
            return 0.87
        }
    }

    
//    func getPadding(deviceName: String) -> CGFloat {
//        switch deviceName {
//        case "iPhone 4s":
//            return 0
//        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
//            return 0
//        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
//            return 40
//        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
//            return 0
//        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
//            return 0
//        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
//            return 0
//        default:
//            return 0
//        }
//    }
}
