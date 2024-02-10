//
// Copyright (c) 2023 Luminary Mindset All rights reserved.
//

import Foundation
import UIKit
import StoreKit

enum PKIAPHandlerAlertType {
    case setProductIds
    case disabled
    case restored
    case purchased
    
    var message: String{
        switch self {
        case .setProductIds: return "Product ids not set, call setProductIds method!"
        case .disabled: return "Purchases are disabled in your device!"
        case .restored: return "You've successfully restored your purchase!"
        case .purchased: return "You've successfully bought this purchase!"
        }
    }
}

class PKIAPHandler: NSObject {
    
    //MARK:- Shared Object
    //MARK:-
    static let shared = PKIAPHandler()
    private override init() { }
    
    //MARK:- Properties
    //MARK:- Private
    fileprivate var productIds = [String]()
    fileprivate var productID = ""
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var fetchProductCompletion: (([SKProduct])->Void)?
    
    fileprivate var productToPurchase: SKProduct?
    public var purchaseProductCompletion: ((PKIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)?
    
    //MARK:- Public
    var isLogEnabled: Bool = true
    
    //MARK:- Methods
    //MARK:- Public
    
    //Set Product Ids
    func setProductIds(ids: [String]) {
        self.productIds = ids
    }
    
    //MAKE PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    //SETUP PURCHASE
    func purchase(product: SKProduct, completion: @escaping ((PKIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)) {
        self.purchaseProductCompletion = completion
        self.productToPurchase = product
        
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            log("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        } else {
            completion(PKIAPHandlerAlertType.disabled, nil, nil)
        }
    }
    
    // RESTORE PURCHASE
    func restorePurchase(){
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // FETCH AVAILABLE IAP PRODUCTS
    func fetchAvailableProducts(completion: @escaping (([SKProduct])->Void)){
        self.fetchProductCompletion = completion
        if self.productIds.isEmpty {
            log(PKIAPHandlerAlertType.setProductIds.message)
        } else {
            productsRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
            productsRequest.delegate = self
            productsRequest.start()
        }
    }
    
    //MARK:- Private
    fileprivate func log <T> (_ object: T) {
        if isLogEnabled {
            print("\(object)")
        }
    }
    
    //MARK:- Cancel Purchase
    func cancelPurchase() {
        let transactions = SKPaymentQueue.default().transactions
        for transaction in transactions {
            if transaction.transactionState == .deferred {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    /// To refresh receipt for the user
    func refreshReceipt() {
        let request = SKReceiptRefreshRequest()
        request.delegate = self
        request.start()
    }
}

//MARK:- Product Request Delegate and Refresh Receipt Methods
extension PKIAPHandler: SKRequestDelegate {
    
    // RECEIPT REFRESHED DID FINISH METHODS
    func requestDidFinish(_ request: SKRequest) {
        // Receipt refreshed, you can process the receipt data
        // to get information about past purchases.
        print("Receipt is refreshed.")
    }
    
    // RECEIPT ERROR METHODS
    func request(_ request: SKRequest, didFailWithError error: Error) {
        // Handle error during receipt refresh
        print("Receipt is refreshed failed.")
    }
}

//MARK:- Product Request Delegate and Payment Transaction Methods
extension PKIAPHandler: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    // REQUEST IAP PRODUCTS
    func productsRequest (_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
            if let completion = self.fetchProductCompletion {
                completion(response.products)
            }
        } else {
            DispatchQueue.main.async {
                makeToast(type: .info, title: APP_TITLE, message: "Invalid product identifiers.")
            }
        }
    }
    
    // COMPLETED TRANSACTIONS FINISHED
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if let completion = self.purchaseProductCompletion {
            completion(PKIAPHandlerAlertType.restored, nil, nil)
        }
    }
    
    // IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction: AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    log("Product purchase completed.")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    if let completion = self.purchaseProductCompletion {
                        completion(PKIAPHandlerAlertType.purchased, self.productToPurchase, trans)
                    }
                    break
                    
                case .failed:
                    log("Product purchase failed.")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                case .restored:
                    log("Product restored.")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }
            }
        }
    }
    
    /// Verify purchase for In App Purchase for the server side.
    /// - Parameters:
    ///   - productIdentifier: passing product identifier.
    ///   - transaction: passing trasaction payment values.
    func verifyPurchase(productIdentifier: String, transaction: SKPaymentTransaction) {
        // Call your server to validate the purchase with Apple using the transaction and product identifier
        // Ensure that you securely handle the server communication and verification logic
        // After verifying, you can unlock the purchased content
    }
}
