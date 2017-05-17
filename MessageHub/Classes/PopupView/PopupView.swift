//
//  PopupView.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/16/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class PopupView: UIView {

    @IBOutlet var view: UIView!
   
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
     //   Bundle.main.loadNibNamed("PopUp", owner: self, options: nil)
        Bundle.main.loadNibNamed("PopupView", owner: self, options: nil)
        
        self.addSubview(self.view)
        
    }
    @IBAction func Testing(_ sender: Any) {
        print("testing")

    }

}
