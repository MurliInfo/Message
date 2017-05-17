//
//  AppDelegate.swift
//  MessageHub
//
//  Created by Hardik Davda on 1/31/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let TESTWEBPATH = NSString()
    let LIVEWEBPATH = NSString()
    var WEBPATH = NSString()
    
    var USERNAME = NSString()
    var TOKEN = NSString()
    var USEREMAIL = NSString()
    var USERID = NSString()
    var USERLOG = NSString()
    var USERPROVIDERID = NSString()
    var USERTYPEID = NSString()
    var USERSTATUS = NSString()
    var USERTYPE = NSString()
    var PROVIDERID = NSString()
    var SUPERADMIN = NSString()
    var AGENT = NSString()
    var PROVIDERADMIN = NSString()
    var STAFF = NSString()
    var LOGINUSER = NSString()
    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let IsLive = true
        //$LPadm!n17
        if IsLive{
            WEBPATH = "https://retptyltd.com/phone_call/api/"
        }else{
            WEBPATH = "https://test1.rettest.com/phone_call/api/"
        }
//        WEBPATH = "Testing Data:-"
        self.applicationTheme()
       
        UIApplication.shared.statusBarStyle = .lightContent

//        "STATUS"
      //  var ststus = defaults.bool(forKey: "STATUS") as Bool
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var destinationController = UIViewController()
        //=storyboard.instantiateViewController(withIdentifier: "dashboard") as? DashBoard
        var frontNavigationController = UINavigationController(rootViewController: destinationController)
        let rearViewController = storyboard.instantiateViewController(withIdentifier: "MenuView") as? MenuView
        let mainRevealController = SWRevealViewController()
        mainRevealController.rearViewController = rearViewController
        
        SUPERADMIN = "0"
        AGENT = "1"
        PROVIDERADMIN = "5"
        STAFF = "3"

        
        if defaults.bool(forKey: "STATUS") as Bool{
            USERNAME = defaults.string(forKey: "FULLNAME")! as NSString
            TOKEN = defaults.string(forKey: "TOKEN")! as NSString
            USEREMAIL = defaults.string(forKey: "USEREMAIL")! as NSString
            USERID = defaults.string(forKey: "USERID")! as NSString
            USERLOG = defaults.string(forKey: "PROFILELOGO")! as NSString
            USERPROVIDERID = defaults.string(forKey: "PROVIDERID")! as NSString
            USERSTATUS = defaults.string(forKey: "USERSTATUS")! as NSString
            USERTYPE = defaults.string(forKey: "USERTYPE")! as NSString
            USERTYPEID = defaults.string(forKey: "USERTYPE")! as NSString
            PROVIDERID = defaults.string(forKey: "PROVIDERID")! as NSString
            print("USER ID \(USERTYPEID)")
//            appDelegate.USERID = field[0]["user_id"] as! NSString
//            appDelegate.USERNAME = field[0]["full_name"] as! NSString
//            appDelegate.USERTYPEID = field[0]["user_type"] as! NSString
            destinationController = (storyboard.instantiateViewController(withIdentifier: "dashboard") as? DashBoard)!
            frontNavigationController = UINavigationController(rootViewController: destinationController)
        }else
        {
            
            destinationController = (storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginView)!
            frontNavigationController = UINavigationController(rootViewController: destinationController)
        }
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let destinationController = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginView
//        let frontNavigationController = UINavigationController(rootViewController: destinationController!)
     
        mainRevealController.rearViewController = rearViewController
        mainRevealController.frontViewController = frontNavigationController
        self.window!.rootViewController = mainRevealController
        self.window?.makeKeyAndVisible()

        
       // TOKEN = "78d96afa575911611f1125678eee5a2e"
        // Override point for customization after application launch.
        return true
    }
    
  var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func applicationTheme(){
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: "3F51B5")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

