//
//  AllExtensions.swift
//  MessageHub
//
//  Created by Hardik Davda on 5/3/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func setBorderPadding() {
        self.layer.cornerRadius = 5.0
//        self.layer.borderWidth = 2.0
//        self.layer.borderColor = UIColor().textFieldBackgroundColor().cgColor
        self.backgroundColor = UIColor().textFieldBackgroundColor()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        self.leftView=paddingView;
        self.leftViewMode = UITextFieldViewMode.always
    }
    func removeBorderPadding() {
        self.layer.cornerRadius = 10.0
        self.backgroundColor = .clear
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        self.leftView=paddingView;
        self.leftViewMode = UITextFieldViewMode.always
    }
    
}

extension Date {
    func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension UIColor{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    //var lineColor : UIColor {return GlobalMethods().hexStringToUIColor(hex: "F7F7F7")}
    func lineColor() -> UIColor {
        return self.hexStringToUIColor(hex: "F7F7F7")
    }
    
    func textFieldBackgroundColor() -> UIColor {
        return self.hexStringToUIColor(hex: "EFEFEF")
    }
    
    func selectTintColor() -> UIColor {
        return self.hexStringToUIColor(hex: "666666")
    }
    
    func tintColor() -> UIColor {
        return self.hexStringToUIColor(hex: "3F51B5")
    }
    
    func orangColor() -> UIColor {
        return self.hexStringToUIColor(hex: "FE6902")
    }
    
    func greenColor() -> UIColor {
        return self.hexStringToUIColor(hex: "388E3C")
    }
    
    func dateColor() -> UIColor {
        return self.hexStringToUIColor(hex: "737373")
    }
    
    func selectCellColor() -> UIColor {
        return self.hexStringToUIColor(hex: "E0E0E0")
    }
    func yelloColor() -> UIColor {
        return self.hexStringToUIColor(hex: "FFA000")
    }
    // AAF000
}
