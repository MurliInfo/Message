//
//  LoginView.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    @IBOutlet var viewLogin: UIView!
    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var txtEmail: UITextField!

    var defaults = UserDefaults.standard

    @IBOutlet var txtPassword: UITextField!
     @IBOutlet var viewForgotPassword: UIView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        viewForgotPassword.isHidden = true
        
        defaults.set("", forKey: "FULLNAME")
        defaults.set("", forKey: "TOKEN")
        defaults.set("", forKey: "USEREMAIL")
        defaults.set("", forKey: "USERID")
        defaults.set("", forKey: "PROFILELOGO")
        defaults.set("", forKey: "PROVIDERID")
        defaults.set("", forKey: "USERSTATUS")
        defaults.set("", forKey: "USERTYPE")
        defaults.set(false, forKey: "STATUS")
        
        
        appDelegate.USERNAME = ""
        appDelegate.TOKEN = ""
        appDelegate.USEREMAIL = ""
        appDelegate.USERID  = ""
        appDelegate.USERLOG = ""
        appDelegate.USERPROVIDERID = ""
        appDelegate.USERSTATUS = ""
        appDelegate.USERTYPE = ""
        appDelegate.USERTYPEID = ""
        

        // Do any additional setup after loading the view.
    }
    @IBAction func Submit(_ sender: Any) {
        var parameter : NSString = NSString()
        
//        parameter = "email="
//        parameter = parameter.appending("kevin@retptyltd.com") as NSString
//        parameter = parameter.appending("&password=") as NSString
//        parameter = parameter.appending("@dmin416") as NSString
        
        parameter = "email="
        parameter = parameter.appending(txtUserName.text!) as NSString
//         parameter = parameter.appending("kevin@retptyltd.com") as NSString
        parameter = parameter.appending("&password=") as NSString
//         parameter = parameter.appending("$LPadm!n17") as NSString
        parameter = parameter.appending(txtPassword.text!) as NSString
        print(parameter)
        DispatchQueue.main.async {
            AllMethods().callTesting1(with: parameter, completion: { (LoginData11) in
                if LoginData11[0].status == true{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    var destinationController = UIViewController()
                    var frontNavigationController = UINavigationController(rootViewController: destinationController)
                    let rearViewController = storyboard.instantiateViewController(withIdentifier: "MenuView") as? MenuView
                    let mainRevealController = SWRevealViewController()
                    destinationController = (storyboard.instantiateViewController(withIdentifier: "dashboard") as? DashBoard)!
                    frontNavigationController = UINavigationController(rootViewController: destinationController)
                    mainRevealController.rearViewController = rearViewController
                    mainRevealController.frontViewController = frontNavigationController
                    appDelegate.window!.rootViewController = mainRevealController
//                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "dashboard") as! DashBoard
//                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }else{
                    DispatchQueue.main.async {
                        self.ShowAlertMessage(title: "",message: LoginData11[0].User_Type as String,buttonText: "OK")
                    }
                }
            })
        }
    }
    @IBAction func ForgotPassword(_ sender: Any) {
        viewForgotPassword.isHidden = false
        viewLogin.isHidden = true

    }
    @IBAction func signIn(_ sender: Any) {
        viewForgotPassword.isHidden = true
        viewLogin.isHidden = false

    }
    @IBAction func ForgotSubmit(_ sender: Any) {
        var parameter : NSString = NSString()
        parameter = "email=".appending(txtEmail.text!) as NSString
        AllMethods().forgotPassword(with: parameter as String, completion: { (demo) in
            let parsedData = demo
            let status = parsedData["status"] as! Bool
            LoginDetail = [LoginData]()
            if(!status){
               
                self.ShowAlertMessage(title: "",message:  parsedData["msg"] as! String,buttonText: "OK")

            }else{
                LoginDetail = [LoginData]()
                self.ShowAlertMessage(title: "",message: parsedData["msg"] as! String,buttonText: "OK")
                self.viewForgotPassword.isHidden = true
                self.viewLogin.isHidden = false
            }
        })
    }
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LoginView : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
