//
//  GlobalMethods.swift
//  MessageHub
//
//  Created by Hardik Davda on 3/6/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
var messageFrame = UIView()
var activityIndicator = UIActivityIndicatorView()
var strLabel = UILabel()

class GlobalMethods: NSObject {
    
    func progressBarDisplayer(msg:String, _ indicator:Bool,sizeView:UIView) -> UIView {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.gray
        messageFrame = UIView(frame: CGRect(x: sizeView.frame.midX - 75, y: sizeView.frame.midY - 25 , width: 150, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 1, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            messageFrame.addSubview(activityIndicator)
        }
        messageFrame.addSubview(strLabel)
        //sizeView.addSubview(messageFrame)
        return messageFrame
    }
    
    
   
    
//    func formFill(title : String,Mendatory : String,Placeholder : String) -> ProfileForm {
//        let cmd = ProfileForm(Title: title ,
//                              Star: Mendatory ,
//                              Placeholder: Placeholder)
//        return cmd
//    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}

class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController:UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 0,y: 0,width: viewController.frame.size.width,height: viewController.frame.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        
        viewController.backgroundView = messageLabel;
        viewController.separatorStyle = .none;
    }
}

class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}

