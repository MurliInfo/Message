
//  AllMethods.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/2/17.

//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

let LoginApi = AllWebservices()
var LoginArray : NSMutableArray = []
var LoginDetail = [LoginData]()
var CallDetail = [CallDetailData]()
var CallDetailA = [CallDetailData]()

//callDetailArchive
var UserDetail = [UserListData]()
var ProviderList = [ProviderListData]()
var ProviderDetailList = [ProviderDetailListData]()
var ResponsiblePersonListDetail = [ResponsiblePersonListData]()
var StatusListDetail = [DropDownListData]()
var GetCallDetail = [GetCallData]()
var StreerStateList = [DropDownListData]()
var CityList = [DropDownListData]()
var NoteList = [GetNote]()
var MacroList = [Macro]()
var CCList = [GetCC]()
var defaults = UserDefaults.standard

class AllMethods: NSObject {
    
    func forgotPassword(with parameters: String, completion:(([String:Any])->())?) {
        let url = NSURL(string: LoginApi.Web_ForgotPassword as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameter : NSString = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
                DispatchQueue.main.async {
                    completion?(parsedData!)
                }
            }
        }
        task.resume()
    }

    func callTesting(with parameters: String, completion:(([String:Any])->())?) {
        let url = NSURL(string: LoginApi.Web_Login as String)
        
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameter : NSString = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
                DispatchQueue.main.async {
                    completion?(parsedData!)
                }
            }
        }
        task.resume()
    }
    
    func callTesting1(with Parameter : Any, completion:(([LoginData])->())?) {
        var parameter : NSString = NSString()
        parameter = Parameter as! NSString
        DispatchQueue.main.async {
            AllMethods().callTesting(with: parameter as String, completion: { (demo) in
                
                let parsedData = demo 
                let status = parsedData["status"] as! Bool
                 LoginDetail = [LoginData]()
                if(!status){
                     LoginDetail = [LoginData]()
                    var cmd = LoginData()
                    cmd.status = false
                    cmd.User_Type = parsedData["msg"] as! String
                    LoginDetail.append(cmd)

                }else{
                     LoginDetail = [LoginData]()
                    let field = parsedData["data"] as! [[String:Any]]
                    var cmd = LoginData()
                    cmd.Full_Name = (field[0]["full_name"] as! NSString) as String!
                    cmd.Token = (field[0]["token"] as! NSString) as String!
                    appDelegate.TOKEN = cmd.Token as String! as NSString
                    cmd.User_Email = (field[0]["user_email"] as! NSString) as String!
                    cmd.User_Id = (field[0]["user_id"] as! NSString) as String!
                    cmd.User_Profile_logo = (field[0]["user_profile_logo"] as! NSString) as String!
                    cmd.User_Provider_Id = (field[0]["user_provider_id"] as! NSString) as String!
                    cmd.User_Status = (field[0]["user_status"] as! NSString) as String!
                    cmd.User_Type = (field[0]["user_type"] as! NSString) as String!
                    cmd.status = true
                    print(field[0]["user_id"] as! NSString)
                    appDelegate.USERID = field[0]["user_id"] as! NSString
                    appDelegate.USERNAME = field[0]["full_name"] as! NSString
                    appDelegate.USERTYPEID = field[0]["user_type"] as! NSString
                    
                  //  defaults.set(cmd, forKey: "LOGIN")
                     defaults.set(cmd.Full_Name, forKey: "FULLNAME")
                    defaults.set(cmd.Token, forKey: "TOKEN")
                    defaults.set(cmd.User_Email, forKey: "USEREMAIL")
                    defaults.set(cmd.User_Id, forKey: "USERID")
                    defaults.set(cmd.User_Profile_logo, forKey: "PROFILELOGO")
                    defaults.set(cmd.User_Provider_Id, forKey: "PROVIDERID")
                    defaults.set(cmd.User_Status, forKey: "USERSTATUS")
                    defaults.set(cmd.User_Type, forKey: "USERTYPE")
                    defaults.set(cmd.status, forKey: "STATUS")
                    
                    appDelegate.USERNAME = cmd.Full_Name as NSString
                    appDelegate.TOKEN = cmd.Token as NSString
                    appDelegate.USEREMAIL = cmd.User_Email as NSString
                    appDelegate.USERID = cmd.User_Id as NSString
                    appDelegate.USERLOG = cmd.User_Profile_logo as NSString
                    appDelegate.USERPROVIDERID = cmd.User_Provider_Id as NSString
                    appDelegate.USERSTATUS = cmd.User_Status as NSString
                    appDelegate.USERTYPE = cmd.User_Type as NSString
                    appDelegate.USERTYPEID = cmd.User_Type as NSString
                    appDelegate.PROVIDERID = cmd.User_Provider_Id as NSString
                    LoginDetail.append(cmd)
                }
                DispatchQueue.main.async {
                    completion?(LoginDetail)
                }
           })
        }
    }
    //MARK:- LoginAPI
    
    func callLogin(with parameters: String, completion:(([LoginData])->())?) {
        let url = NSURL(string: LoginApi.Web_Login as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "email="
        parameter = parameter.appending("kevin@retptyltd.com") as NSString
        parameter = parameter.appending("&password=") as NSString
        parameter = parameter.appending("@dmin416") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                // let responseObject = try JSONSerialization.jsonObject(with: data)
                //print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["info"] as! [[String:Any]]
                        var Error : String!
                        Error = (field[0]["error_message"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        print(field)
                        var cmd = LoginData()
                        cmd.Full_Name = (field[0]["full_name"] as! NSString) as String!
                        cmd.Token = (field[0]["token"] as! NSString) as String!
                        appDelegate.TOKEN = cmd.Token as String! as NSString
                        cmd.User_Email = (field[0]["user_email"] as! NSString) as String!
                        cmd.User_Id = (field[0]["user_id"] as! NSString) as String!
                        cmd.User_Profile_logo = (field[0]["user_profile_logo"] as! NSString) as String!
                        cmd.User_Provider_Id = (field[0]["user_provider_id"] as! NSString) as String!
                        cmd.User_Status = (field[0]["user_status"] as! NSString) as String!
                        cmd.User_Status = (field[0]["user_type"] as! NSString) as String!
                        LoginDetail.append(cmd)
                    }
                }
                DispatchQueue.main.async {
                    completion?(LoginDetail)
                }
            }
        }
        task.resume()
    }
    
    //MARK:- CallDetail
    func callDetail(with parameters: String,Page: Int, completion:(([CallDetailData])->())?) {
    
        let url = NSURL(string: LoginApi.Web_DashBoardDetail as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        print(parameter)
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
//                let responseObject = try JSONSerialization.jsonObject(with: data)
              //  print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if Page == 0{
                     CallDetail = [CallDetailData]()
                    }
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        if Page == 0{
                            CallDetail = [CallDetailData]()
                        }
                        for blog in field {
                            var cmd = CallDetailData()
                            if  blog["cd_KPI"]  is NSNull{
                                cmd.CD_KPI = ""
                            }else{
                                cmd.CD_KPI = blog["cd_KPI"] as! String
                            }
                            print(blog["cd_from"] as! String)
                            var dateString = blog["cd_created_date"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMMM, dd yyyy hh:mm a"
                            let dateFromString = dateFormatter.date(from: dateString)
                            dateFormatter.dateFormat = "MMM dd, hh:mm a"
                            dateString = dateFormatter.string(from: dateFromString!)
                            cmd.CD_Created_Date = dateString
                            cmd.CD_Email = blog["cd_email"] as! String
                            cmd.CD_From = blog["cd_from"] as! String
                            cmd.CD_Id = blog["cd_id"] as! String
                            cmd.CD_Is_Overdue = blog["cd_is_overdue"] as! Bool
                            cmd.CD_Phone_number = blog["cd_phone_number"] as! String
                            cmd.CD_Provider_Id = blog["cd_provider_id"] as! String
                            cmd.CD_Reason_For_Call = blog["cd_reason_for_call"] as! String
                            cmd.CD_Status = blog["cd_status"] as! String
                            cmd.CD_User_Id = blog["cd_user_id"] as! String
                            cmd.Modified_By = blog["modified_by"] as! String
                            cmd.PRV_Abbr = blog["prv_abbr"] as! String
                            cmd.PRV_Abbr_Color = blog["prv_abbr_color"] as! String
                            cmd.PRV_Kpi_Limit = blog["prv_kpi_limit"] as! String
                            cmd.PRV_Name = blog["prv_name"] as! String
                            cmd.PRV_Timezone = blog["prv_timezone"] as! String
                            cmd.Responsible_Person = blog["responsible_person"] as! String
                            cmd.Cd_Notes_Count = blog["cd_notes_count"] as! String
                            cmd.SELECTED = 0
                            CallDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(CallDetail)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }
    
    func callDetailArchive(with parameters: String,Page: Int, completion:(([CallDetailData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_DashBoardDetail as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        print(parameter)
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                
                //                let responseObject = try JSONSerialization.jsonObject(with: data)
                //  print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if Page == 0{
                        CallDetailA = [CallDetailData]()
                    }
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        if Page == 0{
                            CallDetailA = [CallDetailData]()
                        }
                        for blog in field {
                            var cmd = CallDetailData()
                            if  blog["cd_KPI"]  is NSNull{
                                cmd.CD_KPI = ""
                            }else{
                                cmd.CD_KPI = blog["cd_KPI"] as! String
                            }
                            
                            var dateString = blog["cd_created_date"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMMM, dd yyyy hh:mm a"
                            let dateFromString = dateFormatter.date(from: dateString)
                            dateFormatter.dateFormat = "MMM dd, hh:mm a"
                            dateString = dateFormatter.string(from: dateFromString!)
                            cmd.CD_Created_Date = dateString
                            cmd.CD_Email = blog["cd_email"] as! String
                            cmd.CD_From = blog["cd_from"] as! String
                            cmd.CD_Id = blog["cd_id"] as! String
                            cmd.CD_Is_Overdue = blog["cd_is_overdue"] as! Bool
                            cmd.CD_Phone_number = blog["cd_phone_number"] as! String
                            cmd.CD_Provider_Id = blog["cd_provider_id"] as! String
                            cmd.CD_Reason_For_Call = blog["cd_reason_for_call"] as! String
                            cmd.CD_Status = blog["cd_status"] as! String
                            cmd.CD_User_Id = blog["cd_user_id"] as! String
                            cmd.Modified_By = blog["modified_by"] as! String
                            cmd.PRV_Abbr = blog["prv_abbr"] as! String
                            cmd.PRV_Abbr_Color = blog["prv_abbr_color"] as! String
                            cmd.PRV_Kpi_Limit = blog["prv_kpi_limit"] as! String
                            cmd.PRV_Name = blog["prv_name"] as! String
                            cmd.PRV_Timezone = blog["prv_timezone"] as! String
                            cmd.Responsible_Person = blog["responsible_person"] as! String
                            cmd.Cd_Notes_Count = blog["cd_notes_count"] as! String
                            cmd.SELECTED = 0
                            CallDetailA.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(CallDetailA)
                    }
                }
            }
            //            catch let jsonError {
            //                print("Catch \(jsonError)")
            //            }
        }
        task.resume()
    }

    
    
    //MARK:- Provider List

    func providerList(with parameters: String, completion:(([ProviderListData])->())?) {
        let url = NSURL(string: LoginApi.Web_ProviderList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending(parameters as String) as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["msg"] as! [[String:Any]]
                        print(field)
                    }else{
                        ProviderList = [ProviderListData]()
                        let field = parsedData["data"] as! NSDictionary
                        ProviderList = [ProviderListData]()
                        var cmd = ProviderListData()
                        cmd.PRV_Id = "00"
                        cmd.PRV_Name = "Select Customer"
                        ProviderList.append(cmd)
                        
                        for (key, value) in field {
                            //print ("Key: \( key) for value: \(value)");
                            var cmd = ProviderListData()
                            cmd.PRV_Id = key as! String
                            cmd.PRV_Name = value as! String
                            ProviderList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(ProviderList)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
            
        }

    }
    //MARK: - Responsible List
    func responsiblePersonList(with parameters: String, completion:(([ResponsiblePersonListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_ResponsiblePersonList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString

        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
//                let responseObject = try JSONSerialization.jsonObject(with: data)
                //print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        //  let field = parsedData["msg"] as! [[String:Any]]
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        ResponsiblePersonListDetail = [ResponsiblePersonListData]()
                        let field = parsedData["data"] as! NSDictionary
                        var cmd = ResponsiblePersonListData()
                        
                        cmd.RP_Id = "00"
                        cmd.RP_Name = "Select Responsible"
                        ResponsiblePersonListDetail.append(cmd)
                        
                        for (key, value) in field {
                            //print ("Key: \( key) for value: \(value)");
                            var cmd = ResponsiblePersonListData()
                            
                            cmd.RP_Id = key as! String
                            cmd.RP_Name = value as! String
                            ResponsiblePersonListDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(ResponsiblePersonListDetail)
                    }
                }
            }
        }
        task.resume()
    }
    //MARK:- Get Call detail
    func getCall(with parameters: String, completion:(([GetCallData])->())?) {
       
        let url = NSURL(string: LoginApi.Web_GetCall as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending("&call_id=") as NSString
        parameter = parameter.appending("8") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {

                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        //  let field = parsedData["msg"] as! [[String:Any]]
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! NSDictionary
                        var cmd = GetCallData()
                        cmd.CC_Email_Address = field.value(forKey: "cd_email") as! String
                        
                        cmd.CD_Email = field.value(forKey:"cd_email") as! String
                        cmd.CD_From =  field.value(forKey:"cd_from") as! String
                        cmd.CD_Id =  field.value(forKey:"cd_id") as! String
                        cmd.CD_Phone_Number =  field.value(forKey:"cd_phone_number") as! String
                        cmd.CD_Provider_Id =  field.value(forKey:"cd_provider_id") as! String
                        cmd.CD_Reason_For_Call =  field.value(forKey:"cd_reason_for_call") as! String
                        cmd.CD_Status =  field.value(forKey:"cd_status") as! String
                        cmd.CD_User_Id =  field.value(forKey:"cd_user_id") as! String
                        cmd.Provider_Name =  field.value(forKey:"provider_name") as! String
                        cmd.Responsible_Person =  field.value(forKey:"responsible_person") as! String
                        GetCallDetail.append(cmd)
                    }
                    DispatchQueue.main.async {
                        completion?(GetCallDetail)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }
    //MARK:- Add Call
    func AddCall(with parameters: String, completion:((NSString)->())?) {
        var field : NSString = NSString()
        let url = NSURL(string: LoginApi.Web_AddCall as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        field = parsedData["msg"] as! NSString//(field[0]["msg"] as! NSString) as String!
                        print(field)
                    }else{
                        field = parsedData["msg"] as! NSString
                        print(field)
                    }
                    DispatchQueue.main.async {
                        completion?(field)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }

    
    //MARK:- Edit Call
    func EditCall(with parameters: String, completion:((NSString)->())?) {
        var field : NSString = NSString()
        let url = NSURL(string: LoginApi.Web_EditCall as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString
        //parameter = parameter.appending("8") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        field = parsedData["msg"] as! NSString//(field[0]["msg"] as! NSString) as String!
                        print(field)
                    }else{
                        field = parsedData["msg"] as! NSString
                        print(field)
                    }
                    DispatchQueue.main.async {
                        completion?(field)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }

    //MARK:- Get Status
    
    func statusList(with parameters: String, completion:(([DropDownListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_Status as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString

        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
//                let responseObject = try JSONSerialization.jsonObject(with: data)
                //print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        //  let field = parsedData["msg"] as! [[String:Any]]
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        StatusListDetail = [DropDownListData]()
                        let field = parsedData["data"] as! NSDictionary
                        for (key, value) in field {
                            var cmd = DropDownListData()
                            
                            cmd.Drp_Id = key as! String
                            cmd.Drp_Name = value as! String
                            StatusListDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(StatusListDetail)
                    }
                }
            }
        }
        task.resume()
    }

    //MARK:- UserlistDashboard

    func UserListDetail(with parameters: String, completion:(([UserListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_UserList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        print(parameter)
        
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
              //  let responseObject = try JSONSerialization.jsonObject(with: data)
                //  print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                        UserDetail = [UserListData]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        UserDetail = [UserListData]()

                        for blog in field {
                             let dateFormatter = DateFormatter()
                            
                            var dateString = blog["user_modified_date"] as! String
                            dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                            let dateFromString = dateFormatter.date(from: dateString)
                            dateFormatter.dateFormat = "MMM dd, hh:mm a"
                            dateString = dateFormatter.string(from: dateFromString!)
                           let dateData = dateString
                            var userType = NSString()
                            var modifyBy = NSString()
                            if blog["user_type_name"] is NSNull{
                                userType = ""
                            }else{
                                 userType = blog["user_type_name"] as! NSString
                            }
                            if blog["modify_by"] is NSNull{
                                modifyBy = ""
                            }else{
                                modifyBy = blog["modify_by"] as! NSString
                            }
                            let cmd = UserListData(
                            User_Id: blog["user_id"] as! String,
                                     User_Fname: blog["user_fname"] as! String,
                                     User_Lname: blog["user_lname"] as! String,
                                     User_Phone_No: blog["user_phone_no"] as! String,
                                     User_Office_No: blog["user_office_no"] as! String,
                                     User_Provider_Id: blog["user_provider_id"] as! String,
                                     User_Email: blog["user_email"] as! String,
                                     User_Type: blog["user_type"] as! String,
                                     User_Profile_Logo: blog["user_profile_logo"] as! String,
                                     User_Street_No: blog["user_street_no"] as! String,
                                     User_Street_Name: blog["user_street_name"] as! String,
                                     User_Street_Road_Id: blog["user_street_road_id"] as! String,
                                     User_State_Id: blog["user_state_id"] as! String,
                                     User_City_Id: blog["user_city_id"] as! String,
                                     User_Zip_Code: blog["user_zip_code"] as! String,
                                     User_Address: blog["user_address"] as! String,
                                     User_Modified_Date: dateData,//blog[dateData] as! String,
                                     User_Type_Name: userType as String!,// blog["user_type_name"] as! String,//user_type_name
                                     Provider_Abbr: blog["provider_abbr"] as! String,
                                     Prv_Abbr_Color: blog["prv_abbr_color"] as! String,
                                     User_Status_Name: blog["user_status_name"] as! String,
                                     User_Status: blog["user_status"] as! String,
                                     Modify_By: modifyBy as String!,
                                     SELECTED : 0,
                                     Is_Checked:  blog["is_checked"] as! Bool);
                            
                            UserDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(UserDetail)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }

    //MARK:- Provider list dashboard

    func ProviderListDetail(with parameters: String, completion:(([ProviderDetailListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_ProviderDetail as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    ProviderDetailList = [ProviderDetailListData]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        ProviderDetailList = [ProviderDetailListData]()
                        for blog in field {
                            let dateFormatter = DateFormatter()
                            
                            var dateString = blog["prv_modified_date"] as! String
                            dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                            let dateFromString = dateFormatter.date(from: dateString)
                            dateFormatter.dateFormat = "MMM dd, hh:mm a"
                            dateString = dateFormatter.string(from: dateFromString!)
                            let dateData = dateString
                            
                            let cmd = ProviderDetailListData(PRV_Id: blog["prv_id"] as! String,
                                                             PRV_Name: blog["prv_name"] as! String,
                                                             PRV_Abbr: blog["prv_abbr"] as! String,
                                                             PRV_Abbr_Color: blog["prv_abbr_color"] as! String,
                                                             PRV_Type: blog["prv_type"] as! String,
                                                             PRV_Kpi_Limit: blog["prv_kpi_limit"] as! String,
                                                             Timezone_Name: blog["timezone_name"] as! String,
                                                             PRV_Address: blog["prv_address"] as! String,
                                                             PRV_Company_Email: blog["prv_company_email"] as! String,
                                                             PRV_Company_Website: blog["prv_company_website"] as! String,
                                                             PRV_Description: blog["prv_description"] as! String,
                                                             Modify_By: blog["modify_by"] as! String,
                                                             PRV_Modified_Date: dateData,//blog["prv_modified_date"] as! String,
                                                            User_Street_No: blog["user_street_no"] as! String,
                                                            User_Street_Name: blog["user_street_name"] as! String,
                                                            User_Street_Road_Id: blog["user_street_road_id"] as! String,
                                                            User_State_Id: blog["user_state_id"] as! String,
                                                            User_City_Id: blog["user_city_id"] as! String,
                                                            User_Zip_Code: blog["user_zip_code"] as! String,
                                                            Is_Checked: blog["is_checked"] as! Bool,
                                                            PRV_Status: blog["prv_status"] as! String,
                                                            SELECTED : 0);
                            ProviderDetailList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(ProviderDetailList)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }

    //MARK:- Street state city

    
    func StreetCityStateDetail(with parameters: String, API: String, completion:(([DropDownListData])->())?) {
        
        let url = NSURL(string: API as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString

        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    StreerStateList = [DropDownListData]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        StreerStateList = [DropDownListData]()
                        
                        for blog in field {
                            
                            let cmd = DropDownListData(Drp_Id:blog["id"] as! String,
                                                       Drp_StateId: blog["state_name"] as! String,
                                                       Drp_Name: blog["state_name"] as! String
                            )
                            StreerStateList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(StreerStateList)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }

    //MARK:- City

    func CityDetail(with parameters: String, API: String, completion:(([DropDownListData])->())?) {
        
        let url = NSURL(string: API as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
        //        let responseObject = try JSONSerialization.jsonObject(with: data)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    CityList = [DropDownListData]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        CityList = [DropDownListData]()
                        
                        for blog in field {
                            let cmd = DropDownListData(Drp_Id:blog["id"] as! String,
                                                       Drp_StateId: blog["state_id"] as! String,
                                                       Drp_Name: blog["city_name"] as! String
                            )
                            CityList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(CityList)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }
    
    //MARK:- Add User

    func AddUser(with parameters: String, completion:((NSString)->())?) {
        var field : NSString = NSString()
        let url = NSURL(string: LoginApi.Web_AddUser as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString

        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                         field = parsedData["msg"] as! NSString//(field[0]["msg"] as! NSString) as String!
                        print(field)
                    }else{
                        field = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(field)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }

    //MARK:- Edit User

    
    func EditUser(with parameters: String, completion:((NSString)->())?) {
        var field : NSString = NSString()
        let url = NSURL(string: LoginApi.Web_Edit_User as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString

        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        field = parsedData["msg"] as! NSString//(field[0]["msg"] as! NSString) as String!
                        print(field)
                    }else{
                        field = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(field)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }
    
    //MARK:- Provider type list

    
    func ProviderType(with parameters: String, completion:(([DropDownListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_Provider_Type as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
          StatusListDetail = [DropDownListData]()
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        StatusListDetail = [DropDownListData]()
                        let field = parsedData["data"] as! NSDictionary
                        for (key, value) in field {
                            var cmd = DropDownListData()
                            
                            cmd.Drp_Id = key as! String
                            cmd.Drp_Name = value as! String
                            StatusListDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(StatusListDetail)
                    }
                }
                
            }
        }
        task.resume()
    }

    //MARK:- TimeZone List

    func TimeZone(with parameters: String, completion:(([DropDownListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_TimeZone as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString

        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                //let responseObject = try JSONSerialization.jsonObject(with: data)
                //print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        StatusListDetail = [DropDownListData]()
                        let field = parsedData["data"] as! NSDictionary
                        for (key, value) in field {
                            var cmd = DropDownListData()
                            cmd.Drp_Id = key as! String
                            cmd.Drp_Name = value as! String
                            StatusListDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(StatusListDetail)
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK:- Add and Edit Provider

    func AddEditProvider(with parameters: String, Api: String, completion:((NSString)->())?) {
        var field : NSString = NSString()
        let url = NSURL(string: Api)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        field = parsedData["msg"] as! NSString//(field[0]["msg"] as! NSString) as String!
                        print(field)
                    }else{
                        field = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(field)
                    }
                }
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }
    
    //MARK: - Assign To List
    
    func assignTo(with parameters: String, completion:(([ResponsiblePersonListData])->())?) {
        
        let url = NSURL(string: LoginApi.Web_ResponsiblePersonList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        ResponsiblePersonListDetail = [ResponsiblePersonListData]()
                        let field = parsedData["data"] as! NSDictionary
                        var cmd = ResponsiblePersonListData()
                        
                        cmd.RP_Id = "00"
                        cmd.RP_Name = "Assign To"
                        ResponsiblePersonListDetail.append(cmd)
                        
                        for (key, value) in field {
                            var cmd = ResponsiblePersonListData()
                            cmd.RP_Id = key as! String
                            cmd.RP_Name = value as! String
                            ResponsiblePersonListDetail.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(ResponsiblePersonListDetail)
                    }
                }
            }
        }
        task.resume()
    }
    //MARK:- Notes Detail

    func NotesDetail(with parameters: String, API: String, completion:(([GetNote])->())?) {
        
        let url = NSURL(string: LoginApi.Web_GetNote as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending(parameters) as NSString
//        parameter = parameters as NSString
      
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    NoteList = [GetNote]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        NoteList = [GetNote]()
                        for blog in field {
                            var dateString = blog["nt_added_date"] as! String
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "MMM, dd yyyy hh:mm a"
                            let dateFromString = dateFormatter.date(from: dateString)
                            dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
                            dateString = dateFormatter.string(from: dateFromString!)
                            let cmd = GetNote(NT_id: blog["nt_id"] as! String,
                                              NT_Call_Id: blog["nt_call_id"] as! String,
                                              NT_Type: blog["nt_type"] as! String,
                                              NT_Desc: blog["nt_desc"] as! String,
                                              Added_By: blog["added_by"] as! String,
                                              NT_Added_Date: dateString,
                                              User_Profile_Logo: blog["user_profile_logo"] as! String,
                                              Notes_Files: blog["notes_files"] as! NSArray
                            )
                            NoteList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(NoteList)
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK:- Macro List

    func MacroListData(with parameters: String, API: String, completion:(([Macro])->())?) {
        
        let url = NSURL(string: LoginApi.Web_MacroList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    MacroList = [Macro]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        MacroList = [Macro]()
                        for blog in field {
                            let cmd = Macro(MAC_Name: blog["mac_name"] as! String,
                                            MAC_Description: blog["mac_description"] as! String,
                                            MAC_Id: blog["mac_id"] as! String
                            )
                            MacroList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(MacroList)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }
    
    //MARK:- Change Status (Call,User,Provider)

    
    func changeStatus(with parameters: String, API: String, completion:((NSString)->())?) {
        var Responce : NSString!
        let url = NSURL(string: API)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        Responce = parsedData["msg"] as! NSString
                    }else{
                          Responce = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(Responce)
                    }
                }
            }
//            catch let jsonError {
//                print("Catch \(jsonError)")
//            }
        }
        task.resume()
    }
    
    func GetCCListData(with parameters: String, API: String, completion:(([GetCC])->())?) {
        let url = NSURL(string: API)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending(parameters) as NSString
        
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    CCList = [GetCC]()
                    if(!status){
                        var Error : String!
                        Error = (parsedData["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        CCList = [GetCC]()
                        for blog in field {
                            let cmd = GetCC(CC_Id: blog["cc_id"] as! String,
                                            CC_Address: blog["cc_address"] as! String)
                            CCList.append(cmd)
                        }
                    }
                    DispatchQueue.main.async {
                        completion?(CCList)
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK:- RemoveCCList from (Call,User,Provider)
    
    
    func RemoveCCList(with parameters: String, API: String, completion:((NSString)->())?) {
        var Responce : NSString!
        let url = NSURL(string: API)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending(parameters) as NSString
        
        //var parameter : NSString = NSString()
       // parameter = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        Responce = parsedData["msg"] as! NSString
                    }else{
                        Responce = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(Responce)
                    }
                }
            }
        }
        task.resume()
    }
    
    //MARK:- ADDCCList from (Call,User,Provider)
    
    
    func AddCCList(with parameters: String, API: String, completion:((NSString)->())?) {
        var Responce : NSString!
        let url = NSURL(string: API)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending(parameters) as NSString
        
        //var parameter : NSString = NSString()
        // parameter = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        Responce = parsedData["msg"] as! NSString
                    }else{
                        Responce = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(Responce)
                    }
                }
            }
        }
        task.resume()
    }

    func ChangeAssneeTo(with parameters: String, API: String, completion:((NSString)->())?) {
        var Responce : NSString!
        let url = NSURL(string: API)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending(parameters) as NSString
        
        //var parameter : NSString = NSString()
        // parameter = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        Responce = parsedData["msg"] as! NSString
                    }else{
                        Responce = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(Responce)
                    }
                }
            }
        }
        task.resume()
    }
    
    func AddNotes(with parameters: String, API: String, completion:((NSString)->())?) {
        var Responce : NSString!
        let url = NSURL(string: API)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending(parameters) as NSString
        
        //var parameter : NSString = NSString()
        // parameter = parameters as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        Responce = parsedData["msg"] as! NSString
                    }else{
                        Responce = parsedData["msg"] as! NSString
                    }
                    DispatchQueue.main.async {
                        completion?(Responce)
                    }
                }
            }
        }
        task.resume()
    }

    
}

