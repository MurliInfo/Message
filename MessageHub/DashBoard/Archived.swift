//
//  Archived.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/22/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class Archived: UIViewController,CloseDropDownDelegate {

    @IBOutlet var table: UITableView!
    
    @IBOutlet var imgMenuIcone: UIImageView!
    @IBOutlet var imgSearch: UIImageView!
    
    @IBOutlet var txtProvider: UITextField!
    @IBOutlet var txtResponsible: UITextField!
    @IBOutlet var txtSearch: UITextField!
    
    @IBOutlet var viewAdvanceSearch: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewResponsibleName: UIView!
    @IBOutlet var viewAdvancAll: UIView!
    
    // MARK: - Local Declaration
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
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
    var Load = NSString()
    var PARAMETER = NSString()
    var pageNumber = Int()
    
    var NoData = NSString()
    var messageFrame = UIView()
    var COUNT = 0
    var idList : NSMutableArray = []
    
    // MARK: - METHODS
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        NoData = ""
        
        self.navigationController?.isNavigationBarHidden = false
        self.table.delegate = self
        self.table.dataSource = self
        imgMenuIcone.image = imgMenuIcone.image!.withRenderingMode(.alwaysTemplate)
        imgMenuIcone.tintColor = UIColor.white
        
        imgSearch.image = imgSearch.image!.withRenderingMode(.alwaysTemplate)
        imgSearch.tintColor = UIColor.white
        Load = "YES"

        //imgAddCall.layer.cornerRadius = imgAddCall.frame.size.height/2
        
        self.table.addSubview(self.refreshControl)
//        self.table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //var messageFrame = UIView()
        NoData = ""
        messageFrame = GlobalMethods().progressBarDisplayer(msg: "Loading...", true,sizeView: self.view)
        view.addSubview(messageFrame)
        self.navigationController?.isNavigationBarHidden = false
        self.Reset(animated)
        ProviderId = ""
        viewAdvanceSearch.isHidden = true
        self.DashboardData = [CallDetailData]()
        DashboardData = [CallDetailData]()
        print("View will")
//        self.table.reloadData()
        
        DispatchQueue.main.async {
            self.GetProviderList()
        }
        
        DispatchQueue.main.async {
            self.GetUserList()
        }
        
        DispatchQueue.main.async {
            var parameter = NSString()
            self.DashboardData = [CallDetailData]()
            self.pageNumber = 0 ;
            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            parameter = parameter.appending("&archive=" as String) as NSString
            parameter = parameter.appending("true" as String) as NSString
            
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            //self.DashboardData = dashboardData
            self.GetCallDetail(parameter: parameter)
        }
        
//        DispatchQueue.main.async {
//            var parameter = NSString()
//            parameter = "token="
//            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
//            parameter = parameter.appending("&archive=" as String) as NSString
//            parameter = parameter.appending("true" as String) as NSString
//            
//            
//            self.GetCallDetail(parameter: parameter)
//        }
        
        //        AllMethods().callDetail(with: "Demo", completion: { (dashboardData) in
        //            print("Testing Demo:==== \(dashboardData[0].CD_From as String) and Token:== \(dashboardData[0].CD_KPI as String)")
        //            self.DashboardData = [CallDetailData]()
        //
        //            self.DashboardData = dashboardData
        //            self.table.reloadData()
        //        })
       
        
    }
    func spiner(){
        messageFrame.removeFromSuperview()
    }
    // MARK: - Button Events
//    @IBAction func Back(_ sender: Any) {
//          self.navigationController?.popViewController(animated: true)
//        
//    }
    
    @IBAction func AdvanceSearch(_ sender: Any) {
         print("Advance Search")
        viewAdvanceSearch.isHidden = false
    }
    
    @IBAction func ViewNotes(_ sender: Any) {
        let btn = sender
        
        var PassData = [CallDetailData]()
        var cmd = CallDetailData()
        cmd = DashboardData[(btn as AnyObject).tag]
        PassData.append(cmd)
        //print(PassData[0].CD_Created_Date)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewNotes") as! ViewNotes
        secondViewController.Status = "Archived"
        secondViewController.DashboardData = PassData
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    // MARK: - Advance Search click
    @IBAction func Cancel(_ sender: Any) {
            self.view.endEditing(true)
        viewAdvanceSearch.isHidden = true
        //        ProviderId = ""
        //        txtSearch.text = ""
        //        txtStatus.text = "Select Status"
        //        txtProvider.text = "Select Provider"
        //        txtResponsible.text = "Select Responsible"
        
    }
    
    @IBAction func Reset(_ sender: Any) {
            self.view.endEditing(true)
        ProviderId = ""
        txtSearch.text = ""
        txtProvider.text = "Select Customer"
        txtResponsible.text = "Select Responsible"
        
        DispatchQueue.main.async {
            var parameter = NSString()
            self.pageNumber = 0 ;
            self.DashboardData = [CallDetailData]()

            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            parameter = parameter.appending("&archive=" as String) as NSString
            parameter = parameter.appending("true" as String) as NSString
            
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            //self.DashboardData = dashboardData
            self.GetCallDetail(parameter: parameter)
        }
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
        var parameter = NSString()
        self.pageNumber = 0 ;
        self.DashboardData = [CallDetailData]()

        Load = "YES"
        let Page = self.pageNumber as NSNumber
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        parameter = parameter.appending("&archive=" as String) as NSString
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
       
        self.PARAMETER = parameter
        parameter = parameter.appending("&page_no=" as String) as NSString
        parameter = parameter.appending(Page.stringValue as String) as NSString
        
        print("Parameter \(parameter)")
        self.GetCallDetail(parameter: parameter)
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
    }
    
    // MARK: - UDF methods
    func GetCallDetail(parameter :NSString){
        AllMethods().callDetailArchive(with: parameter as String,Page: self.pageNumber, completion: { (dashboardData) in
            //    print("Testing Demo:==== \(dashboardData[0].CD_From as String) and Token:== \(dashboardData[0].CD_KPI as String)")
            if self.DashboardData.count == dashboardData.count && dashboardData.count != 15 {
                print("No Load \(dashboardData.count)")
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
    
    
    func GetUserList()  {
        var parameter = NSString()
        parameter = ""
        self.DropDownUserList = [DropDownListData]()
        if ProviderId != "" && ProviderId != "00"{
            parameter = parameter.appending("&provider_id=") as NSString
            parameter = parameter.appending(ProviderId as String) as NSString
        }
        AllMethods().responsiblePersonList(with: parameter as String, completion: { (ResponsiblePerson) in
            self.UserList = [ResponsiblePersonListData]()
            self.UserList = ResponsiblePerson
            NSLog("Count := %d", ResponsiblePerson.count)
            DispatchQueue.main.async {
                self.DropDownUserList = [DropDownListData]()
                for  i in 0..<self.UserList.count{
                    //print("demo \(self.UserList[i].RP_Name as String)")
                    var cmd = DropDownListData()
                    cmd.Drp_Id = self.UserList[i].RP_Id as String
                    cmd.Drp_Name = self.UserList[i].RP_Name as String
                    self.DropDownUserList.append(cmd)
                }
            }
            self.timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.spiner), userInfo: nil, repeats: false)
            
        })
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
    
//    func hexStringToUIColor (hex:String) -> UIColor {
//        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//        
//        if ((cString.characters.count) != 6) {
//            return UIColor.gray
//        }
//        
//        var rgbValue:UInt32 = 0
//        Scanner(string: cString).scanHexInt32(&rgbValue)
//        
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//        )
//    }
    func loadData()  {
        print("Lord more")
        DispatchQueue.main.async {
            
            self.pageNumber = self.pageNumber+1
            let Page = self.pageNumber as NSNumber
            
            var parameter = self.PARAMETER
            // parameter = "token="
            // parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            //   parameter = self.PARAMETER
            //            parameter = parameter.appending("&archive=" as String) as NSString
            //            parameter = parameter.appending("true" as String) as NSString
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.GetCallDetail(parameter: parameter)
        }
    }
    func loadMore(){
        print("Lord more")
        DispatchQueue.main.async {
            
            self.pageNumber = self.pageNumber+1
            let Page = self.pageNumber as NSNumber
            
            var parameter = self.PARAMETER
            // parameter = "token="
            // parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            //   parameter = self.PARAMETER
//            parameter = parameter.appending("&archive=" as String) as NSString
//            parameter = parameter.appending("true" as String) as NSString
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.GetCallDetail(parameter: parameter)
        }
        
    }
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func GoNotStarted(){
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=1")
        //   LoginApi.Web_CallStatus
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&cd_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
        print(parameter)
        //
        //        var URL = String()
        //        URL = ""
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_CallStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                self.DashboardData = [CallDetailData]()
                self.pageNumber = 0 ;
                self.Load = "YES"
                parameter = "token="
                let Page = self.pageNumber as NSNumber
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                parameter = parameter.appending("&archive=" as String) as NSString
                parameter = parameter.appending("true" as String) as NSString
                
                self.PARAMETER = parameter
                parameter = parameter.appending("&page_no=" as String) as NSString
                parameter = parameter.appending(Page.stringValue as String) as NSString
                self.DashboardData = [CallDetailData]()
                //self.DashboardData = dashboardData
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
        print(parameter)
        
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_CallStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                self.DashboardData = [CallDetailData]()
                self.pageNumber = 0 ;
                self.Load = "YES"
                parameter = "token="
                let Page = self.pageNumber as NSNumber
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                parameter = parameter.appending("&archive=" as String) as NSString
                parameter = parameter.appending("true" as String) as NSString
                
                self.PARAMETER = parameter
                parameter = parameter.appending("&page_no=" as String) as NSString
                parameter = parameter.appending(Page.stringValue as String) as NSString
                self.DashboardData = [CallDetailData]()
                //self.DashboardData = dashboardData
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
                print(DashboardData[i].CD_Id)
                self.idList.add(DashboardData[i].CD_Id)
            }
        }
        
        if COUNT == 0{
            self.initialNavigationbar()
        }else{// if COUNT == 1{
            let count = "\(COUNT)"
            self.title = ""
            navigationController?.navigationBar.barTintColor = UIColor().selectTintColor()
            let button1 = UIBarButtonItem(title: "Not Started", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.GoNotStarted))
            
            let button2 = UIBarButtonItem(title: "In Progress", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoInProgress))
            
            let button3 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(DashBoard.GoInProgress))
            
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Logout"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.nullAll))
            
           // self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
            
            self.navigationItem.setRightBarButtonItems([button1,button2, button3,button5,button4], animated: true)
            
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        }
//        else{
//            let count = "\(COUNT)"
//            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Logout"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.deSelectAllCall))
            
//            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.nullAll))
            
            //self.navigoationItem.setLeftBarButtonItems([button4,button5], animated: true)
//        }
  
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
        self.title = "Archived"
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardFilterSet"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.AdvanceSearch(_:)))
        
        let button2 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.nullAll))
        
        let button3 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action:  #selector(Archived.nullAll))
        
        let button4 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.nullAll))
        
        let button5 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Archived.nullAll))
        
        self.navigationItem.setRightBarButtonItems([button1,button2, button3,button4, button5], animated: true)
        //self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
    }
    
    func nullAll()  {
        
    }
    
}

// MARK: - UITableview Delegate and DataSourse
extension Archived : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  print("Inside")
        if self.DashboardData.count > 0 {
            TableViewHelper.EmptyMessage(message: "", viewController: self.table)
            return self.DashboardData.count
        } else {
            TableViewHelper.EmptyMessage(message: self.NoData as String, viewController: self.table)
            return 0
        }
        //   return self.DashboardData.count
    }
    
    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("Inside")
        // create a new cell if needed or reuse an old one
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        let printData = self.DashboardData[indexPath.row]
        cell.btnNotes.tag = indexPath.row

        cell.backgroundColor = UIColor.white
        cell.btnSelect.tag = indexPath.row
        cell.lblAbbrivation.layer.masksToBounds = true
        cell.lblAbbrivation.backgroundColor = UIColor().hexStringToUIColor(hex: printData.PRV_Abbr_Color)
        cell.lblAbbrivation.layer.cornerRadius = cell.lblAbbrivation.frame.size.height/2
        
        cell.imgCall.image = cell.imgCall.image!.withRenderingMode(.alwaysTemplate)
        cell.imgCall.tintColor = UIColor().hexStringToUIColor(hex: "388E3C")
        cell.lblNoteCount.layer.masksToBounds = true
        cell.lblNoteCount.layer.cornerRadius = cell.lblNoteCount.frame.size.height/2
        cell.imgClock.image = cell.imgClock.image!.withRenderingMode(.alwaysTemplate)
        cell.imgClock.tintColor = UIColor().hexStringToUIColor(hex: "388E3C")
        
        cell.lblAbbrivationName.text = printData.CD_From as String
        cell.lblAbbrivation.text = printData.PRV_Abbr as String
        cell.lblDate.text = printData.CD_Created_Date as String
//        cell.lblResponcible.text = DashboardData[indexPath.row].Responsible_Person as String
        cell.lblStatus.text = printData.CD_Status as String
        cell.lblNumber.text = printData.CD_Phone_number as String
        cell.lblKPITime.text = printData.CD_KPI as String
        cell.lblNoteCount.text = printData.Cd_Notes_Count as String //as NSInteger).stringValue
        cell.imgRound.image = UIImage (named: "")
        
        if printData.CD_Is_Overdue == true{
            cell.imgClock.tintColor = UIColor().orangColor()
            cell.lblKPITime.textColor = UIColor().orangColor()
        }else{
            cell.imgClock.tintColor = UIColor().greenColor()
            cell.lblKPITime.textColor = UIColor().greenColor()
        }
        
        if  printData.Cd_Notes_Count == "0"{
            cell.lblNoteCount.backgroundColor = UIColor().greenColor()
        }else{
            cell.lblNoteCount.backgroundColor = UIColor().orangColor()
        }
        
        if printData.SELECTED == 1{
            cell.backgroundColor = UIColor().hexStringToUIColor(hex:"E0E0E0")
            cell.lblAbbrivation.text = ""
            cell.lblAbbrivation.backgroundColor = UIColor().selectTintColor()
            cell.imgRound.image = #imageLiteral(resourceName: "Save(Done)")
        }
        
        if self.Load == "YES"{
            if indexPath.row == self.DashboardData.count - 1 {
                self.loadData()
            }
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        
        if COUNT > 0{
            self.rowSelection(row: indexPath.row)
        }
        return indexPath
    }

}

extension Archived : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        DispatchQueue.main.async {
        //            //lblLineFrom.backgroundColor =
        //            self.lblLineFrom.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
        //            self.lblLinePhoneNumber.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
        //            self.lblLineEmail.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
        //            self.lblLineProvider.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
        //            self.lblLineUserName.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
        //            self.lblLineResonForCall.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
        //        }
        self.view.endEditing(true)
        return false
    }
}


