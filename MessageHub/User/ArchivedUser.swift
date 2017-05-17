//
//  ArchivedUser.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/24/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class ArchivedUser: UIViewController,CloseDropDownDelegate {
    @IBOutlet var table: UITableView!
   
    
    @IBOutlet var txtProvider: UITextField!
    @IBOutlet var txtResponsible: UITextField!
    @IBOutlet var txtStatus: UITextField!
    @IBOutlet var txtSearch: UITextField!
    
    @IBOutlet var viewAdvanceSearch: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewResponsibleName: UIView!
    @IBOutlet var viewStatus: UIView!
    @IBOutlet var viewAdvancAll: UIView!
    
    // MARK: - Local Declaration
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
    let refresh = UIRefreshControl()
    var timer: Timer!
    var userList = [UserListData]()
    var ProvideList = [ProviderListData]()
    var DropDownProviderList = [DropDownListData]()
    var DashboardStatusData = [DropDownListData]()
    var UserList = [ResponsiblePersonListData]()
    var DropDownUserList = [DropDownListData]()
    var ProviderId = NSString()
    var DropDownSelection = NSString()
    var UserId = NSString()
    
    var NoData = NSString()//No Data Available
    var messageFrame = UIView()
    
    var COUNT = 0
    var idList : NSMutableArray = []

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        NoData = ""//No Data Available
        navigationController?.navigationBar.barTintColor = UIColor().hexStringToUIColor(hex: "3F51B5")
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.table.delegate = self
        self.table.dataSource = self
        
        // btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
//        btnMenu.target = revealViewController()
//        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
//        
        self.table.addSubview(self.refreshControl)
        self.table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageFrame = GlobalMethods().progressBarDisplayer(msg: "Loading...", true,sizeView: self.view)
        view.addSubview(messageFrame)
        
        NoData = ""//No Data Available
        //self.navigationController?.isNavigationBarHidden = true
        self.Reset(animated)
        ProviderId = ""
        viewAdvanceSearch.isHidden = true
        self.userList = [UserListData]()
        userList = [UserListData]()
        print("View will")
        //   self.table.reloadData()
        
        DispatchQueue.main.async {
            var parameter = NSString()
            parameter = "token="
            parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=").appending("2") as NSString
            self.userList = [UserListData]()
            //self.DashboardData = dashboardData
            self.GetUserDetail(parameter: parameter)
        }
        DispatchQueue.main.async {
            self.GetProviderList()
        }
        
        DispatchQueue.main.async {
            self.GetStatusList()
        }
        DispatchQueue.main.async {
            self.GetUserList()
        }
        
    }
    func spiner(){
        messageFrame.removeFromSuperview()
    }
    // MARK: - Button Events
    
    @IBAction func AdvanceSearch(_ sender: Any) {
        print("Advance Search")
        viewAdvanceSearch.isHidden = false
    }
    // MARK: - Add Call
    
    
    // MARK: - Advance Search click
    @IBAction func Cancel(_ sender: Any) {
        self.view.endEditing(true)
        viewAdvanceSearch.isHidden = true
    }
    
    @IBAction func Reset(_ sender: Any) {
        self.view.endEditing(true)
        ProviderId = ""
        txtSearch.text = ""
//        txtStatus.text = "Select Status"
        txtProvider.text = "Select Customer"
        txtResponsible.text = "Select Responsible"
        DispatchQueue.main.async {
            var parameter = NSString()
            parameter = "token="
            parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=").appending("2") as NSString
            self.userList = [UserListData]()
            //self.DashboardData = dashboardData
            self.GetUserDetail(parameter: parameter)
        }
        //        DispatchQueue.main.async {
        //            var parameter = NSString()
        //            parameter = "token="
        //            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        //            self.GetCallDetail(parameter: parameter)
        //        }
    }
    
    @IBAction func SelectCall(_ sender: Any) {
        let btn = sender;
        var Index = Int()
        //        guard let number = URL(string: "telprompt://9979217452") else { return }
        //        if #available(iOS 10.0, *) {
        //            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        //        } else {
        // Fallback on earlier versions
        //        }
        Index = (btn as AnyObject).tag
        self.rowSelection(row: Index)
        
    }
    

    
    @IBAction func Search(_ sender: Any) {
        self.view.endEditing(true)
        // var parameter = NSString()
        
        var parameter = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=").appending("2") as NSString
        //self.DashboardData = dashboardData
        
        //parameter = "token="
        // parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        
        if ProviderId != "" && ProviderId != "00"{
            parameter = parameter.appending("&user_provider_id=") as NSString
            parameter = parameter.appending(ProviderId as String) as NSString
        }
        if UserId != "" && UserId != "00"{
            parameter = parameter.appending("&user_id=") as NSString
            parameter = parameter.appending(UserId as String) as NSString
        }
        if txtSearch.text != ""{
            parameter = parameter.appending("&search=") as NSString
            parameter = parameter.appending(txtSearch.text!) as NSString
        }
//        if txtStatus.text != "" && txtStatus.text != "Select Status"{
//            parameter = parameter.appending("&status=") as NSString
//            parameter = parameter.appending(txtStatus.text!) as NSString
//        }
        //user_type
        self.userList = [UserListData]()
        
        print("Parameter \(parameter)")
        
        self.GetUserDetail(parameter: parameter)
        
        /*      "provider_id"
         "status"
         "responsible_person"
         "search"
         */
    }
    @IBAction func SelectProvider(_ sender: Any) {
        self.view.endEditing(true)
        if self.DropDownProviderList.count > 0 {
            
            DropDownSelection = "SelectProvider"
            let frame = CGRect(x: txtProvider.frame.origin.x+10, y: viewAdvancAll.frame.origin.y+viewProviderName.frame.origin.y+txtProvider.frame.origin.y+txtProvider.frame.height, width: txtProvider.frame.width, height: 400)
            dropdown.delegate = self
            dropdown.removeFromSuperview()
            DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DropDownProviderList)
            self.viewAdvanceSearch.addSubview(DropDownView)
            dropdown.delegate = self
        }
    }
    
    @IBAction func SelecteResponsible(_ sender: Any) {
        self.view.endEditing(true)
        self.view.endEditing(true)
        if self.DropDownUserList.count > 0 {
            DropDownSelection = "SelecteResponsible"
            let frame = CGRect(x: txtResponsible.frame.origin.x+10, y: viewAdvancAll.frame.origin.y+viewResponsibleName.frame.origin.y+txtResponsible.frame.origin.y+txtResponsible.frame.height, width: txtResponsible.frame.width, height: 400)
            dropdown.delegate = self
            dropdown.removeFromSuperview()
            DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DropDownUserList)
            self.viewAdvanceSearch.addSubview(DropDownView)
            dropdown.delegate = self
        }
    }
    
    @IBAction func SelectStatus(_ sender: Any) {
        if self.DashboardStatusData.count > 0 {
            DropDownSelection = "SelectStatus"
            let frame = CGRect(x: txtStatus.frame.origin.x+10, y: viewAdvancAll.frame.origin.y+viewStatus.frame.origin.y+txtStatus.frame.origin.y+txtStatus.frame.height, width: txtStatus.frame.width, height: 400)
            dropdown.delegate = self
            dropdown.removeFromSuperview()
            DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DashboardStatusData)
            self.viewAdvanceSearch.addSubview(DropDownView)
            dropdown.delegate = self
        }
    }
    
    // MARK: - Dropdown Delagete
    
    func SelectedValue(time:NSInteger){
        if DropDownSelection == "SelecteResponsible"
        {
            txtResponsible.text = self.DropDownUserList[time].Drp_Name
            UserId = self.DropDownUserList[time].Drp_Id as NSString
            print("Hey my delegate is workin\(UserId)")
            dropdown.removeFromSuperview()
            
        }else if DropDownSelection == "SelectProvider"{
            txtProvider.text = self.DropDownProviderList[time].Drp_Name
            ProviderId = self.DropDownProviderList[time].Drp_Id as NSString
            print("Hey my delegate is workin\(ProviderId)")
            self.DropDownUserList = [DropDownListData]()
            txtResponsible.text = "Select Responsible"
            self.GetUserList()
            dropdown.removeFromSuperview()
        }
        else{
            
            txtStatus.text = self.DashboardStatusData[time].Drp_Name
        }
    }
    
    // MARK: - UDF methods
    func GetUserDetail(parameter :NSString){
        print("Paramete \(parameter)")
        
        AllMethods().UserListDetail(with: parameter as String, completion: { (dashboardData) in
            //    print("Testing Demo:==== \(dashboardData[0].CD_From as String) and Token:== \(dashboardData[0].CD_KPI as String)")
            //self.DashboardData = [CallDetailData]()
            self.userList = dashboardData
            self.viewAdvanceSearch.isHidden = true
            self.NoData = "No Data Available"
            self.table.reloadData()
        })
    }
    
    func GetProviderList(){
        var parameter : NSString
        parameter = ""
        AllMethods().providerList(with: parameter as String, completion: { (ProviderList) in
            print("providerList call")
            self.ProvideList = [ProviderListData]()
            self.ProvideList = ProviderList
            DispatchQueue.main.async {
                for  i in 0..<self.ProvideList.count{
                    //print("demo \(self.ProvideList[i].PRV_Name as String)")
                    var cmd = DropDownListData()
                    cmd.Drp_Id = self.ProvideList[i].PRV_Id as String
                    cmd.Drp_Name = self.ProvideList[i].PRV_Name as String
                    self.DropDownProviderList.append(cmd)
                }
            }
        })
    }
    
    func GetStatusList(){
        AllMethods().statusList(with: "Demo", completion: { (dashboardData) in
            print("statusList call")
            self.DashboardStatusData = [DropDownListData]()
            self.DashboardStatusData = dashboardData
            //                self.table.reloadData()
        })
    }
  
    func GetUserList()  {
        self.DropDownUserList = [DropDownListData]()
         if appDelegate.USERTYPEID == "1"{
        //Agent
            
            let cmd = DropDownListData(Drp_Id: "0", Drp_StateId: "0", Drp_Name: "Select User type");
            self.DropDownUserList.append(cmd)
            let cmd1 = DropDownListData(Drp_Id: "5", Drp_StateId: "5", Drp_Name: "Admin");
            self.DropDownUserList.append(cmd1)
            let cmd2 = DropDownListData(Drp_Id: "3", Drp_StateId: "3", Drp_Name: "Staff");
            self.DropDownUserList.append(cmd2)
            
         }else{
            let cmd = DropDownListData(Drp_Id: "0", Drp_StateId: "0", Drp_Name: "Select User type");
            self.DropDownUserList.append(cmd)
            let cmd1 = DropDownListData(Drp_Id: "5", Drp_StateId: "5", Drp_Name: "Admin");
            self.DropDownUserList.append(cmd1)
            let cmd3 = DropDownListData(Drp_Id: "1", Drp_StateId: "1", Drp_Name: "Agent");
            self.DropDownUserList.append(cmd3)
            
            let cmd2 = DropDownListData(Drp_Id: "3", Drp_StateId: "3", Drp_Name: "Staff");
            self.DropDownUserList.append(cmd2)
        }
//        self.DropDownUserList = [DropDownListData]()
//        if ProviderId != "" && ProviderId != "00"{
//            parameter = parameter.appending("&provider_id=") as NSString
//            parameter = parameter.appending(ProviderId as String) as NSString
//        }
//        AllMethods().responsiblePersonList(with: parameter as String, completion: { (ResponsiblePerson) in
//            self.UserList = [ResponsiblePersonListData]()
//            self.UserList = ResponsiblePerson
//            NSLog("Count := %d", ResponsiblePerson.count)
//            DispatchQueue.main.async {
//                self.DropDownUserList = [DropDownListData]()
//                for  i in 0..<self.UserList.count{
//                    //print("demo \(self.UserList[i].RP_Name as String)")
//                    var cmd = DropDownListData()
//                    cmd.Drp_Id = self.UserList[i].RP_Id as String
//                    cmd.Drp_Name = self.UserList[i].RP_Name as String
//                    self.DropDownUserList.append(cmd)
//                }
//            }
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.spiner), userInfo: nil, repeats: false)
//        })
    }
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        print("Refresh ")
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(stopReferesh), userInfo: nil, repeats: false)
    }
    
    func stopReferesh()  {
        print("Stop Refresh")
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func GoActive(){
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=1")
        //   LoginApi.Web_CallStatus
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&user_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
            
        }
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_UserStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                self.userList = [UserListData]()
                var parameter = NSString()
                parameter = "token="
                parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=").appending("2") as NSString
                self.userList = [UserListData]()
                //self.DashboardData = dashboardData
                self.GetUserDetail(parameter: parameter)
            }
        })
    }
    
    func GoInactive()  {
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=0")
        
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&user_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
        //print(parameter)
        
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_UserStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                parameter = "token="
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                self.userList = [UserListData]()
                //self.DashboardData = dashboardData
                self.GetUserDetail(parameter: parameter)
            }
        })
    }
    func GoArchivew()  {
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=2")
        
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&user_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
        //print(parameter)
        
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_UserStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                parameter = "token="
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                self.userList = [UserListData]()
                //self.DashboardData = dashboardData
                self.GetUserDetail(parameter: parameter)
            }
        })
    }
    
    
    func rowSelection(row : Int) {
        var Index = Int()
        Index = row
        if userList[Index].SELECTED == 0{
            userList[Index].SELECTED = 1
        }else{
            userList[Index].SELECTED = 0
        }
        COUNT = 0
        self.idList = []
        for i in 0..<self.userList.count{
            COUNT = COUNT+userList[i].SELECTED
            if userList[i].SELECTED == 1{
                //print(DashboardData[i].CD_Id)
                self.idList.add(userList[i].User_Id)
            }
        }
        
        if COUNT == 0{
            self.initialNavigationbar()
        }else {//if COUNT == 1{
            let count = "\(COUNT)"
            self.title = ""
            navigationController?.navigationBar.barTintColor = UIColor().selectTintColor()
            let button1 = UIBarButtonItem(title: "Active", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedUser.GoActive))
            
            let button2 = UIBarButtonItem(title: "Inactive", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedUser.GoInactive))
           
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Logout"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedUser.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedUser.nullAll))
            
            self.navigationItem.setRightBarButtonItems([button1,button2,button5,button4], animated: true)
            
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        }

        let indexPath = NSIndexPath(row: Index, section: 0)
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
    }
    
    func deSelectAllCall()  {
        COUNT = 0
        idList =  NSMutableArray()
        for i in 0..<self.userList.count{
            userList[i].SELECTED = 0
        }
        self.initialNavigationbar()
        table.reloadData()
    }
    
    func initialNavigationbar()  {
        self.title = "Archived User"
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardFilterSet"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedUser.AdvanceSearch(_:)))
        
        let button2 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedUser.nullAll))
        
        let button4 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self , action: #selector(ArchivedUser.nullAll))
        
        let button5 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.nullAll))
        
        self.navigationItem.setRightBarButtonItems([button1,button2,button4,button5], animated: true)

        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
    }
    
    func nullAll()  {
        
    }
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableview Delegate and DataSourse

extension ArchivedUser : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userList.count > 0 {
            return self.userList.count
        } else {
            TableViewHelper.EmptyMessage(message: self.NoData as String, viewController: self.table)
            return 0
        }
    }
    
    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        let printData = userList[indexPath.row]
        cell.btnSelect.tag = indexPath.row
        cell.backgroundColor = UIColor.white
        
        cell.lblAbbrivation.layer.masksToBounds = true
        cell.lblAbbrivation.backgroundColor =  UIColor().hexStringToUIColor(hex: userList[indexPath.row].Prv_Abbr_Color)
        cell.lblAbbrivation.layer.cornerRadius = cell.lblAbbrivation.frame.size.height/2
        cell.lblAbbrivation.text = userList[indexPath.row].Provider_Abbr as String
        cell.lblUserName.text = userList[indexPath.row].User_Fname as String
        cell.lblUserType.text = userList[indexPath.row].User_Type_Name as String
        //cell.lblModifyBy.text = userList[indexPath.row].Modify_By as String
        //cell.lblUserModifidDate.text = userList[indexPath.row].User_Modified_Date as String
        cell.lblUserEmail.text = userList[indexPath.row].User_Email as String
        if printData.User_Status_Name as String == "Active"{
            cell.lblStatus.textColor = UIColor().greenColor()
        }else{
            cell.lblStatus.textColor = UIColor().yelloColor()
        }
       
        
        cell.imgRound.image = UIImage (named: "")
        if printData.SELECTED == 1{
            cell.backgroundColor = UIColor().selectCellColor()
            cell.lblAbbrivation.text = ""
            cell.lblAbbrivation.backgroundColor = UIColor().selectTintColor()
            cell.imgRound.image = #imageLiteral(resourceName: "Save(Done)")
        }
        cell.lblStatus.text = userList[indexPath.row].User_Status_Name as String
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
          if COUNT == 0{
//            var PassData = [UserListData]()
//            let cmd = userList[indexPath.row]
//            PassData.append(cmd)
//            let second = self.storyboard?.instantiateViewController(withIdentifier: "AddUser") as! AddUser
//            second.stringStatus = "View User"
//            second.GetData = PassData
//            self.navigationController?.pushViewController(second, animated: true)
        }else{
            self.rowSelection(row: indexPath.row)
        }
        return indexPath
    }
}

// MARK: - TextField Delegate
extension ArchivedUser : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
