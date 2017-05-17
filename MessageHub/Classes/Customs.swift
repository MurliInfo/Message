//
//  Customs.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//


import Foundation

struct Form{
    var lblTitle : UILabel!
    var txtInput : UITextField!
    var plaseHolder : String!
    var imgDropdown : UIImage!
}

struct ProfileForm{
    var Title : String!
    var Star : String!
    var Placeholder : String!
}

struct LoginData{
    var Name : String!
    var Full_Name : String!
    var User_Id : String!
    var User_Provider_Id : String!
    var User_Email : String!
    var User_Type : String!
    var User_Profile_logo : String!
    var User_Status : String!
    var Token : String!
     var status : Bool!
}

struct CallDetailData{
    var CD_Id : String!
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
    var Cd_Notes_Count : String!
    var SELECTED : Int!
//    CD_KPI
//    CD_Created_Date
//    CD_Email
//    CD_From
//    CD_id
//    CD_Is_Overdue
//    CD_Phone_number
//    CD_Provider_Id
//    CD_Reason_For_Call
//    CD_Status
//    CD_User_Id
//    Modified_By
//    PRV_Abbr
//    PRV_Abbr_Color
//    PRV_Kpi_Limit
//    PRV_Name
//    PRV_Timezone
//    Responsible_Person
}

struct GetCC{
    var CC_Id : String
    var CC_Address : String
}

struct DropDownListData{
    var Drp_Id : String!
    var Drp_StateId : String!
    var Drp_Name : String!
}

struct ProviderListData{
    var PRV_Id : String!
    var PRV_Name : String!
}
struct ResponsiblePersonListData{
    var RP_Id : String!
    var RP_Name : String!
}
struct StatusListData{
    var ST_Id : String!
    var ST_Name : String!
}

struct GetCallData{
    var CD_Reason_For_Call : String!    //"cd_reason_for_call": "Test",
    var Provider_Name : String!         //"provider_name": "Capitol Asset Management"
    var CC_Email_Address : String!      //"cc_email_address": null
    var CD_Id : String!                 //"cd_id": "8",
    var CD_From : String!               //"cd_from": "Bhavin Solanki",
    var CD_Phone_Number : String!       //"cd_phone_number": "7418259633",
    var CD_Email : String!              //"cd_email": "bhavin@technobrave.com",
    var CD_Provider_Id : String!        //"cd_provider_id": "1",
    var CD_User_Id : String!            //"cd_user_id": "55",
    var CD_Status : String!             //"cd_status": "2",
    var Responsible_Person : String!    //"responsible_person": "Ashleigh Naglewicz",
    
}

struct UserListData{
   var User_Id : String!                //    "user_id": "28",
   var User_Fname : String!             //    "user_fname": "jignesh",
   var User_Lname : String!             //    "user_lname": "panchal",
   var User_Phone_No : String!          //    "user_phone_no": "9601199220",
    var User_Office_No : String!
   var User_Provider_Id : String!       //    "user_provider_id": "0",
   var User_Email : String!             //     "user_email": "jignesh@technobrave.com",
   var User_Type : String!              //    "user_type": "1",
   var User_Profile_Logo : String!      //    "user_profile_logo":
   var User_Street_No : String!         //    "user_street_no": "45",
   var User_Street_Name : String!       //    "user_street_name": "we",
   var User_Street_Road_Id : String     //    "user_street_road_id": "2",
   var User_State_Id : String!          //    "user_state_id": "1",
   var User_City_Id : String!           //    "user_city_id": "13230",
   var User_Zip_Code : String!          //    "user_zip_code": "369852",
   var User_Address : String!           //    "user_address": "",
   var User_Modified_Date : String!     //    "user_modified_date": "2016-06-28 02:54:32",
   var User_Type_Name : String!         //    "user_type_name": "Admin",
   var Provider_Abbr : String!          //    "provider_abbr": "AG",
   var Prv_Abbr_Color : String!         //    "prv_abbr_color": "#93C73F",
   var User_Status_Name : String!       //    "user_status_name": "Active",
   var User_Status : String!            //    "user_status": "1",
   var Modify_By : String!              //    "modify_by": "Kamlesh Gupta 1"
    var SELECTED : Int!
    var Is_Checked : Bool                 //  "is_checked": false
}

struct ProviderDetailListData{
    var PRV_Id : String!                // "prv_id": "1",
    var PRV_Name : String!             //"prv_name": "Capitol Asset Management",
    var PRV_Abbr : String!              //"prv_abbr": "CAM",
    var PRV_Abbr_Color : String!        //	    "prv_abbr_color": "#FF951B",
    var PRV_Type : String!              //"prv_type": "Property Management",
    var PRV_Kpi_Limit : String!         //  "prv_kpi_limit": "00:30:00",
    var Timezone_Name : String!         // "timezone_name": "Australia/Perth",
    var PRV_Address : String!           //"prv_address": "",
    var PRV_Company_Email : String!     //  "prv_company_email": "support@capitolwa.com.au",
    var PRV_Company_Website : String!	//    "prv_company_website": "www.capitolwa.com.au",
    var PRV_Description : String!       // "prv_description": "",
    var Modify_By : String!             //"modify_by": "Kamlesh Gupta 1",
    var PRV_Modified_Date : String!     //    "prv_modified_date": "2017-02-15 02:22:59",
    var User_Street_No : String!         //    "user_street_no": "45",
    var User_Street_Name : String!       //    "user_street_name": "we",
    var User_Street_Road_Id : String     //    "user_street_road_id": "2",
    var User_State_Id : String!          //    "user_state_id": "1",
    var User_City_Id : String!           //    "user_city_id": "13230",
    var User_Zip_Code : String!          //    "user_zip_code": "369852",
    var Is_Checked : Bool                 //  "is_checked": false
//    var PRV_Modified_Date : String!     //    "user_street_no": "",
//    var PRV_Modified_Date : String!     //    "user_street_name": "",
//    var PRV_Modified_Date : String!     //    "user_street_road_id": "86",
//    var PRV_Modified_Date : String!     //    "user_state_id": "0",
//    var PRV_Modified_Date : String!     //    "user_city_id": "0",
//    var PRV_Modified_Date : String!     //    "user_zip_code": "",
    var PRV_Status : String!            //"prv_status": "In Active
    var SELECTED : Int!
}

struct GetNote{
    var NT_id : String!
    var NT_Call_Id : String!
    var NT_Type : String!
    var NT_Desc : String!
    var Added_By : String!
    var NT_Added_Date : String!
    var User_Profile_Logo : String!
    var Notes_Files : NSArray!
}

struct Macro{
    var MAC_Name : String!
    var MAC_Description : String!
    var MAC_Id : String!
}

