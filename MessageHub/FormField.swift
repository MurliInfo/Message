//
//  FormField.swift
//  FormDemo
//
//  Created by Hardik Davda on 5/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import Foundation
import UIKit

struct Forms {
    var strTitle : NSString
    var strPlaceHolder : NSString
    var strValue : NSString
    var strSelectedValue : NSString
    var isButton : Bool
    var imgDropdown : UIImage
    var rowNumber : Int
    var strParameter : NSString
}

struct FormsMultiple {
    var array : [Forms]
    var strTitleSection : NSString
}
