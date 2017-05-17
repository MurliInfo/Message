//
//  Search.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/22/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class Search: UIViewController,CloseDropDownDelegate {
    @IBOutlet var table: UITableView!
    
    @IBOutlet var imgMenuIcone: UIImageView!
    @IBOutlet var imgSearch: UIImageView!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    
    
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
    
    var NoData = NSString()
    var messageFrame = UIView()
    // MARK: - METHODS
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        NoData = ""
        navigationController?.navigationBar.barTintColor = UIColor().hexStringToUIColor(hex: "3F51B5")
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        self.navigationController?.navigationBar.tintColor = UIColor.white;
  
        self.table.delegate = self
        self.table.dataSource = self
        
        Load = "YES"
        
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.table.addSubview(self.refreshControl)
        self.table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageFrame = GlobalMethods().progressBarDisplayer(msg: "Loading...", true,sizeView: self.view)
        view.addSubview(messageFrame)
        
        NoData = ""
        self.Reset(animated)
        ProviderId = ""
        viewAdvanceSearch.isHidden = true
        self.DashboardData = [CallDetailData]()
        DashboardData = [CallDetailData]()
        self.table.reloadData()
        
        DispatchQueue.main.async {
            var parameter = NSString()
            self.DashboardData = [CallDetailData]()
            self.pageNumber = 0 ;
            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            self.GetCallDetail(parameter: parameter)
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
    
    @IBAction func AdvanceSearch(_ sender: Any) {
        viewAdvanceSearch.isHidden = false
    }
    
    @IBAction func ViewNotes(_ sender: Any) {
        let btn = sender
        var TAG = Int()
          TAG =  (btn as AnyObject).tag
        var PassData = [CallDetailData]()
        var cmd = CallDetailData()
        cmd = DashboardData[(btn as AnyObject).tag]
        PassData.append(cmd)
        print(DashboardData[TAG].CD_Status)
        var STATUS = String()
        if DashboardData[TAG].CD_Status == "Completed"{
            STATUS = "Archived"
        }else{
            STATUS = "Dashboard"
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewNotes") as! ViewNotes
        secondViewController.Status = STATUS//"Dashboard"
        secondViewController.DashboardData = PassData
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
        
        DispatchQueue.main.async {
            var parameter = NSString()
            self.pageNumber = 0 ;
            self.DashboardData = [CallDetailData]()
            
            self.Load = "YES"
            parameter = "token="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            
            self.PARAMETER = parameter
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.DashboardData = [CallDetailData]()
            //self.DashboardData = dashboardData
            self.GetCallDetail(parameter: parameter)
        }
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
        self.pageNumber = 0
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
    
    @IBAction func SelectStatus(_ sender: Any) {
        self.view.endEditing(true)
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
        if DropDownSelection == "SelecteResponsible"{
            txtResponsible.text = self.DropDownUserList[time].Drp_Name
            UserId = self.DropDownUserList[time].Drp_Id as NSString
            dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectProvider"{
            txtProvider.text = self.DropDownProviderList[time].Drp_Name
            ProviderId = self.DropDownProviderList[time].Drp_Id as NSString
            self.DropDownUserList = [DropDownListData]()
            txtResponsible.text = "Select Responsible"
            self.GetUserList()
            dropdown.removeFromSuperview()
        }
        else{
            txtStatus.text = self.DashboardStatusData[time].Drp_Name
            StatusId = self.DashboardStatusData[time].Drp_Id as! NSString
        }
    }
    
    // MARK: - UDF methods
    func GetCallDetail(parameter :NSString){
        print(self.pageNumber)
        
        AllMethods().callDetail(with: parameter as String,Page: self.pageNumber, completion: { (dashboardData) in
            //    print("Testing Demo:==== \(dashboardData[0].CD_From as String) and Token:== \(dashboardData[0].CD_KPI as String)")
            if self.DashboardData.count == dashboardData.count && dashboardData.count != 15 {
                self.Load = "NO"
            }
            self.DashboardData = dashboardData
            self.viewAdvanceSearch.isHidden = true
            self.NoData = "No Data Available"
            self.table.reloadData()
        })
    }
    func GetProviderList(){
        AllMethods().providerList(with: "", completion: { (ProviderList) in
            self.ProvideList = [ProviderListData]()
            self.ProvideList = ProviderList
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
            self.DashboardStatusData = dashboardData
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
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(stopReferesh), userInfo: nil, repeats: false)
    }
    
    func stopReferesh()  {
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func loadData()  {
        DispatchQueue.main.async {
            
            self.pageNumber = self.pageNumber+1
            let Page = self.pageNumber as NSNumber
            
            var parameter = self.PARAMETER
            parameter = parameter.appending("&page_no=" as String) as NSString
            parameter = parameter.appending(Page.stringValue as String) as NSString
            self.GetCallDetail(parameter: parameter)
        }
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

extension Search : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.DashboardData.count > 0 {
            return self.DashboardData.count
        } else {
            TableViewHelper.EmptyMessage(message: NoData as String, viewController: self.table)
            return 0
        }
    }

    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        let printData = DashboardData[indexPath.row]
        cell.btnNotes.tag = indexPath.row
        cell.lblAbbrivation.layer.masksToBounds = true
        cell.lblAbbrivation.backgroundColor = hexStringToUIColor(hex: printData.PRV_Abbr_Color)
        cell.lblAbbrivation.layer.cornerRadius = cell.lblAbbrivation.frame.size.height/2
        
        cell.imgCall.image = cell.imgCall.image!.withRenderingMode(.alwaysTemplate)
        cell.imgCall.tintColor = hexStringToUIColor(hex: "388E3C")
        cell.lblNoteCount.layer.masksToBounds = true
        cell.lblNoteCount.layer.cornerRadius = cell.lblNoteCount.frame.size.height/2
        cell.imgClock.image = cell.imgClock.image!.withRenderingMode(.alwaysTemplate)
        cell.imgClock.tintColor = hexStringToUIColor(hex: "388E3C")
        
        cell.lblAbbrivationName.text = printData.CD_From as String
        cell.lblAbbrivation.text = printData.PRV_Abbr as String
        cell.lblDate.text = printData.CD_Created_Date as String
//        cell.lblResponcible.text = printData.Responsible_Person as String
        cell.lblStatus.text = printData.CD_Status as String
        cell.lblNumber.text = printData.CD_Phone_number as String
        cell.lblKPITime.text = printData.CD_KPI as String
        cell.lblNoteCount.text = printData.Cd_Notes_Count as String //as NSInteger).stringValue
        
        if printData.CD_Is_Overdue == true{
            cell.imgClock.tintColor = UIColor().orangColor()
            cell.lblKPITime.textColor = UIColor().orangColor()
        }else{
            cell.imgClock.tintColor = UIColor().greenColor()
            cell.lblKPITime.textColor = UIColor().greenColor()
        }
        if printData.CD_Status == "Not Started"{
            cell.lblStatus.textColor = UIColor.red
        }else if printData.CD_Status == "Completed"{
            cell.lblStatus.textColor = UIColor().greenColor()
        }else{
            cell.lblStatus.textColor = UIColor().yelloColor()
        }
        
        if  printData.Cd_Notes_Count == "0"{
            cell.lblNoteCount.backgroundColor = UIColor().greenColor()
        }else{
            cell.lblNoteCount.backgroundColor = UIColor().orangColor()
        }
        
        if self.Load == "YES"{
            if indexPath.row == self.DashboardData.count - 1 {
                self.loadData()
            }
        }
        return cell
    }
}

extension Search : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
        return false
    }
}
