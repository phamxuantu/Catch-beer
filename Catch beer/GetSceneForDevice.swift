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
            return (bom: 0.065, beer: 0.25, beerGold: 0.25, heart: 0.25, coin: 0.2)
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return (bom: 0.105, beer: 0.27, beerGold: 0.27, heart: 0.29, coin: 0.22)
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return (bom: 0.12, beer: 0.32, beerGold: 0.32, heart: 0.31, coin: 0.24)
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return (bom: 0.13, beer: 0.35, beerGold: 0.35, heart: 0.35, coin: 0.25)
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return (bom: 0.18, beer: 0.5, beerGold: 0.5, heart: 0.5, coin: 0.35)
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return (bom: 0.24, beer: 0.6, beerGold: 0.6, heart: 0.6, coin: 0.4)
        default:
            return (bom: 0.19, beer: 0.5, beerGold: 0.5, heart: 0.6, coin: 0.5)
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
            return 0.42
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return 0.42
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return 0.5
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return 0.55
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return 0.95
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return 1.3
        default:
            return 1
        }
    }
    
    func getFontCoin(deviceName: String) -> (low: CGFloat, high: CGFloat) {
        switch deviceName {
        case "iPhone 4s":
            return (low: 18, high: 15)
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return (low: 21, high: 16)
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return (low: 21, high: 16)
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return (low: 25, high: 20)
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return (low: 43, high: 36)
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return (low: 47, high: 38)
        default:
            return (low: 47, high: 38)
        }
    }
    
    func getFontUserSetting(deviceName: String) -> CGFloat {
        switch deviceName {
        case "iPhone 4s":
            return 13
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return 14
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return 18
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return 19
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return 30
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return 55
        default:
            return 40
        }
    }
    
    
    func getSizeForPlayerProtected(deviceName: String) -> (width: CGFloat, height: CGFloat) {
        switch deviceName {
        case "iPhone 4s":
            return (width: 97, height: 97)
        case "iPhone 5", "iPhone 5s", "iPhone 5c", "iPhone SE", "iPod Touch 5", "iPod Touch 6":
            return (width: 110, height: 110)
        case "iPhone 6", "iPhone 6s", "iPhone 7", "iPhone 8":
            return (width: 120, height: 120)
        case "iPhone 6 Plus", "iPhone 6s Plus", "iPhone 7 Plus", "iPhone 8 Plus", "iPhone X":
            return (width: 130, height: 130)
        case "iPad 2", "iPad 3", "iPad 4", "iPad 5", "iPad Air", "iPad Air 2", "iPad Pro 9.7 Inch":
            return (width: 160, height: 160)
        case "iPad Pro 12.9 Inch", "iPad Pro 12.9 Inch 2. Generation", "iPad Pro 10.5 Inch":
            return (width: 160, height: 160)
        default:
            return (width: 145, height: 145)
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
