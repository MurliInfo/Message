//
//  MenuTableCell.swift
//  SideMenuDemo
//
//  Created by Hardik Davda on 2/23/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {

    //@IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblAbbrivationName: UILabel!
    @IBOutlet var imgIcone: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
