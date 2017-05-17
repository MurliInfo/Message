//
//  UIAlertController+Helpers.swift
//  FivePGroup
//
//  Created by Nitesh Borad on 21/04/17.
//  Copyright © 2017 Technobrave Pty Ltd. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func addAction(title: String?, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        let alertAction = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(alertAction)
    }
    
    class func alert(title: String? = "", message: String, buttonTitle: String? = "Ok") -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alertController.addAction(title: buttonTitle, style: .cancel, handler: nil)
        return alertController
    }
}
