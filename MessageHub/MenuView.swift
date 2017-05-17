//
//  MenuView.swift
//  SideMenuDemo
//
//  Created by Hardik Davda on 2/23/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class MenuView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var array:Array = [String]()
    @IBOutlet var table: UITableView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblPost: UILabel!
    @IBOutlet var imgLogo: UIImageView!
    var arrayFeatures:Array = [String]()
    var arrayImage:Array = [UIImage]()
    var arrayImageFeatures:Array = [UIImage]()
    var UserType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.USERLOG)
        if let url = NSURL(string: appDelegate.USERLOG as String) {
            if let data = NSData(contentsOf: url as URL){
                imgLogo.layer.masksToBounds = true
                imgLogo.layer.cornerRadius = imgLogo.frame.size.height/2
                imgLogo.image = UIImage(data: data as Data)
            }
        }
        arrayImage = [UIImage(named:"Dashboard")!,UIImage(named:"Search")!,UIImage(named:"ProfileLogo")!,UIImage(named:"Provider")!,UIImage(named:"Profile")!,UIImage(named:"LogOut-1")!]
//        Dashboard
//        Logout
//        Profile
//        Provider
//        Search
//        User

//        Super Admin - 0
//        Agent - 1
//        Staff - 3
//        Provider Admin - 5

        lblName.text = appDelegate.USERNAME as String
        UserType = "SuperAdmin" //Agent //Staff//ProviderAdmin
        if appDelegate.USERTYPEID == "0"{
            lblPost.text = "Super Admin"
            array = ["Dashboard","Search","User","Customers"]
            arrayFeatures = ["Profile","Logout"]

            arrayImage = [UIImage(named:"Dashboard")!,UIImage(named:"Search")!,UIImage(named:"User")!,UIImage(named:"Provider")!]
            arrayImageFeatures = [UIImage(named:"ProfileLogo")!,UIImage(named:"LogOut-1")!]
        }
        
        if appDelegate.USERTYPEID == "1"{
            lblPost.text = "Agent"
            array = ["Dashboard","Search"]
            arrayFeatures = ["Profile","Logout"]
            
            arrayImage = [UIImage(named:"Dashboard")!,UIImage(named:"Search")!]
            arrayImageFeatures = [UIImage(named:"ProfileLogo")!,UIImage(named:"LogOut-1")!]
        }
        
        if appDelegate.USERTYPEID == "3"{
            lblPost.text = "Staff"
            array = ["Dashboard","Search"]
            arrayFeatures = ["Profile","Logout"]
            arrayImage = [UIImage(named:"Dashboard")!,UIImage(named:"Search")!]
            arrayImageFeatures = [UIImage(named:"ProfileLogo")!,UIImage(named:"LogOut-1")!]
        }
        if appDelegate.USERTYPEID == "5"{
            lblPost.text = "Provider Admin"
            array = ["Dashboard","Search","User"]
            arrayFeatures = ["Profile","Logout"]
            arrayImage = [UIImage(named:"Dashboard")!,UIImage(named:"Search")!,UIImage(named:"User")!,]
            arrayImageFeatures = [UIImage(named:"ProfileLogo")!,UIImage(named:"LogOut-1")!]
        }
//        table.reloadData()
        // Do any additional setup after loading the view.
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return array.count
        }else{
            return arrayFeatures.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableCell") as! MenuTableCell
    //    let Cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableCell") as! MenuTableCell
        NSLog("Array value :- %@",array[indexPath.row]);
        if indexPath.section == 0
        {
            Cell.lblAbbrivationName.text =  array[indexPath.row]
            Cell.imgIcone.image = arrayImage[indexPath.row]
            Cell.imgIcone.image = Cell.imgIcone.image!.withRenderingMode(.alwaysTemplate)
            Cell.imgIcone.tintColor = UIColor().hexStringToUIColor(hex: "757575")
        }else{
            
            Cell.lblAbbrivationName.text =  arrayFeatures[indexPath.row]
            Cell.imgIcone.image = arrayImageFeatures[indexPath.row]
            Cell.imgIcone.image = Cell.imgIcone.image!.withRenderingMode(.alwaysTemplate)
            Cell.imgIcone.tintColor = UIColor().hexStringToUIColor(hex: "757575")
        }
        //Cell.lblTitle?.text = array[indexPath.row]
        return Cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         lblName.text = appDelegate.USERNAME as String
       
        let revealViewController:SWRevealViewController = self.revealViewController()
        let cell:MenuTableCell = tableView.cellForRow(at: indexPath) as! MenuTableCell
        
        if cell.lblAbbrivationName.text == "Dashboard"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let disController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")  as! DashBoard
            let newFrontViewController = UINavigationController.init(rootViewController:disController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if cell.lblAbbrivationName.text == "Search"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let disController = mainStoryboard.instantiateViewController(withIdentifier: "search")  as! Search
            let newFrontViewController = UINavigationController.init(rootViewController:disController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }

        if cell.lblAbbrivationName.text == "User"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let disController = mainStoryboard.instantiateViewController(withIdentifier: "userdashboard")  as! UserDashboard
            let newFrontViewController = UINavigationController.init(rootViewController:disController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblAbbrivationName.text == "Customers"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let disController = mainStoryboard.instantiateViewController(withIdentifier: "ProviderDashboard")  as! ProviderDashboard
            let newFrontViewController = UINavigationController.init(rootViewController:disController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblAbbrivationName.text == "Profile"{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let disController = mainStoryboard.instantiateViewController(withIdentifier: "Profile")  as! Profile
            let newFrontViewController = UINavigationController.init(rootViewController:disController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblAbbrivationName.text == "Logout"{
            
            self.showAlert(title: "Are you sure want to logout?" , message: "") {
                confirmed in
                
                if confirmed {
                    print("User replied with YES.")

                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let disController = mainStoryboard.instantiateViewController(withIdentifier: "LoginView")  as! LoginView
                    let newFrontViewController = UINavigationController.init(rootViewController:disController)
                    revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                }
                else {
                    print("User replied with NO.")
                }
            }
        
        }

        
        
        
        //ProviderDashboard
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0;
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let view = UIView()
         view.frame = CGRect(x: 0, y: 0, width:tableView.frame.size.width, height: tableView.frame.size.height)
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1)
        label.backgroundColor = UIColor().hexStringToUIColor(hex: "737373")
       // label.textAlignment = NSTextAlignment.center
        //label.text = "test label"
        view.addSubview(label)
        
        let labelFeatures: UILabel = UILabel()
        labelFeatures.frame = CGRect(x: 30, y: 15, width: tableView.frame.size.width-30, height: 21)
        labelFeatures.textColor = UIColor().hexStringToUIColor(hex: "757575")
        labelFeatures.textAlignment = NSTextAlignment.left
        labelFeatures.text = "Features"
        view.addSubview(labelFeatures)
        return view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
