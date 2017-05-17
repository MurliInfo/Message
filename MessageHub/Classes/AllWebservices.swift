//
//  AllWebservices.swift
//  MessageHub
//
//  Created by Hardik Davda on 1/31/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
// MARK: - Declaration
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class AllWebservices: NSObject {
//     var WEBPATH : NSString
//    var IsLive = true

//    if IsLive{
//        WEBPATH = "https://retptyltd.com/phone_call/api"
//    }else{
//        WEBPATH = "https://test1.rettest.com/phone_call/api/"
//    }
//    var WEBPATH : NSString = "https://test1.rettest.com/phone_call/api/"       //Test Server
    var WEBPATH = appDelegate.WEBPATH as NSString     //Live Server

    // MARK: - Declation web Api
    
    var Web_Login: NSString
    var Web_ForgotPassword: NSString

    var Web_DashBoardDetail: NSString
    var Web_ProviderList: NSString
    var Web_ResponsiblePersonList: NSString
    var Web_AddCC: NSString
    var Web_Status: NSString
    var Web_AddCall: NSString
    var Web_CallAvailability: NSString
    var Web_GetCall: NSString
    var Web_EditCall: NSString
    var Web_AddNote: NSString
    var Web_UserList: NSString
    var Web_ProviderDetail: NSString
    var Web_StateDetail: NSString
    var Web_StreetDetail: NSString
    var Web_CityDetail: NSString
    var Web_AddUser: NSString
    var Web_Edit_User : NSString
    var Web_Provider_Type : NSString
    var Web_TimeZone : NSString
    var Web_AddProvider : NSString
    var Web_EditProvider : NSString
    var Web_GetNote : NSString
    var Web_MacroList : NSString
    var Web_CallStatus : NSString
    var Web_UserStatus : NSString
    var Web_ProviderStatus : NSString
    var Web_GetCCList: NSString
    var Web_ChangeAssignee: NSString
    //var Web_AddCC: NSString
    var Web_RemoveCC: NSString
    init(fromString string: NSString) {
        print("URl\(WEBPATH)")
       // WEBPATH  = appDelegate.WEBPATH as String
        print(appDelegate.WEBPATH)
        self.Web_Login = (WEBPATH as String) + "login" as NSString
        self.Web_ForgotPassword = (WEBPATH as String) + "forgot_password"  as NSString
        self.Web_DashBoardDetail = (WEBPATH as String) + "call_details" as NSString
        self.Web_ProviderList = (WEBPATH as String) + "provider_list" as NSString
        self.Web_ResponsiblePersonList = (WEBPATH as String) + "responsible_person_list" as NSString
        self.Web_AddCC = (WEBPATH as String) + "add_cc" as NSString
        self.Web_Status = (WEBPATH as String) + "status" as NSString
        self.Web_AddCall = (WEBPATH as String) + "add_call" as NSString
        self.Web_CallAvailability = (WEBPATH as String) + "call_availability" as NSString
        self.Web_GetCall = (WEBPATH as String) + "get_call" as NSString
        self.Web_EditCall = (WEBPATH as String) + "edit_call" as NSString
        self.Web_AddNote = (WEBPATH as String) + "add_note" as NSString
        self.Web_UserList = (WEBPATH as String) + "userlist" as NSString
        self.Web_ProviderDetail = (WEBPATH as String) + "providers" as NSString
        self.Web_StateDetail = (WEBPATH as String) + "state_list" as NSString
        self.Web_StreetDetail = (WEBPATH as String) + "street_list" as NSString
        self.Web_CityDetail = (WEBPATH as String) + "city_list" as NSString
        self.Web_AddUser = (WEBPATH as String) + "add_user" as NSString
        self.Web_Edit_User = (WEBPATH as String) + "edit_user" as NSString
        self.Web_Provider_Type = (WEBPATH as String) + "provider_type" as NSString
        self.Web_TimeZone = (WEBPATH as String) + "timezone" as NSString
        self.Web_AddProvider = (WEBPATH as String) + "add_provider" as NSString
        self.Web_EditProvider = (WEBPATH as String) + "edit_user" as NSString
        self.Web_GetNote = (WEBPATH as String) + "get_note" as NSString
        self.Web_MacroList = (WEBPATH as String) + "macros" as NSString
        self.Web_CallStatus = (WEBPATH as String) + "call_status" as NSString
        self.Web_UserStatus = (WEBPATH as String) + "user_status" as NSString
        self.Web_ProviderStatus = (WEBPATH as String) + "provider_status" as NSString
        self.Web_GetCCList = (WEBPATH as String) + "get_cc" as NSString
      //  self.Web_AddCC = (WEBPATH as String) + "add_cc" as NSString
        self.Web_RemoveCC = (WEBPATH as String) + "remove_cc" as NSString
        self.Web_ChangeAssignee = (WEBPATH as String) + "change_assignee" as NSString
      
        super.init()
    }
    
    convenience override init() {
        self.init(fromString:"Rohit") // calls above mentioned controller with default name
    }
  
    //let <#name#> = <#value#>
   // var Web_Login: NSString
}
