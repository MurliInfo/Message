//
//  CustomData.swift
//  FormDemo
//
//  Created by Hardik Davda on 5/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit


class CustomForm: NSObject {
    var FormData = [Forms]()
    var FormDataProfile = [Forms]()
    var FormDataUser = [Forms]()
    var FormDataProvider = [FormsMultiple]()
    var FormDataProvider1 = [Forms]()
    var FormDataProvider2 = [Forms]()
    
    func CreateAddCall(completion:(([Forms])->())?) {
        
        let cmd = Forms(strTitle: "From *",
                        strPlaceHolder: "From * ",
                        strValue: "",
                        strSelectedValue : "",
                        isButton: false,
                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                        rowNumber: 0,
                        strParameter : "&cd_from=")
        self.FormData.append(cmd)
        
        let cmd1 = Forms(strTitle: "Phone Number *",
                         strPlaceHolder: "Phone Number * ",
                         strValue: "",
                         strSelectedValue : "",
                         isButton: false,
                         imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                         rowNumber: 1,
                         strParameter : "&cd_phone_number=")
        self.FormData.append(cmd1)
        
        let cmd2 = Forms(strTitle: "Email",
                         strPlaceHolder: "Email",
                         strValue: "",
                         strSelectedValue : "",
                         isButton: false,
                         imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                         rowNumber: 2,
                         strParameter : "&cd_email=")
        self.FormData.append(cmd2)
        
        let cmd3 = Forms(strTitle: "Customer *",
                         strPlaceHolder: "Customer * ",
                         strValue: "",
                         strSelectedValue : "",
                         isButton: true,
                         imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                         rowNumber: 3,
                         strParameter : "&cd_provider_id=")
        self.FormData.append(cmd3)
        
        let cmd4 = Forms(strTitle: "Responsible Person *",
                         strPlaceHolder: "Select Responsible Person * ",
                         strValue: "",
                         strSelectedValue : "",
                         isButton: true,
                         imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                         rowNumber: 4,
                         strParameter : "&cd_user_id=")
        self.FormData.append(cmd4)
        
        let cmd5 = Forms(strTitle: "Reason For Call *",
                         strPlaceHolder: "Reason For Call * ",
                         strValue: "",
                         strSelectedValue : "",
                         isButton: false,
                         imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                         rowNumber: 5,
                         strParameter : "&cd_reason_for_call=")
        self.FormData.append(cmd5)
        
        DispatchQueue.main.async {
            completion?(self.FormData)
        }
    }
    
    func CreateAddUser(isAgent : Bool, completion:(([FormsMultiple])->())?) {
        
        
        self.FormDataUser.append(Add(strTitle: "User Type *",
                                          strPlaceHolder: "User Type",
                                          strValue: "Select User Type",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 0,
                                          strParameter: "&user_type="))
        if !isAgent{
            self.FormDataUser.append(Add(strTitle: "Customer Name *",
                                          strPlaceHolder: "Customer Name",
                                          strValue: "Select Customer",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 1,
                                          strParameter: "&user_provider_id="))
        }
        self.FormDataUser.append(Add(strTitle: "First Name *",
                                          strPlaceHolder: "First Name *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 2,
                                          strParameter: "&user_fname="))
        
        self.FormDataUser.append(Add(strTitle: "Last Name *",
                                          strPlaceHolder: "Last Name *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 3,
                                          strParameter: "&user_lname="))
        
        self.FormDataUser.append(Add(strTitle: "Email *",
                                          strPlaceHolder: "Login Email",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 4,
                                          strParameter: "&user_email="))
        
        self.FormDataUser.append(Add(strTitle: "Password *",
                                          strPlaceHolder: "Password *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 5,
                                          strParameter: "&user_password="))
        
        self.FormDataUser.append(Add(strTitle: "Confirm Password *",
                                          strPlaceHolder: "Confirm Password *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 6,
                                          strParameter: "&confirm_password="))
        
        
        self.FormDataUser.append(Add(strTitle: "Mobile No.",
                                        strPlaceHolder: "Mobile No.",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 7,
                                        strParameter: "&user_phone_no="))
        
        self.FormDataUser.append(Add(strTitle: "Office No.",
                                        strPlaceHolder: "Office No.",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 8,
                                        strParameter: "&user_office_no="))
        
        self.FormDataUser.append(Add(strTitle: "Street No.",
                                        strPlaceHolder: "Street No.",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 9,
                                        strParameter: "&user_street_no="))
        
        self.FormDataUser.append(Add(strTitle: "Street Name ",
                                        strPlaceHolder: "Street Name",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 10,
                                        strParameter: "&user_street_name="))
        
        self.FormDataUser.append(Add(strTitle: "Street/Road",
                                        strPlaceHolder: "Street/Road",
                                        strValue: "Select Street",
                                        strSelectedValue : "",
                                        isButton: true,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 11,
                                        strParameter: "&user_street_road_id="))
        
        self.FormDataUser.append(Add(strTitle: "State",
                                        strPlaceHolder: "State",
                                        strValue: "Select State",
                                        strSelectedValue : "",
                                        isButton: true,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 12,
                                        strParameter: "&user_state_id="))
        
        self.FormDataUser.append(Add(strTitle: "City",
                                        strPlaceHolder: "City",
                                        strValue: "Select City",
                                        strSelectedValue : "",
                                        isButton: true,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 13,
                                        strParameter: "&user_city_id="))
        
        self.FormDataUser.append(Add(strTitle: "Zip Code",
                                        strPlaceHolder: "Zip Code",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 14,
                                        strParameter: "&user_zip_code="))

        
        
        
    }
    func CreateAddCustomer(completion:(([FormsMultiple])->())?) {
        
        
        self.FormDataProvider1.append(Add(strTitle: "Customer Name *",
                                          strPlaceHolder: "Customer Name",
                                          strValue: "",strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 0,
                                          strParameter: "&prv_name="))
       
        self.FormDataProvider1.append(Add(strTitle: "Customer Abbreviation *",
                                          strPlaceHolder: "Customer Abbreviation",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 1,
                                          strParameter: "&prv_abbr="))
        
        self.FormDataProvider1.append(Add(strTitle: "Customer Type *",
                                          strPlaceHolder: "Customer Type",
                                          strValue: "Select Customer Type",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 2,
                                          strParameter: "&prv_type="))
        
        self.FormDataProvider1.append(Add(strTitle: "KPI Time *",
                                          strPlaceHolder: "KPI Time",
                                          strValue: "Select KPI Time",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 3,
                                          strParameter: "&prv_kpi_limit="))
        
        self.FormDataProvider1.append(Add(strTitle: "Customer Timezone *",
                                          strPlaceHolder: "Customer Timezone",
                                          strValue: "Select Customer Time Zone",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 4,
                                          strParameter: "&prv_timezone="))
        
        self.FormDataProvider1.append(Add(strTitle: "Street No.",
                                          strPlaceHolder: "Street No.",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 5,
                                          strParameter: "&user_street_no="))
        
        self.FormDataProvider1.append(Add(strTitle: "Street Name",
                                          strPlaceHolder: "Street Name",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 6,
                                        strParameter: "&user_street_name="))
        
        self.FormDataProvider1.append(Add(strTitle: "Street / Road",
                                          strPlaceHolder: "Street / Road",
                                          strValue: "Select Street",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 7,
                                          strParameter: "&user_street_road_id="))
        
        
        self.FormDataProvider1.append(Add(strTitle: "State",
                                          strPlaceHolder: "Satat",
                                          strValue: "Select State",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 8,
                                          strParameter: "&user_state_id="))
        
        self.FormDataProvider1.append(Add(strTitle: "City",
                                          strPlaceHolder: "City",
                                          strValue: "Select City",
                                          strSelectedValue : "",
                                          isButton: true,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 9,
                                          strParameter: "&user_city_id="))
        
        self.FormDataProvider1.append(Add(strTitle: "Zip Code",
                                          strPlaceHolder: "Zip Code",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 10,
                                          strParameter: "&user_zip_code="))
        
        self.FormDataProvider1.append(Add(strTitle: "Office Email",
                                          strPlaceHolder: "Office Email",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 11,
                                          strParameter: "&prv_company_email="))
        
        self.FormDataProvider1.append(Add(strTitle: "Website",
                                          strPlaceHolder: "Website",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 12,
                                          strParameter: "&prv_company_website="))
        
        let cmd = FormsMultiple(array: self.FormDataProvider1, strTitleSection: "Customer Login Information")
       FormDataProvider.append(cmd)
        
        self.FormDataProvider2.append(Add(strTitle: "Customer First Name *",
                                          strPlaceHolder: "Customer First Name *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 13,
                                          strParameter: "&user_fname="))
        
        self.FormDataProvider2.append(Add(strTitle: "Customer Last Name *",
                                          strPlaceHolder: "Customer Last Name *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 14,
                                          strParameter: "&user_lname="))
        
        self.FormDataProvider2.append(Add(strTitle: "Login Email *",
                                          strPlaceHolder: "Login Email",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 15,
                                          strParameter: "&user_email="))
        
        self.FormDataProvider2.append(Add(strTitle: "Login Password *",
                                          strPlaceHolder: "Login Password *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 16,
                                          strParameter: "&user_password="))

        self.FormDataProvider2.append(Add(strTitle: "Login Confirm Password *",
                                          strPlaceHolder: "Login Confirm Password *",
                                          strValue: "",
                                          strSelectedValue : "",
                                          isButton: false,
                                          imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                          rowNumber: 17,
                                          strParameter: "&confirm_password="))
        
//        let cmd5 = Forms(strTitle: "Reason For Call *", strPlaceHolder: "Reason For Call * ", strValue: "", isButton: false, imgDropdown: #imageLiteral(resourceName: "Dropdown"), rowNumber: 5, strParameter : "")
//        self.FormData.append(cmd5)
        let cmd1 = FormsMultiple(array: self.FormDataProvider2, strTitleSection: "Admin Login Information")
        FormDataProvider.append(cmd1)
        DispatchQueue.main.async {
            completion?(self.FormDataProvider)
        }
    }
    func CreateProfile(completion:(([Forms])->())?) {
        
        self.FormDataProfile.append(Add(strTitle: "First Name *",
                                        strPlaceHolder: "First Name",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 0,
                                        strParameter: "&user_fname="))
        
        self.FormDataProfile.append(Add(strTitle: "Last Name *",
                                        strPlaceHolder: "Last Name",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 1,
                                        strParameter: "&user_lname="))
        
        self.FormDataProfile.append(Add(strTitle: "Email *",
                                        strPlaceHolder: "Email",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 2,
                                        strParameter: "&user_email="))
        
        self.FormDataProfile.append(Add(strTitle: "Mobile No.",
                                        strPlaceHolder: "Mobile No.",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 3,
                                        strParameter: "&user_phone_no="))
        
        self.FormDataProfile.append(Add(strTitle: "Office No.",
                                        strPlaceHolder: "Office No.",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 4,
                                        strParameter: "&user_office_no="))
        
        self.FormDataProfile.append(Add(strTitle: "Street No.",
                                        strPlaceHolder: "Street No.",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 5,
                                        strParameter: "&user_street_no="))
        
        self.FormDataProfile.append(Add(strTitle: "Street Name ",
                                        strPlaceHolder: "Street Name",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 6,
                                        strParameter: "&user_street_name="))
        
        self.FormDataProfile.append(Add(strTitle: "Street/Road",
                                        strPlaceHolder: "Street/Road",
                                        strValue: "Select Street",
                                        strSelectedValue : "",
                                        isButton: true,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 7,
                                        strParameter: "&user_street_road_id="))
        
        self.FormDataProfile.append(Add(strTitle: "State",
                                        strPlaceHolder: "State",
                                        strValue: "Select State",
                                        strSelectedValue : "",
                                        isButton: true,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 8,
                                        strParameter: "&user_state_id="))
        
        self.FormDataProfile.append(Add(strTitle: "City",
                                        strPlaceHolder: "City",
                                        strValue: "Select City",
                                        strSelectedValue : "",
                                        isButton: true,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 9,
                                        strParameter: "&user_city_id="))
        
        self.FormDataProfile.append(Add(strTitle: "Zip Code",
                                        strPlaceHolder: "Zip Code",
                                        strValue: "",
                                        strSelectedValue : "",
                                        isButton: false,
                                        imgDropdown: #imageLiteral(resourceName: "ArrowDropDown"),
                                        rowNumber: 10,
                                        strParameter: "&user_zip_code="))

        DispatchQueue.main.async {
            completion?(self.FormDataProfile)
        }
    }
    
    func Add(strTitle: NSString, strPlaceHolder: NSString, strValue: NSString,strSelectedValue : NSString, isButton: Bool, imgDropdown: UIImage, rowNumber: Int, strParameter: NSString) -> Forms {
        let cmd = Forms(strTitle: strTitle,
                        strPlaceHolder: strPlaceHolder,
                        strValue: strValue,
                        strSelectedValue : strSelectedValue,
                        isButton: isButton,
                        imgDropdown: imgDropdown,
                        rowNumber: rowNumber,
                        strParameter: strParameter)
        return cmd
    }
    

}
