//
//  DashBoard.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/6/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class DashBoard: UIViewController,CloseDropDownDelegate {
// MARK: - Storyboard Declaration
    @IBOutlet var table: UITableView!
    @IBOutlet var menu: UIButton!
  //  @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet var imgMenuIcone: UIImageView!
    @IBOutlet var imgSearch: UIImageView!
    @IBOutlet var imgArchive: UIImageView!
    @IBOutlet var imgAddCall: UIImageView!
    
    @IBOutlet var txtProvider: UITextField!
    @IBOutlet var txtResponsible: UITextField!
    @IBOutlet var txtStatus: UITextField!
    @IBOutlet var txtSearch: UITextField!
    
    @IBOutlet var viewAdvanceSearch: UIView!
    
    @IBOutlet var viewAdvancAll: UIView!
    
    @IBOutlet var viewTitleSearch: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewResponsibleName: UIView!
    @IBOutlet var viewStatus: UIView!
    @IBOutlet var viewButton: UIView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet var customerView: UIView!
    
    /// Default height = 353
    @IBOutlet var advanceSearchHeightContraint: NSLayoutConstraint!
    
    /// Default height = 60
    @IBOutlet var customerViewHeightContraint: NSLayoutConstraint!
    
    
    // MARK: - Local Declaration
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    let LoginApi = AllWebservices()

    let refresh = UIRefreshControl()
    var timer: Timer!
    var DashboardData = [CallDetailData]()
    var ProvideList = [ProviderListData]()
    var DropDownProviderList = [DropDownListData]()
    var DashboardStatusData = [DropDownListData]()
    var UserList = [ResponsiblePersonListData]()
    var DropDownUserList = [DropDownListData]()
    var ProviderId = NSString()
    var DropDownSelection = NSString()
    var UserId = NSString()
    var StatusId = NSString()
    
    var Load = NSString()
     var PARAMETER = NSString()
    var pageNumber = Int()
    var ISSELECTED = String()
    var NoData = NSString()//No Data Available
    var messageFrame = UIView()
    var COUNT = 0
    var idList : NSMutableArray = []
  

    // MARK: - METHODS
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Token := \(appDelegate.TOKEN)")
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        self.manageAdvanceSearch()
        NoData = ""
        ISSELECTED = "NO"
        self.initialNavigationbar()
//        MenuView().lblName.text = appDelegate.USERNAME as String
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        //GlobalMethods().hexStringToUIColor(hex: "3F51B5")
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;

        self.table.delegate = self
        self.table.dataSource = self
        pageNumber = 0 ;
        Load = "YES"
        
        imgMenuIcone.image = imgMenuIcone.image!.withRenderingMode(.alwaysTemplate)
        imgMenuIcone.tintColor = UIColor.white
        
        imgSearch.image = imgSearch.image!.withRenderingMode(.alwaysTemplate)
        imgSearch.tintColor = UIColor.white
        
        imgArchive.image = imgArchive.image!.withRenderingMode(.alwaysTemplate)
        imgArchive.tintColor = UIColor.white
        
        imgAddCall.image = imgAddCall.image!.withRenderingMode(.alwaysTemplate)
        imgAddCall.tintColor = UIColor.white
        
        //imgAddCall.layer.cornerRadius = imgAddCall.frame.size.height/2
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        ProviderId = ""
        viewAdvanceSearch.isHidden = true
        self.DashboardData = [CallDetailData]()
        DashboardData = [CallDetailData]()
        
//        self.table.addSubview(self.refreshControl)
        DispatchQueue.main.async {
            var parameter = NSString()
            self.pageNumber = 0 ;
            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            parameter = parameter.appending("&dashboard=" as String) as NSString
            parameter = parameter.appending("true" as String) as NSString
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            self.GetCallDetail(parameter: parameter)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()

        if COUNT > 0{
            navigationController?.navigationBar.barTintColor = UIColor().selectTintColor()
        }
        messageFrame = GlobalMethods().progressBarDisplayer(msg: "Loading...", true,sizeView: self.view)
     view.addSubview(messageFrame)
  
        DispatchQueue.main.async {
            self.GetProviderList()
        }
        
        DispatchQueue.main.async {
            self.GetStatusList()
        }
    
        DispatchQueue.main.async {
            self.GetUserList()
        }
        
        DispatchQueue.main.async {
             self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.spiner), userInfo: nil, repeats: false)
        }
        
    //   let viewFromNib: UIView? = Bundle.main.loadNibNamed("PopupView",  owner: self,
     //                                                       options: nil)?.first as! UIView?
      //  viewAdvanceSearch.addSubview(viewFromNib!)
    }

    func spiner(){
        messageFrame.removeFromSuperview()
    }
    
// MARK: - Button Events
    
    @IBAction func AdvanceSearch(_ sender: Any) {
        viewAdvanceSearch.isHidden = false
    }
    
    @IBAction func Archived(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "archived") as! Archived
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func ViewNotes(_ sender: Any) {
        if COUNT == 0{
            let btn = sender
            var PassData = [CallDetailData]()
            var cmd = CallDetailData()
            cmd = DashboardData[(btn as AnyObject).tag]
            PassData.append(cmd)
    
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewNotes") as! ViewNotes
            secondViewController.Status = "Dashboard"
            secondViewController.DashboardData = PassData
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
    
    // MARK: - Add Call
    
    @IBAction func ADDD(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "addcall") as! AddCall
        secondViewController.stringStatus = "Add Call"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func AddCall(_ sender: Any) {

//*******All Comments are Important*******
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addcall") as! AddCall
//        self.present(nextViewController, animated:true, completion:nil)
        
//        It is working as set view as presnet view same as popup
        //
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Pop", bundle:nil)

//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "popup") as! Popup
//        self.addChildViewController(nextViewController)
//        nextViewController.view.frame = self.view.frame
//        self.view.addSubview(nextViewController.view)
//        nextViewController.didMove(toParentViewController: self)

        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "addcall") as! AddCall
        secondViewController.stringStatus = "Add Call"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func SearchMenu(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "search") as! Search
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    @IBAction func UserMenu(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "userdashboard") as! UserDashboard
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    // MARK: - Advance Search click
    
    @IBAction func Cancel(_ sender: Any) {
        self.view.endEditing(true)
        viewAdvanceSearch.isHidden = true
    }
    
    @IBAction func Reset(_ sender: Any) {
        self.view.endEditing(true)
        ProviderId = ""
        txtSearch.text = ""
        txtStatus.text = "Select Status"
        txtProvider.text = "Select Customer"
        txtResponsible.text = "Select Responsible"
        self.deSelectAllCall()
        DispatchQueue.main.async {
            var parameter = NSString()
            self.pageNumber = 0 ;
            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            parameter = parameter.appending("&dashboard=" as String) as NSString
            parameter = parameter.appending("true" as String) as NSString
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            self.GetCallDetail(parameter: parameter)
        }
    }
    
    @IBAction func Search(_ sender: Any) {
        self.view.endEditing(true)
        var parameter = NSString()
        self.pageNumber = 0 ;
        Load = "YES"
        parameter = "token="
        let Page = self.pageNumber as NSNumber
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending("&dashboard=" as String) as NSString
        parameter = parameter.appending("true" as String) as NSString
        
        if ProviderId != "" && ProviderId != "00"{
            parameter = parameter.appending("&provider_id=") as NSString
            parameter = parameter.appending(ProviderId as String) as NSString
        }
        
        if UserId != "" && UserId != "00"{
            parameter = parameter.appending("&responsible_person=") as NSString
            parameter = parameter.appending(UserId as String) as NSString
        }
        
        if txtSearch.text != ""{
            parameter = parameter.appending("&search=") as NSString
            parameter = parameter.appending(txtSearch.text!) as NSString
        }
        
        if txtStatus.text != "" && txtStatus.text != "Select Status"{
            parameter = parameter.appending("&status=") as NSString
            parameter = parameter.appending(StatusId as String) as NSString
        }
        
        self.PARAMETER = parameter
        parameter = parameter.appending("&page_no=" as String) as NSString
        parameter = parameter.appending(Page.stringValue as String) as NSString
        self.DashboardData = [CallDetailData]()
      
        self.GetCallDetail(parameter: parameter)
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
    
    @IBAction func makeCall(_ sender: Any) {
        if COUNT == 0{
            let btn = sender;
            var Index = Int()
            Index = (btn as AnyObject).tag
            let mobile = ("telprompt://").appending(DashboardData[Index].CD_Phone_number)
            guard let number = URL(string: mobile) else { return }
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(number, options: [:], completionHandler: nil)
                } else {
            }
        }
    }
    
    @IBAction func SelectProvider(_ sender: Any) {
            self.view.endEditing(true)
        if !self.DropDownView.isDescendant(of: self.viewAdvanceSearch){
            if self.DropDownProviderList.count > 0 {
            
                DropDownSelection = "SelectProvider"
                let frame = CGRect(x: txtProvider.frame.origin.x+12, y: viewAdvancAll.frame.origin.y+viewProviderName.frame.origin.y+txtProvider.frame.origin.y+txtProvider.frame.height+1, width: txtProvider.frame.width+5, height: 400)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DropDownProviderList)
                self.viewAdvanceSearch.addSubview(DropDownView)
                dropdown.delegate = self
            }
         }else{
              self.DropDownView.removeFromSuperview()
        }
    }
    
    @IBAction func SelecteResponsible(_ sender: Any) {
        self.view.endEditing(true)
        if txtProvider.text != "Select Customer"{
         if !self.DropDownView.isDescendant(of: self.viewAdvanceSearch){
            if self.DropDownUserList.count > 0 {
                DropDownSelection = "SelecteResponsible"
                let frame = CGRect(x: txtResponsible.frame.origin.x+12, y: viewAdvancAll.frame.origin.y+viewResponsibleName.frame.origin.y+txtResponsible.frame.origin.y+txtResponsible.frame.height+1, width: txtResponsible.frame.width+5, height: 400)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DropDownUserList)
                self.viewAdvanceSearch.addSubview(DropDownView)
                dropdown.delegate = self
            }
         }else{
              self.DropDownView.removeFromSuperview()
        }
        }
    }

    @IBAction func SelectStatus(_ sender: Any) {
        if !self.DropDownView.isDescendant(of: self.viewAdvanceSearch){
            if self.DashboardStatusData.count > 0 {
                DropDownSelection = "SelectStatus"
                let frame = CGRect(x: txtStatus.frame.origin.x+12, y: viewAdvancAll.frame.origin.y+viewStatus.frame.origin.y+txtStatus.frame.origin.y+txtStatus.frame.height+1, width: txtStatus.frame.width+5, height: 400)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DashboardStatusData)
                self.viewAdvanceSearch.addSubview(DropDownView)
                dropdown.delegate = self
            }
          }else{
              self.DropDownView.removeFromSuperview()
        }
    }

    // MARK: - Dropdown Delagete
    
    func SelectedValue(time:NSInteger){
        if DropDownSelection == "SelecteResponsible"{
            txtResponsible.text = self.DropDownUserList[time].Drp_Name
            UserId = self.DropDownUserList[time].Drp_Id as NSString
            //print("Hey my delegate is workin\(UserId)")
            dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectProvider"{
            txtProvider.text = self.DropDownProviderList[time].Drp_Name
            ProviderId = self.DropDownProviderList[time].Drp_Id as NSString
            //print("Hey my delegate is workin\(ProviderId)")
            self.DropDownUserList = [DropDownListData]()
            txtResponsible.text = "Select Responsible"
            self.GetUserList()
            dropdown.removeFromSuperview()
        }
        else{
            StatusId = self.DashboardStatusData[time].Drp_Id as NSString
             txtStatus.text = self.DashboardStatusData[time].Drp_Name
        }
    }
    
    // MARK: - UDF methods
    
    func manageAdvanceSearch() {
        
        
        if appDelegate.USERTYPE == appDelegate.STAFF{
            
            self.advanceSearchHeightContraint.constant -= self.customerViewHeightContraint.constant
            self.customerViewHeightContraint.constant = 0
            self.customerView.isHidden = true
            
        }else {
            self.customerView.isHidden = false
            self.customerViewHeightContraint.constant = 60
            self.advanceSearchHeightContraint.constant = 353
        }
        
        
//        if appDelegate.USERTYPE == "5"{
//           
//            self.viewProviderName.isHidden = true
//            
//            
//            var frameCC : CGRect = self.viewResponsibleName.frame;
//            frameCC.origin.y = self.viewProviderName.frame.origin.y//+self.viewSearch.frame.origin.y
//            self.viewResponsibleName.frame = frameCC
//            
//            frameCC = self.viewStatus.frame;
//            frameCC.origin.y = self.viewResponsibleName.frame.size.height+self.viewResponsibleName.frame.origin.y
//            self.viewStatus.frame = frameCC
//            
//            frameCC = self.viewButton.frame;
//            frameCC.origin.y = self.viewStatus.frame.size.height+self.viewStatus.frame.origin.y
//            self.viewButton.frame = frameCC
//            
//             self.viewProviderName.isHidden = true
//        }else{
        
        
//        viewTitleSearch
//        viewSearch
//        viewProviderName
//        viewResponsibleName
//        viewStatus
//        viewButton
       // }
    }
    
    func GetCallDetail(parameter :NSString){
        //print("Paramete \(parameter)")
        
        AllMethods().callDetail(with: parameter as String, Page: pageNumber, completion: { (dashboardData) in
            if self.DashboardData.count == dashboardData.count && dashboardData.count != 15 {
                //print("No Load \(dashboardData.count)")
                self.Load = "NO"
            }
            self.DashboardData = dashboardData
            self.viewAdvanceSearch.isHidden = true
            self.NoData = "No Data Available"
            self.table.reloadData()
        })
    }
    func GetProviderList(){
        var parameter : NSString
        parameter = ""
        
        AllMethods().providerList(with: parameter as String, completion: { (ProviderList) in
            //print("providerList call")
            self.ProvideList = [ProviderListData]()
            self.ProvideList = ProviderList
            self.DropDownProviderList = [DropDownListData]()
            DispatchQueue.main.async {
                for  i in 0..<self.ProvideList.count{
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
            self.DashboardStatusData = [DropDownListData]()
           for i in 0..<dashboardData.count-1{
                let cmd = DropDownListData(Drp_Id: dashboardData[i].Drp_Id, Drp_StateId: dashboardData[i].Drp_StateId, Drp_Name: dashboardData[i].Drp_Name)
                self.DashboardStatusData.append(cmd)
            }
        })
    }
    
    func GetUserList()  {
        if appDelegate.USERTYPE == "5"{
            
        }
        var parameter = NSString()
        parameter = ""
        self.DropDownUserList = [DropDownListData]()
            if ProviderId != "" && ProviderId != "00"{
                parameter = parameter.appending("&provider_id=") as NSString
                parameter = parameter.appending(ProviderId as String) as NSString
            }
        if appDelegate.USERTYPE == "5"{
            parameter = ""
            parameter = parameter.appending("&provider_id=") as NSString
            parameter = parameter.appending(appDelegate.USERPROVIDERID as String) as NSString

        }
        AllMethods().responsiblePersonList(with: parameter as String, completion: { (ResponsiblePerson) in
                self.UserList = [ResponsiblePersonListData]()
                self.UserList = ResponsiblePerson
                DispatchQueue.main.async {
                    self.DropDownUserList = [DropDownListData]()
                    for  i in 0..<self.UserList.count{
                        var cmd = DropDownListData()
                        cmd.Drp_Id = self.UserList[i].RP_Id as String
                        cmd.Drp_Name = self.UserList[i].RP_Name as String
                        self.DropDownUserList.append(cmd)
                    }
                }
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.spiner), userInfo: nil, repeats: false)
        })
    }
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        print("Refresh ")
         refreshControl.endRefreshing()
//        self.Reset(refreshControl)
//        DispatchQueue.main.async {
//            var parameter = NSString()
//            self.pageNumber = 0 ;
//            self.Load = "YES"
//            parameter = "token="
//            let Page = self.pageNumber as NSNumber
//            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
//            parameter = parameter.appending("&dashboard=" as String) as NSString
//            parameter = parameter.appending("true" as String) as NSString
//            self.PARAMETER = parameter
//            parameter = parameter.appending("&page_no=" as String) as NSString
//            parameter = parameter.appending(Page.stringValue as String) as NSString
//            self.DashboardData = [CallDetailData]()
//            self.GetCallDetail(parameter: parameter)
//        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Reset), userInfo: nil, repeats: false)
        
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
    
    func GoArchive(){
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=2")
     //   LoginApi.Web_CallStatus
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&cd_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
            //print(parameter)
//        
//        var URL = String()
//        URL = ""
      AllMethods().changeStatus(with: parameter , API: LoginApi.Web_CallStatus as String, completion: {(Response) in
        self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
        self.deSelectAllCall()
        
        DispatchQueue.main.async {
            var parameter = NSString()
            self.pageNumber = 0 ;
            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            parameter = parameter.appending("&dashboard=" as String) as NSString
            parameter = parameter.appending("true" as String) as NSString
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            self.GetCallDetail(parameter: parameter)
        }
        
        
        })
    }

    func GoInProgress()  {
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=0")
        
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&cd_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
        
        //print(parameter)

        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_CallStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                self.pageNumber = 0 ;
                self.Load = "YES"
                parameter = "token="
                let Page = self.pageNumber as NSNumber
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                parameter = parameter.appending("&dashboard=" as String) as NSString
                parameter = parameter.appending("true" as String) as NSString
                self.PARAMETER = parameter
                parameter = parameter.appending("&page_no=" as String) as NSString
                parameter = parameter.appending(Page.stringValue as String) as NSString
                self.DashboardData = [CallDetailData]()
                self.GetCallDetail(parameter: parameter)
            }
        })
    }
   
    func rowSelection(row : Int) {
        var Index = Int()
        Index = row
        if DashboardData[Index].SELECTED == 0{
            DashboardData[Index].SELECTED = 1
        }else{
            DashboardData[Index].SELECTED = 0
        }
        COUNT = 0
        self.idList = []
        for i in 0..<self.DashboardData.count{
            COUNT = COUNT+DashboardData[i].SELECTED
            if DashboardData[i].SELECTED == 1{
                //print(DashboardData[i].CD_Id)
                self.idList.add(DashboardData[i].CD_Id)
            }
        }
        
        if COUNT == 0{
            self.initialNavigationbar()
        }else if COUNT == 1{
             let count = "\(COUNT)"
            self.title = ""
            navigationController?.navigationBar.barTintColor = UIColor().selectTintColor()
            let button1 = UIBarButtonItem(title: "Completed", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoArchive))
            
            let button2 = UIBarButtonItem(title: "In Progress", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoInProgress))
            
            let button3 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoInProgress))
            
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.nullAll))
            
            self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)

            self.navigationItem.setRightBarButtonItems([button1,button2, button3], animated: true)

            self.navigationController?.navigationBar.tintColor = UIColor.white;
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem!.tintColor = UIColor.white
        }else{
            let count = "\(COUNT)"
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.nullAll))
            
            self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
        }
        ISSELECTED = "YES"
        let indexPath = NSIndexPath(row: Index, section: 0)
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
    }
    
    func deSelectAllCall()  {
        COUNT = 0
        idList =  NSMutableArray()
        for i in 0..<self.DashboardData.count{
             DashboardData[i].SELECTED = 0
        }
        self.initialNavigationbar()
        table.reloadData()
    }

    func initialNavigationbar()  {
        self.title = "Dashboard"
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardFilterSet"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.AdvanceSearch(_:)))
        
        let button2 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardArchive"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.Archived(_:)))
        
//        if appDelegate.USERTYPEID == appDelegate.STAFF{
//            let button3 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoInProgress))
//            self.navigationItem.setRightBarButtonItems([button1,button2, button3], animated: true)
//            
//        }else{
            let button3 = UIBarButtonItem(image:#imageLiteral(resourceName: "AddCall"), style: UIBarButtonItemStyle.plain, target: self, action:  #selector(DashBoard.AddCall(_:)))
            self.navigationItem.setRightBarButtonItems([button1,button2, button3], animated: true)
//        }
//        let button3 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoInProgress))
        
//        let button3 = UIBarButtonItem(image:#imageLiteral(resourceName: "AddCall"), style: UIBarButtonItemStyle.plain, target: self, action:  #selector(DashBoard.AddCall(_:)))
        
//        self.navigationItem.setRightBarButtonItems([button1,button2, button3], animated: true)
        
        let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "SideBarMenu"), style: UIBarButtonItemStyle.plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        
        let button5 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.nullAll))
        
        self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem!.tintColor = UIColor.white
    }
    
    func nullAll()  {
    }

    func loadMore(){
        DispatchQueue.main.async {
            self.pageNumber = self.pageNumber+1
            let Page = self.pageNumber as NSNumber
       var parameter = self.PARAMETER
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.GetCallDetail(parameter: parameter)
        }
    }
}

// MARK: - UITableview Delegate and DataSourse

extension DashBoard : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.DashboardData.count > 0 {
             TableViewHelper.EmptyMessage(message: "", viewController: self.table)
            return self.DashboardData.count
        } else {
            TableViewHelper.EmptyMessage(message: NoData as String, viewController: self.table)
            return 0
        }
    }

    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        let printData = self.DashboardData[indexPath.row]
        cell.backgroundColor = UIColor.white
        cell.btnMakeCall.tag = indexPath.row
        
        cell.lblAbbrivation.layer.masksToBounds = true
        cell.lblAbbrivation.backgroundColor = UIColor().hexStringToUIColor(hex: DashboardData[indexPath.row].PRV_Abbr_Color)
        cell.lblAbbrivation.layer.cornerRadius = cell.lblAbbrivation.frame.size.height/2

        cell.imgCall.image = cell.imgCall.image!.withRenderingMode(.alwaysTemplate)
        cell.imgCall.tintColor = UIColor().greenColor()//GlobalMethods().hexStringToUIColor(hex: "388E3C")
        cell.lblNoteCount.layer.masksToBounds = true
        cell.lblNoteCount.layer.cornerRadius = cell.lblNoteCount.frame.size.height/2
        cell.imgClock.image = cell.imgClock.image!.withRenderingMode(.alwaysTemplate)
        // GlobalMethods().hexStringToUIColor(hex: "388E3C")
        
        cell.lblAbbrivationName.text = DashboardData[indexPath.row].CD_From as String
        cell.lblAbbrivation.text = DashboardData[indexPath.row].PRV_Abbr as String
        cell.lblDate.text = DashboardData[indexPath.row].CD_Created_Date as String
//       cell.lblResponcible.text = DashboardData[indexPath.row].Responsible_Person as String
        cell.lblStatus.text = DashboardData[indexPath.row].CD_Status as String
        cell.lblNumber.text = DashboardData[indexPath.row].CD_Phone_number as String
        cell.lblKPITime.text = DashboardData[indexPath.row].CD_KPI as String
       
        if printData.CD_Status == "Not Started"{
                cell.lblStatus.textColor = UIColor.red
        }else{
            cell.lblStatus.textColor = UIColor().yelloColor()
        }
        
        if printData.CD_Is_Overdue == true{
            cell.imgClock.tintColor = UIColor().orangColor()
            cell.lblKPITime.textColor = UIColor().orangColor()
        }else{
            cell.imgClock.tintColor = UIColor().greenColor()
            cell.lblKPITime.textColor = UIColor().greenColor()
        }
        
        if  DashboardData[indexPath.row].Cd_Notes_Count == "0"{
            cell.lblNoteCount.backgroundColor = UIColor().greenColor()
        }else{
            cell.lblNoteCount.backgroundColor = UIColor().orangColor()
        }
        
        cell.imgRound.image = UIImage (named: "")
        if printData.SELECTED == 1{
            cell.backgroundColor = UIColor().hexStringToUIColor(hex:"E0E0E0")
            cell.lblAbbrivation.text = ""
            cell.lblAbbrivation.backgroundColor = UIColor().selectTintColor()
            cell.imgRound.image = #imageLiteral(resourceName: "Save(Done)")
        }
        
        cell.lblNoteCount.text = DashboardData[indexPath.row].Cd_Notes_Count as String //as NSInteger).stringValue
        cell.btnSelect.tag = indexPath.row
        cell.btnNotes.tag = indexPath.row
        if self.Load == "YES"{
            if indexPath.row == self.DashboardData.count - 1 {
                self.loadMore()
                }
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if COUNT == 0{
//            if appDelegate.USERTYPEID != appDelegate.STAFF{
            var PassData = [CallDetailData]()
            var cmd = CallDetailData()
            cmd = DashboardData[indexPath.row]
            PassData.append(cmd)
            let second = self.storyboard?.instantiateViewController(withIdentifier: "addcall") as! AddCall
            second.stringStatus = "View Call"
            second.GetData = PassData
            self.navigationController?.pushViewController(second, animated: true)
//            }
        }else{
            self.rowSelection(row: indexPath.row)
        }
        return indexPath
    }
}

// MARK: - TextField Delegate

extension DashBoard : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
