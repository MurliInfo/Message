//
//  TestingFile.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/3/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
//var LoginArray : NSMutableArray = []
//var LoginDetail = [LoginData]()
//var CallDetail = [CallDetailData]()
//var ProviderListDetail = [ProviderListData]()
//var ResponsiblePersonListDetail = [ResponsiblePersonListData]()
//var GetCallDetail = [GetCallData]()
//
class TestingFile: NSObject {
//   
//        func callTesting(with: String, completion:(([String:Any])->())?) {
//            print("Login Detail")
//            let url = NSURL(string: LoginApi.Web_Login as String)
//            var request = URLRequest(url: url as! URL)
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            var parameter : NSString = NSString()
//            parameter = "email="
//            parameter = parameter.appending("kevin@retptyltd.com") as NSString
//            parameter = parameter.appending("&password=") as NSString
//            parameter = parameter.appending("@dmin416") as NSString
//            request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error!)                                 // some fundamental network error
//                    return
//                }
//                do {
//                    let responseObject = try JSONSerialization.jsonObject(with: data)
//                    print(responseObject)
//                    
//                    //if
//                    let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any]
//                    //{
//                    //                    let status = parsedData["status"] as! Bool
//                    //                    if(!status){
//                    //                        let field = parsedData["info"] as! [[String:Any]]
//                    //                        var Error : String!
//                    //                        Error = (field[0]["error_message"] as! NSString) as String!
//                    //                        print(Error)
//                    //                    }else{
//                    //                        let field = parsedData["data"] as! [[String:Any]]
//                    //                        print(field)
//                    //                        var cmd = LoginData()
//                    //                        cmd.Full_Name = (field[0]["full_name"] as! NSString) as String!
//                    //                        cmd.Token = (field[0]["token"] as! NSString) as String!
//                    //                        appDelegate.TOKEN = cmd.Token as String! as NSString
//                    //                        cmd.User_Email = (field[0]["user_email"] as! NSString) as String!
//                    //                        cmd.User_Id = (field[0]["user_id"] as! NSString) as String!
//                    //                        cmd.User_Profile_logo = (field[0]["user_profile_logo"] as! NSString) as String!
//                    //                        cmd.User_Provider_Id = (field[0]["user_provider_id"] as! NSString) as String!
//                    //                        cmd.User_Status = (field[0]["user_status"] as! NSString) as String!
//                    //                        cmd.User_Status = (field[0]["user_type"] as! NSString) as String!
//                    //                        LoginDetail.append(cmd)
//                    //                    }
//                    //}
//                    DispatchQueue.main.async {
//                        completion?(parsedData!)
//                    }
//                    
//                } catch let jsonError {
//                    print(jsonError)
//                }
//            }
//            task.resume()
//        }
//        
//        func callTesting1(with url : Any, completion:(([LoginData])->())?) {
//            DispatchQueue.main.async {
//                AllMethods().callTesting(with: "Demo", completion: { (demo) in
//                    print("Testing Demo:==== \(demo)")
//                    
//                    let parsedData = demo
//                    let status = parsedData["status"] as! Bool
//                    if(!status){
//                        let field = parsedData["info"] as! [[String:Any]]
//                        var Error : String!
//                        Error = (field[0]["error_message"] as! NSString) as String!
//                        print(Error)
//                    }else{
//                        let field = parsedData["data"] as! [[String:Any]]
//                        print(field)
//                        var cmd = LoginData()
//                        cmd.Full_Name = (field[0]["full_name"] as! NSString) as String!
//                        cmd.Token = (field[0]["token"] as! NSString) as String!
//                        appDelegate.TOKEN = cmd.Token as String! as NSString
//                        cmd.User_Email = (field[0]["user_email"] as! NSString) as String!
//                        cmd.User_Id = (field[0]["user_id"] as! NSString) as String!
//                        cmd.User_Profile_logo = (field[0]["user_profile_logo"] as! NSString) as String!
//                        cmd.User_Provider_Id = (field[0]["user_provider_id"] as! NSString) as String!
//                        cmd.User_Status = (field[0]["user_status"] as! NSString) as String!
//                        cmd.User_Status = (field[0]["user_type"] as! NSString) as String!
//                        LoginDetail.append(cmd)
//                    }
//                    //}
//                    DispatchQueue.main.async {
//                        completion?(LoginDetail)
//                    }
//                    //            } catch let jsonError {
//                    //                print(jsonError)
//                    //            }
//                })
//            }
//            
//        }
//        
//        
//        
//        
//        //MARK: -LoginAPI
//        func callLogin(with: String, completion:(([LoginData])->())?) {
//            print("Login Detail")
//            let url = NSURL(string: LoginApi.Web_Login as String)
//            var request = URLRequest(url: url as! URL)
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            var parameter : NSString = NSString()
//            parameter = "email="
//            parameter = parameter.appending("kevin@retptyltd.com") as NSString
//            parameter = parameter.appending("&password=") as NSString
//            parameter = parameter.appending("@dmin416") as NSString
//            request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
//            
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error!)                                 // some fundamental network error
//                    return
//                }
//                do {
//                    let responseObject = try JSONSerialization.jsonObject(with: data)
//                    print(responseObject)
//                    if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                        let status = parsedData["status"] as! Bool
//                        if(!status){
//                            let field = parsedData["info"] as! [[String:Any]]
//                            var Error : String!
//                            Error = (field[0]["error_message"] as! NSString) as String!
//                            print(Error)
//                        }else{
//                            let field = parsedData["data"] as! [[String:Any]]
//                            print(field)
//                            var cmd = LoginData()
//                            cmd.Full_Name = (field[0]["full_name"] as! NSString) as String!
//                            cmd.Token = (field[0]["token"] as! NSString) as String!
//                            appDelegate.TOKEN = cmd.Token as String! as NSString
//                            cmd.User_Email = (field[0]["user_email"] as! NSString) as String!
//                            cmd.User_Id = (field[0]["user_id"] as! NSString) as String!
//                            cmd.User_Profile_logo = (field[0]["user_profile_logo"] as! NSString) as String!
//                            cmd.User_Provider_Id = (field[0]["user_provider_id"] as! NSString) as String!
//                            cmd.User_Status = (field[0]["user_status"] as! NSString) as String!
//                            cmd.User_Status = (field[0]["user_type"] as! NSString) as String!
//                            LoginDetail.append(cmd)
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        completion?(LoginDetail)
//                    }
//                    
//                } catch let jsonError {
//                    print(jsonError)
//                }
//            }
//            task.resume()
//        }
//        
//        //MARK: -CallDetail
//        func callDetail(with: String, completion:(([CallDetailData])->())?) {
//            
//            let url = NSURL(string: LoginApi.Web_DashBoardDetail as String)
//            var request = URLRequest(url: url as! URL)
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            var parameter : NSString = NSString()
//            parameter = "token="
//            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
//            //parameter = parameter.appending("&password=") as NSString
//            //parameter = parameter.appending("@dmin416") as NSString
//            request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error!)                                 // some fundamental network error
//                    return
//                }
//                do {
//                    let responseObject = try JSONSerialization.jsonObject(with: data)
//                    print(responseObject)
//                    if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                        let status = parsedData["status"] as! Bool
//                        if(!status){
//                            let field = parsedData["info"] as! [[String:Any]]
//                            var Error : String!
//                            Error = (field[0]["error_message"] as! NSString) as String!
//                            print(Error)
//                        }else{
//                            let field = parsedData["data"] as! [[String:Any]]
//                            for blog in field {
//                                print(blog["prv_name"] as! String )
//                                var cmd = CallDetailData()
//                                cmd.CD_KPI = blog["cd_KPI"] as! String
//                                cmd.CD_Created_Date = blog["cd_created_date"] as! String
//                                cmd.CD_Email = blog["cd_email"] as! String
//                                cmd.CD_From = blog["cd_from"] as! String
//                                cmd.CD_Id = blog["cd_id"] as! String
//                                cmd.CD_Is_Overdue = blog["cd_is_overdue"] as! Bool
//                                cmd.CD_Phone_number = blog["cd_phone_number"] as! String
//                                cmd.CD_Provider_Id = blog["cd_provider_id"] as! String
//                                cmd.CD_Reason_For_Call = blog["cd_reason_for_call"] as! String
//                                cmd.CD_Status = blog["cd_status"] as! String
//                                cmd.CD_User_Id = blog["cd_user_id"] as! String
//                                cmd.Modified_By = blog["modified_by"] as! String
//                                cmd.PRV_Abbr = blog["prv_abbr"] as! String
//                                cmd.PRV_Abbr_Color = blog["prv_abbr_color"] as! String
//                                cmd.PRV_Kpi_Limit = blog["prv_kpi_limit"] as! String
//                                cmd.PRV_Name = blog["prv_name"] as! String
//                                cmd.PRV_Timezone = blog["prv_timezone"] as! String
//                                cmd.Responsible_Person = blog["responsible_person"] as! String
//                                CallDetail.append(cmd)
//                            }
//                        }
//                        DispatchQueue.main.async {
//                            completion?(CallDetail)
//                        }
//                    }
//                } catch let jsonError {
//                    print(jsonError)
//                }
//            }
//            task.resume()
//        }
//        
//        func providerList(with: String, completion:(([ProviderListData])->())?) {
//            let url = NSURL(string: LoginApi.Web_ProviderList as String)
//            var request = URLRequest(url: url as! URL)
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            var parameter : NSString = NSString()
//            parameter = "token="
//            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
//            //parameter = parameter.appending("&archive=") as NSString
//            //parameter = parameter.appending("true") as NSString
//            request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error!)                                 // some fundamental network error
//                    return
//                }
//                do {
//                    let responseObject = try JSONSerialization.jsonObject(with: data)
//                    print(responseObject)
//                    if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                        let status = parsedData["status"] as! Bool
//                        if(!status){
//                            let field = parsedData["msg"] as! [[String:Any]]
//                            var Error : String!
//                            Error = (field[0]["error_message"] as! NSString) as String!
//                            print(Error)
//                        }else{
//                            let field = parsedData["data"] as! NSDictionary
//                            for (key, value) in field {
//                                print ("Key: \( key) for value: \(value)");
//                                
//                                var cmd = ProviderListData()
//                                cmd.PRV_Id = key as! String
//                                cmd.PRV_Name = value as! String
//                                ProviderListDetail.append(cmd)
//                            }
//                        }
//                        DispatchQueue.main.async {
//                            completion?(ProviderListDetail)
//                        }
//                    }
//                    
//                } catch let jsonError {
//                    print(jsonError)
//                }
//            }
//            task.resume()
//            DispatchQueue.main.async {
//                
//            }
//            
//        }
//        
//        func responsiblePersonList(with: String, completion:(([ResponsiblePersonListData])->())?) {
//            
//            let url = NSURL(string: LoginApi.Web_ResponsiblePersonList as String)
//            var request = URLRequest(url: url as! URL)
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            var parameter : NSString = NSString()
//            parameter = "token="
//            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
//            parameter = parameter.appending("&provider_id=") as NSString
//            parameter = parameter.appending("1") as NSString
//            request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error!)                                 // some fundamental network error
//                    return
//                }
//                do {
//                    let responseObject = try JSONSerialization.jsonObject(with: data)
//                    print(responseObject)
//                    if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                        let status = parsedData["status"] as! Bool
//                        if(!status){
//                            //  let field = parsedData["msg"] as! [[String:Any]]
//                            var Error : String!
//                            Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
//                            print(Error)
//                        }else{
//                            let field = parsedData["data"] as! NSDictionary
//                            for (key, value) in field {
//                                print ("Key: \( key) for value: \(value)");
//                                var cmd = ResponsiblePersonListData()
//                                
//                                cmd.RP_Id = key as! String
//                                cmd.RP_Name = value as! String
//                                ResponsiblePersonListDetail.append(cmd)
//                            }
//                        }
//                        DispatchQueue.main.async {
//                            completion?(ResponsiblePersonListDetail)
//                        }
//                    }
//                    
//                } catch let jsonError {
//                    print(jsonError)
//                }
//            }
//            task.resume()
//        }
//        
//        func getCall(with: String, completion:(([GetCallData])->())?) {
//            
//            let url = NSURL(string: LoginApi.Web_GetCall as String)
//            var request = URLRequest(url: url as! URL)
//            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            var parameter : NSString = NSString()
//            parameter = "token="
//            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
//            parameter = parameter.appending("&call_id=") as NSString
//            parameter = parameter.appending("8") as NSString
//            request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
//            let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print(error!)                                 // some fundamental network error
//                    return
//                }
//                do {
//                    let responseObject = try JSONSerialization.jsonObject(with: data)
//                    print(responseObject)
//                    if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                        let status = parsedData["status"] as! Bool
//                        if(!status){
//                            //  let field = parsedData["msg"] as! [[String:Any]]
//                            var Error : String!
//                            Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
//                            print(Error)
//                        }else{
//                            let field = parsedData["data"] as! NSDictionary
//                            //let cmd = CustomData()
//                            var cmd = GetCallData()
//                            cmd.CC_Email_Address = field.value(forKey: "cd_email") as! String
//                            print(cmd.CC_Email_Address)
//                            //                        cmd.CC_Email_Address = field.value(forKey:"cc_email_address") as! String
//                            cmd.CD_Email = field.value(forKey:"cd_email") as! String
//                            cmd.CD_From =  field.value(forKey:"cd_from") as! String
//                            cmd.CD_Id =  field.value(forKey:"cd_id") as! String
//                            cmd.CD_Phone_Number =  field.value(forKey:"cd_phone_number") as! String
//                            cmd.CD_Provider_Id =  field.value(forKey:"cd_provider_id") as! String
//                            cmd.CD_Reason_For_Call =  field.value(forKey:"cd_reason_for_call") as! String
//                            cmd.CD_Status =  field.value(forKey:"cd_status") as! String
//                            cmd.CD_User_Id =  field.value(forKey:"cd_user_id") as! String
//                            cmd.Provider_Name =  field.value(forKey:"provider_name") as! String
//                            cmd.Responsible_Person =  field.value(forKey:"responsible_person") as! String
//                            GetCallDetail.append(cmd)
//                        }
//                        DispatchQueue.main.async {
//                            completion?(GetCallDetail)
//                        }
//                    }
//                } catch let jsonError {
//                    print(jsonError)
//                }
//            }
//            task.resume()
//            DispatchQueue.main.async {
//                
//            }
//        }

}
