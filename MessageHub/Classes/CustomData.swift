//
//  CustomData.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class CustomData: NSObject {
    // MARK: - USerLogin
    var Name : String!
    var Full_Name : String!
    var User_Id : String!
    var User_Provider_Id : String!
    var User_Email : String!
    var User_Type : String!
    var User_Profile_logo : String!
    var User_Status : String!
    var Token : String!
    
    // MARK: - Dashboard Archive
    var CD_id : String!
    var CD_Email : String!
    var CD_From : String!
    var CD_Provider_Id : String!
    var CD_Phone_number : String!
    var CD_KPI : String!
    var CD_Created_Date : String!
    var CD_Reason_For_Call : String!
    var CD_User_Id : String!
    var CD_Is_Overdue : Bool!
    var CD_Status : String!
    var PRV_Name : String!
    var PRV_Abbr : String!
    var PRV_Abbr_Color : String!
    var PRV_Kpi_Limit : String!
    var PRV_Timezone : String!
    var Responsible_Person : String!
    var Modified_By : String!
    
    // MARK: - Provider
    var PRV_Id : String!
    
    // MARK: - Responcible Person
    var RP_Id : String!
    var RP_Name : String!
    
    // MARK: - Call Detail
    var CD_Reason_for_call : String!
    var Provider_Name : String!
    var CC_Email_Address : String!
    
    
    // MARK: - Call Detail
    var Status_Id : String!
    var Status :String!
    
}
