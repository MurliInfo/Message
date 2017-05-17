//
//  FormCell.swift
//  FormDemo
//
//  Created by Hardik Davda on 5/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {

    @IBOutlet var imgProfile : UIImageView!
    @IBOutlet var title : UILabel!
    @IBOutlet var txtField : UITextField!
    @IBOutlet var imgDrop : UIImageView!
    @IBOutlet var btnDrop : UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
