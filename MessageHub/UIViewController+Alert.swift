//
//  UIViewController+Alert.swift
//  FivePGroup
//
//  Created by Nitesh Borad on 21/04/17.
//  Copyright © 2017 Technobrave Pty Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    internal func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController.alert(title: title, message: message)
        presentAlert(alert)
    }
    
    func showAlert(title: String, message: String, additionalAction: UIAlertAction) {
        let alert = UIAlertController.alert(title: title, message: message, buttonTitle: "Cancel")
        alert.addAction(additionalAction)
        presentAlert(alert)
    }
    
    func showAlert(title: String, message: String, confirmationHandler: @escaping ((Bool)-> Void)) {
        let alert = UIAlertController.alert(title: title, message: message)
        alert.addAction(title: "Yes", style: .default) { (action:UIAlertAction) in
            confirmationHandler(true)
        }
        alert.addAction(title: "No", style: .default) { (action:UIAlertAction) in
            confirmationHandler(false)
        }
        presentAlert(alert)
    }
}
