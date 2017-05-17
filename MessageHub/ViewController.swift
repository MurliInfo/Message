//
//  ViewController.swift
//  MessageHub
//
//  Created by Hardik Davda on 1/31/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
//  MARK: - Declaration
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let LoginApi = AllWebservices()
    var timer: Timer!
    var LoginArray : NSMutableArray = []
    var CallDetailArray : NSMutableArray = []
    var CallArchiveDetailArray : NSMutableArray = []
    var ProviderListArray : NSMutableArray = []
    var ResponsiblePersonListArray : NSMutableArray = []
    var GetCallArray : NSMutableArray = []
    var Token : String!
    //var demo = [LoginData]()
    var loginData = [LoginData]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
       //        let WEBPATH = LoginApi.WEBPATH as NSString
        print(LoginApi.Web_Login)
        print(LoginApi.Web_DashBoardDetail)
        print(LoginApi.Web_AddNote)
        print(LoginApi.Web_GetCall)
        print(LoginApi.Web_CallAvailability)
        print(LoginApi.Web_AddCall)
        print(LoginApi.Web_Status)
        print(LoginApi.Web_ProviderList)
        print(LoginApi.Web_Login)
        print(LoginApi.Web_AddCC)
        print(LoginApi.Web_EditCall)
        print(LoginApi.Web_ResponsiblePersonList)

        let imageData = NSData(contentsOf: Bundle.main.url(forResource: "GIF", withExtension: "gif")!)
        let advTimeGif = UIImage.gifImageWithData(imageData! as Data)
        let imageView2 = UIImageView(image: advTimeGif)
        imageView2.frame = CGRect(x: 20.0, y: 220.0, width: 50.0, height: 50.0)
        view.addSubview(imageView2)
        
        
        DispatchQueue.main.async {
            AllMethods().callTesting1(with: "Demo", completion: { (LoginData11) in
                //self.loginData = details
                //let demo = details
                //var cmd = LoginCustom()
           //     cmd = (demo[0] as  AnyObject) as! LoginCustom
                 //print(self.loginData[0].Token)
                var parameter : NSString = NSString()
                parameter = "email="
                parameter = parameter.appending("kevin@retptyltd.com") as NSString
                parameter = parameter.appending("&password=") as NSString
                parameter = parameter.appending("@dmin416") as NSString
                print("Testing Demo:==== \(LoginData11[0].Full_Name as String) and Token:== \(LoginData11[0].Token as String)")
               //print("return values \((details[0].value(forKey: "Full_Name" ) as! NSString) as String!)")
            })
           // self.Login()
        }
        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.CallDetail), userInfo: nil, repeats: false)
//        }
//        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.CallArchiveDetail), userInfo: nil, repeats: false)
//        }
//        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 9, target: self, selector: #selector(self.ProviderList), userInfo: nil, repeats: false)
//        }
//        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 11, target: self, selector: #selector(self.ResponsiblePersonList), userInfo: nil, repeats: false)
//        }
//        
//        DispatchQueue.main.async {
//            self.timer = Timer.scheduledTimer(timeInterval: 12, target: self, selector: #selector(self.GetCall), userInfo: nil, repeats: false)
//        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func Submit(_ sender: Any) {
        var parameter : NSString = NSString()
        parameter = "email="
        parameter = parameter.appending("") as NSString
        parameter = parameter.appending("&password=") as NSString
        parameter = parameter.appending("@dmin416") as NSString
        
        DispatchQueue.main.async {
            AllMethods().callTesting1(with: "Demo", completion: { (LoginData11) in
                
                print("Testing Demo:==== \(LoginData11[0].Full_Name as String) and Token:== \(LoginData11[0].Token as String)")
                //print("return values \((details[0].value(forKey: "Full_Name" ) as! NSString) as String!)")
            })
            // self.Login()
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashBoard
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    func Login() {
        print("Login Detail")
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
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
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
                        // var name : String!
                        self.Token = (field[0]["token"] as! NSString) as String!
                        print("Token:="+self.Token)
                        let cmd = CustomData()
                        cmd.Full_Name = (field[0]["full_name"] as! NSString) as String!
                        cmd.Token = (field[0]["token"] as! NSString) as String!
                        cmd.User_Email = (field[0]["user_email"] as! NSString) as String!
                        cmd.User_Id = (field[0]["user_id"] as! NSString) as String!
                        cmd.User_Profile_logo = (field[0]["user_profile_logo"] as! NSString) as String!
                        cmd.User_Provider_Id = (field[0]["user_provider_id"] as! NSString) as String!
                        cmd.User_Status = (field[0]["user_status"] as! NSString) as String!
                        cmd.User_Status = (field[0]["user_type"] as! NSString) as String!
                        self.LoginArray.add(cmd)
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }
    
//closer 
//bloack

    func CallDetail() {
        print("\n\nCall Detail login array count :-\( self.LoginArray.count)")
        let url = NSURL(string: LoginApi.Web_DashBoardDetail as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(self.Token) as NSString
        //parameter = parameter.appending("&password=") as NSString
        //parameter = parameter.appending("@dmin416") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["info"] as! [[String:Any]]
                        var Error : String!
                        Error = (field[0]["error_message"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        for blog in field {
                            print(blog["prv_name"] as! String )
                            let cmd = CustomData()
                            cmd.CD_KPI = blog["cd_KPI"] as! String
                            cmd.CD_Created_Date = blog["cd_created_date"] as! String
                            cmd.CD_Email = blog["cd_email"] as! String
                            cmd.CD_From = blog["cd_from"] as! String
                            cmd.CD_id = blog["cd_id"] as! String
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
                            self.CallDetailArray.add(cmd)
                        }
                  }
            }
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        DispatchQueue.main.async {
            
        }

    }
    
    func CallArchiveDetail() {
        print("\n\nCall Archive Detail :- \(self.CallDetailArray.count)" )
        let url = NSURL(string: LoginApi.Web_DashBoardDetail as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(self.Token) as NSString
        parameter = parameter.appending("&archive=") as NSString
        parameter = parameter.appending("true") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["info"] as! [[String:Any]]
                        var Error : String!
                        Error = (field[0]["error_message"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        for blog in field {
                            let cmd = CustomData()
                            cmd.CD_KPI = blog["cd_KPI"] as! String
                            cmd.CD_Created_Date = blog["cd_created_date"] as! String
                            cmd.CD_Email = blog["cd_email"] as! String
                            cmd.CD_From = blog["cd_from"] as! String
                            cmd.CD_id = blog["cd_id"] as! String
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
                            self.CallArchiveDetailArray.add(cmd)
                        }
                     }
                }
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        DispatchQueue.main.async {
        }
    }

    func ProviderList() {
        print("\n\nProviderList Detail:- \(self.CallArchiveDetailArray.count)")
        let url = NSURL(string: LoginApi.Web_ProviderList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(self.Token) as NSString
        //parameter = parameter.appending("&archive=") as NSString
        //parameter = parameter.appending("true") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        let field = parsedData["msg"] as! [[String:Any]]
                        var Error : String!
                        Error = (field[0]["error_message"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! NSDictionary
                        for (key, value) in field {
                            print ("Key: \( key) for value: \(value)");
                            let cmd = CustomData()
                            cmd.PRV_Id = key as! String
                            cmd.PRV_Name = value as! String
                            self.ProviderListArray.add(cmd)
                        }
                    }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        DispatchQueue.main.async {
            
        }
    }

    func ResponsiblePersonList() {
        print("\n\nResponsiblePersonList Detail := \(ProviderListArray.count)")
        let url = NSURL(string: LoginApi.Web_ResponsiblePersonList as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(self.Token) as NSString
        parameter = parameter.appending("&provider_id=") as NSString
        parameter = parameter.appending("1") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                      //  let field = parsedData["msg"] as! [[String:Any]]
                        var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! NSDictionary
                        for (key, value) in field {
                            print ("Key: \( key) for value: \(value)");
                            let cmd = CustomData()
                            cmd.RP_Id = key as! String
                            cmd.RP_Name = value as! String
                            self.ResponsiblePersonListArray.add(cmd)
                        }
                   }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        DispatchQueue.main.async {
            
        }
    }
    func GetCall() {
        print("\n\nGetCall Detail := \(ResponsiblePersonListArray.count)")
        let url = NSURL(string: LoginApi.Web_GetCall as String)
        var request = URLRequest(url: url as! URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var parameter : NSString = NSString()
        parameter = "token="
        parameter = parameter.appending(self.Token) as NSString
        parameter = parameter.appending("&call_id=") as NSString
        parameter = parameter.appending("8") as NSString
        request.httpBody = parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data)
                print(responseObject)
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let status = parsedData["status"] as! Bool
                    if(!status){
                        //  let field = parsedData["msg"] as! [[String:Any]]
                    var Error : String!
                        Error = parsedData["msg"] as! String//(field[0]["msg"] as! NSString) as String!
                        print(Error)
                    }else{
                        let field = parsedData["data"] as! NSDictionary
                        let cmd = CustomData()
                        cmd.CC_Email_Address = field.value(forKey: "cd_email") as! String
                        print(cmd.CC_Email_Address)
//                        cmd.CC_Email_Address = field.value(forKey:"cc_email_address") as! String
                        cmd.CD_Email = field.value(forKey:"cd_email") as! String
                        cmd.CD_From =  field.value(forKey:"cd_from") as! String
                        cmd.CD_id =  field.value(forKey:"cd_id") as! String
                        cmd.CD_Phone_number =  field.value(forKey:"cd_phone_number") as! String
                        cmd.CD_Provider_Id =  field.value(forKey:"cd_provider_id") as! String
                        cmd.CD_Reason_For_Call =  field.value(forKey:"cd_reason_for_call") as! String
                        cmd.CD_Status =  field.value(forKey:"cd_status") as! String
                        cmd.CD_User_Id =  field.value(forKey:"cd_user_id") as! String
                        cmd.Provider_Name =  field.value(forKey:"provider_name") as! String
                        cmd.Responsible_Person =  field.value(forKey:"responsible_person") as! String
                        self.GetCallArray.add(cmd)
                        print("\n\nGetCall Detail := \(self.GetCallArray.count)")
                    }
                }
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        DispatchQueue.main.async {
            
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

