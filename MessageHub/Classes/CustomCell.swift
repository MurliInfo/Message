//
//  CustomCell.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/6/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet var imgRound: UIImageView!
    @IBOutlet var imgCall: UIImageView!
    @IBOutlet var imgClock: UIImageView!
    @IBOutlet var imgIcone: UIImageView!
    
    @IBOutlet var lblAbbrivationName: UILabel!
    @IBOutlet var lblNoteCount: UILabel!
    @IBOutlet var lblAbbrivation: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblStatus: UILabel!
    @IBOutlet var lblResponcible: UILabel!
    @IBOutlet var lblKPITime: UILabel!
    @IBOutlet var lblNumber: UILabel!
    @IBOutlet var lblDescription: UILabel!
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblUserType: UILabel!
    @IBOutlet var lblModifyBy: UILabel!
    @IBOutlet var lblUserModifidDate: UILabel!
    @IBOutlet var lblUserEmail: UILabel!

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtField: UITextField!
    @IBOutlet var lblStar : UILabel!
    @IBOutlet var btnSelect : UIButton!
    @IBOutlet var btnNotes : UIButton!
    @IBOutlet var btnMakeCall : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
