//
//  PaymentViewController.swift
//  Catch beer
//
//  Created by phuongpro Imac on 3/27/18.
//  Copyright © 2018 TnTechs. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
//import BraintreeDropIn
//import Braintree
import SwiftyStoreKit
//import StoreKit

class PaymentViewController: UIViewController {
    

    static var sharedInstance = PaymentViewController()
    
//    var paymentMethod : BTPaymentMethodNonce?
    
    let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    let fontCoinHigh = GetSceneForDevice().getFontCoin(deviceName: UIDevice().modelName).high
    
    @IBOutlet weak var lblTextCoinPrice: UILabel!
    

    @IBOutlet weak var paymentMethodStackView: UIStackView!
    
    
    @IBOutlet weak var btnPayment: UIButton!
    
    @IBOutlet weak var btn_PayWithApple: UIButton!
    
    let inAppPurchaseIds = ["Tntechs.Application.Catchbeer1141.Get100Coins", "Tntechs.Application.Catchbeer1141.Get500Coins", "Tntechs.Application.Catchbeer1141.Get1000Coins", "Tntechs.Application.Catchbeer1141.Get1800Coins", "Tntechs.Application.Catchbeer1141.Get2490Coins"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("payment info: \(paymentInfo)")
        
        // create loading view
        activityIndicatorView.color = UIColor.black
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        //
        if paymentInfo["text"] != nil {
            lblTextCoinPrice.text = paymentInfo["text"] as! String
        }
        
        
        paymentMethodStackView.translatesAutoresizingMaskIntoConstraints = false
        paymentMethodStackView.axis  = .horizontal
        paymentMethodStackView.spacing = 20
//        paymentMethodStackView.distribution = .equalSpacing
        paymentMethodStackView.alignment = .bottom
        
        
        // in-app purchase using swiftyStoreKit
        SwiftyStoreKit.retrieveProductsInfo([inAppPurchaseIds[paymentInfo["plan"] as! Int]]) { result in
            print("result: \(result)")
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(String(describing: result.error))")
            }
        }
        
        
        // in app purchase using my code
//        if(SKPaymentQueue.canMakePayments()) {
//            print("IAP is enabled, loading")
//
//            let productID: NSSet = NSSet(objects: inAppPurchaseIds[paymentInfo["plan"] as! Int])
//            let request: SKProductsRequest = SKProductsRequest(productIdentifiers: productID as! Set<String>)
//            request.delegate = self
//            request.start()
//        } else {
//            print("please enable IAPS")
//        }
        
    } // viewdidload

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btn_Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnPayWtihApple(_ sender: Any) {
//        print("click payment apple id")
        if let _ = defaults.string(forKey: "tokenLogin") {
            activityIndicatorView.startAnimating()
            SwiftyStoreKit.purchaseProduct(inAppPurchaseIds[paymentInfo["plan"] as! Int], quantity: 1, atomically: true) { result in
                self.activityIndicatorView.stopAnimating()
                switch result {
                case .success(let purchase):
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // edited
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                    let date_trans = dateFormatter.string(from: purchase.transaction.transactionDate!)
                    print("Purchase Success: \(purchase)")
                    print("Purchase date: \(date_trans)")
                    print("purchase transaction: \((purchase.transaction.transactionIdentifier as String?)!)")
                    self.handlePay(currency: "USD", transactionId: (purchase.transaction.transactionIdentifier as String?)!, transaction_date: date_trans)
                case .error(let error):
                    switch error.code {
                    case .unknown:
                        print("Unknown error. Please contact support")
                        self.alertError(mess: "Unknown error. Please contact support")
                    case .clientInvalid:
                        print("Not allowed to make the payment")
                        self.alertError(mess: "Not allowed to make the payment")
                    case .paymentCancelled: break
                    case .paymentInvalid:
                        print("The purchase identifier was invalid")
                        self.alertError(mess: "The purchase identifier was invalid")
                    case .paymentNotAllowed:
                        print("The device is not allowed to make the payment")
                        self.alertError(mess: "The device is not allowed to make the payment")
                    case .storeProductNotAvailable:
                        print("The product is not available in the current storefront")
                        self.alertError(mess: "The product is not available in the current storefront")
                    case .cloudServicePermissionDenied:
                        print("Access to cloud service information is not allowed")
                        self.alertError(mess: "Access to cloud service information is not allowed")
                    case .cloudServiceNetworkConnectionFailed:
                        print("Could not connect to the network")
                        self.alertError(mess: "Could not connect to the network")
                    case .cloudServiceRevoked:
                        print("User has revoked permission to use this cloud service")
                        self.alertError(mess: "User has revoked permission to use this cloud service")
                    }
                }
            }
            
        } else {
            let alert = UIAlertController(title: "Alert", message: "You need to log in to continue the payment", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                    let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.present(loginViewController, animated: true, completion: nil)
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        
        
//        for product in list {
//            let prodID = product.productIdentifier
//            if(prodID == inAppPurchaseIds[paymentInfo["plan"] as! Int]) {
//                p = product
//                buyProduct()
//            }
//        }
    }
    
    
    // in app purchase processs
    
//    var list = [SKProduct]()
//    var p = SKProduct()
//
//    func buyProduct() {
//        print("buy " + p.productIdentifier)
//        let pay = SKPayment(product: p)
//        SKPaymentQueue.default().add(self)
//        SKPaymentQueue.default().add(pay as SKPayment)
//    } //buyProduct
//
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        print("product request: \(response)")
//        let myProduct = response.products
//        print("myproduct: \(myProduct)")
//        for product in myProduct {
//            print("product added")
//            print(product.productIdentifier)
//            print(product.localizedTitle)
//            print(product.localizedDescription)
//            print(product.price)
//
//            list.append(product)
//        }
//    } //productsRequest
//
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        print("add payment")
//
//        for transaction: AnyObject in transactions {
//            let trans = transaction as! SKPaymentTransaction
//            print(trans.error ?? "error")
//
//            switch trans.transactionState {
//            case .purchased:
//                print("buy ok, unlock IAP HERE")
//                print(p.productIdentifier)
//
//                let prodID = p.productIdentifier
//                switch prodID {
//                case inAppPurchaseIds[paymentInfo["plan"] as! Int]:
//                    print("add coins to account")
//                default:
//                    print("IAP not found")
//                }
//                queue.finishTransaction(trans)
//            case .failed:
//                print("buy error")
//                queue.finishTransaction(trans)
//                break
//            default:
//                print("Default")
//                break
//            }
//        }
//    } //paymentQueue
//
//    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
//        print("transactions restored")
//        for transaction in queue.transactions {
//            let t: SKPaymentTransaction = transaction
//            let prodID = t.payment.productIdentifier as String
//
//            switch prodID {
//            case "Tntechs.Application.Catchbeer1141.Get100Coins":
//                print("add 100 coins to account")
//                addCoins(coins: 100)
//            default:
//                print("IAP not found")
//            }
//        }
//    } //paymentQueueRestoreCompletedTransactionsFinished
//
//    func addCoins(coins: Int) {
//        print("add coin to account in here \(coins)")
//    }
    
    /*
     // payment for braintree
    @IBAction func btn_Payment(_ sender: Any) {
        print("click payment")
        // check if login
        if let tokenLogin = defaults.string(forKey: "tokenLogin") {
            if paymentInfo["amount"] != nil {
                
                guard let paymentMethodNonce = self.paymentMethod?.nonce else {
                    showDropIn(clientTokenOrTokenizationKey: "sandbox_ymknyh5h_s4dcj49m5s2xgj32")
                    return
                }
                
                // create loading view
//                let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                activityIndicatorView.color = UIColor.black
                self.view.addSubview(activityIndicatorView)
                activityIndicatorView.frame = self.view.frame
                activityIndicatorView.center = self.view.center
                
                activityIndicatorView.startAnimating()
                
                let parameters: [String: Any] = [
                    "paymentMethodNonce" : paymentMethodNonce,
                    "amount" : paymentInfo["amount"]!,
                    "token" : tokenLogin
                ]
                createTransaction(params: parameters)
                
            } else {
                print("amount nil")
            }
        } else {
            self.view.makeToast("Please login to pay!", duration: 1.5, position: .bottom)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    
    // show dropin
    func showDropIn(clientTokenOrTokenizationKey: String) {
        print("show dronin")
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
                print(error?.localizedDescription)
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                print("payment method: ", result.paymentMethod?.nonce)
                print("payment type: ", result.paymentOptionType)
                
                self.paymentMethod = result.paymentMethod
                let selectedPaymentMethodIcon = result.paymentIcon
                let selectedPaymentMethodDescription = result.paymentDescription
                
                
                // create icon and label method embed paymentMethodStackView
                // icon
                selectedPaymentMethodIcon.widthAnchor.constraint(equalToConstant: 45).isActive = true
                selectedPaymentMethodIcon.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
                self.paymentMethodStackView.addArrangedSubview(selectedPaymentMethodIcon)
                
                // label
                let selectedPaymentMethodText = UILabel()
                selectedPaymentMethodText.numberOfLines = 0
                selectedPaymentMethodText.translatesAutoresizingMaskIntoConstraints = false
                selectedPaymentMethodText.textColor = UIColor.blue
                selectedPaymentMethodText.font = UIFont(name: "Comic Book.otf", size: 17)
                selectedPaymentMethodText.text = selectedPaymentMethodDescription
                self.paymentMethodStackView.addArrangedSubview(selectedPaymentMethodText)
                
                self.btnPayment.setTitle("Buy Now", for: .normal)
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    
    // request to server
    func createTransaction(params: [String: Any]) {
        
        print("params: ", params)
        
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/payment", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            print("respond: ", response.result.value)
            self.activityIndicatorView.stopAnimating()
            if let JSON = response.result.value as! [String: Any]? {
                print("Json respond: ", JSON)
                if JSON["state"] as? String == "Success" {
                    // do something
                    if defaults.integer(forKey: "coinCollect") < 999999 {
                        defaults.set(defaults.integer(forKey: "coinCollect") + (paymentInfo["coin"] as! Int), forKey: "coinCollect")
                        if defaults.integer(forKey: "coinCollect") > 99999 {
//                            coinCollectLabel?.fontSize = fontCoinHigh
                            MainMenuScene.sharedInstance.coinCollectLabel?.fontSize = self.fontCoinHigh
                        }
                        MainMenuScene.sharedInstance.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
                    }
                } else {
                    // show error
                    
                }
                self.view.makeToast(JSON["message"] as? String, duration: 1.5, position: .bottom)
//                self.dismiss(animated: true, completion: nil)
            } else {
                self.view.makeToast("Error, please try again later!", duration: 1.5, position: .bottom)
            }
        }
    }
    
    */
    
    
    func handlePay(currency: String, transactionId: String, transaction_date: String) {
        activityIndicatorView.startAnimating()
        var currentCoins = defaults.integer(forKey: "coinCollect")
        currentCoins += paymentInfo["coin"] as! Int
        
        // no more than 999999 coins
        if defaults.integer(forKey: "coinCollect") < 999999 {
            defaults.set(currentCoins, forKey: "coinCollect")
            if defaults.integer(forKey: "coinCollect") > 99999 {
                //                            coinCollectLabel?.fontSize = fontCoinHigh
                MainMenuScene.sharedInstance.coinCollectLabel?.fontSize = self.fontCoinHigh
            }
            MainMenuScene.sharedInstance.coinCollectLabel?.text = String(defaults.integer(forKey: "coinCollect"))
        }
        
        
        if let tokenLogin = defaults.string(forKey: "tokenLogin") {
            let parameters: Parameters = [
                "token" : tokenLogin,
                "payment_type" : "In App Purchase",
                "amount" : paymentInfo["amount"] as! Double,
                "currency": currency,
                "id_transction": transactionId,
                "total_coin": currentCoins,
                "transaction_date": transaction_date,
                "coin": paymentInfo["coin"] as! Int
            ]
            requestServerOder(prams: parameters)
            
        } // end if let tokenlogin
    } // handlePay
    
    func requestServerOder(prams: [String: Any]) {
        print("params: ", prams)
        var params = prams
        // request using alamofire
        Alamofire.request("http://103.28.38.10/~tngame/manhtu/bear/api/user/order", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { (respond) in
            print("respond order: ", respond)
            self.activityIndicatorView.stopAnimating()
            if let respondData = respond.result.value as! [String: Any]? {
                if (respondData["state"] as? String) ?? "" == "error" {
                    // check have new token login
                    if (respondData["token"] as? String) != nil {
                        // save tokenLogin to local
                        defaults.set(respondData["token"] as! String, forKey: "tokenLogin")
                        params["token"] = respondData["token"] as! String
                        self.requestServerOder(prams: params)
                    } else {
                        // show error
                        self.view.makeToast(respondData["message"] as? String, duration: 1.5, position: .bottom)
                        print(respondData["message"] ?? "null message")
                    }
                } else if (respondData["state"] as? String) ?? "" == "Success" {
                    let alert = UIAlertController(title: "Success", message: "Successful purchase", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            self.dismiss(animated: true, completion: nil)
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.present(alert, animated: true, completion: nil)
                }
            } // end if let respondData
        }
    }// end requset
    
    func alertError(mess: String) {
        let alert = UIAlertController(title: "Error!", message: mess, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
