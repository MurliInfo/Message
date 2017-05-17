//
//  ProviderDashboard.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/24/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class ProviderDashboard: UIViewController ,CloseDropDownDelegate {
    // MARK: - Storyboard Declaration
    @IBOutlet var table: UITableView!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    
    @IBOutlet var imgMenuIcone: UIImageView!
    @IBOutlet var imgSearch: UIImageView!
    @IBOutlet var imgArchive: UIImageView!
    @IBOutlet var imgAddCall: UIImageView!
    
    @IBOutlet var txtProvider: UITextField!
     @IBOutlet var txtSearch: UITextField!
    
    @IBOutlet var viewAdvanceSearch: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewAdvancAll: UIView!
    
    // MARK: - Local Declaration
    
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
    let refresh = UIRefreshControl()
    var timer: Timer!
    var ProviderListDetail = [ProviderDetailListData]()
    var ProvideList = [ProviderListData]()
    var DropDownProviderList = [DropDownListData]()
    var ProvideType = [DropDownListData]()
    var ProviderId = NSString()
    var DropDownSelection = NSString()
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
        self.title = "Customers"
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        NoData = ""//No Data Available
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.table.delegate = self
        self.table.dataSource = self
        
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.table.addSubview(self.refreshControl)
        self.table.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()

        messageFrame = GlobalMethods().progressBarDisplayer(msg: "Loading...", true,sizeView: self.view)
        view.addSubview(messageFrame)
        NoData = ""
        self.Reset(animated)
        ProviderId = ""
        viewAdvanceSearch.isHidden = true
        self.ProviderListDetail = [ProviderDetailListData]()
        ProviderListDetail = [ProviderDetailListData]()
        self.table.reloadData()
        
        DispatchQueue.main.async {
            var parameter = NSString()
            parameter = "token="
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            self.ProviderListDetail = [ProviderDetailListData]()
            self.GetProviderDetail(parameter: parameter)
        }
        DispatchQueue.main.async {
            self.GetProviderList()
        }
        DispatchQueue.main.async {
            self.GetProviderType()
        }
    }

    func spiner(){
        messageFrame.removeFromSuperview()
    }
    
    // MARK: - Button Events
    
    @IBAction func AdvanceSearch(_ sender: Any) {
//        print("Advance Search")
        viewAdvanceSearch.isHidden = false
    }
    
    @IBAction func Archived(_ sender: Any) {
//        print("Archived")
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ArchivedProvider") as! ArchivedProvider
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    // MARK: - Add Provider
    
    @IBAction func AddUser(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddProvider") as! AddProvider
        secondViewController.stringStatus = "Add Provider"
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
        txtProvider.text = "Select Customer Type"
        DispatchQueue.main.async {
            var parameter = NSString()
            parameter = "token="
            parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
            self.ProviderListDetail = [ProviderDetailListData]()
            self.GetProviderDetail(parameter: parameter)
        }
    }
    
    
    @IBAction func Search(_ sender: Any) {
        self.view.endEditing(true)
        var parameter = NSString()
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
        
        if ProviderId != "" && ProviderId != "00"{
            parameter = parameter.appending("&prv_type=") as NSString
            parameter = parameter.appending(ProviderId as String) as NSString
        }
        
        if txtSearch.text != ""{
            parameter = parameter.appending("&search=") as NSString
            parameter = parameter.appending(txtSearch.text!) as NSString
        }
        self.ProviderListDetail = [ProviderDetailListData]()
        self.GetProviderDetail(parameter: parameter)
    }
    
    @IBAction func SelectProvider(_ sender: Any) {
        self.view.endEditing(true)
        if self.DropDownProviderList.count > 0 {
            
            DropDownSelection = "SelectProvider"
            let frame = CGRect(x: txtProvider.frame.origin.x+10, y: viewAdvancAll.frame.origin.y+viewProviderName.frame.origin.y+txtProvider.frame.origin.y+txtProvider.frame.height, width: txtProvider.frame.width, height: 400)
            dropdown.delegate = self
            dropdown.removeFromSuperview()
            DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.ProvideType)
            self.viewAdvanceSearch.addSubview(DropDownView)
            dropdown.delegate = self
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
    
    
    
    // MARK: - Dropdown Delagete
    
    func SelectedValue(time:NSInteger){
       if DropDownSelection == "SelectProvider"{
            txtProvider.text = self.ProvideType[time].Drp_Name
            ProviderId = self.ProvideType[time].Drp_Id as NSString
        if time == 0{
            ProviderId = ""
        }
            dropdown.removeFromSuperview()
        }
    }
    
    // MARK: - UDF methods
    func GetProviderDetail(parameter :NSString){
//        print("Paramete \(parameter)")
        
        AllMethods().ProviderListDetail(with: parameter as String, completion: { (dashboardData) in
            self.ProviderListDetail = dashboardData
            self.viewAdvanceSearch.isHidden = true
            self.NoData = "No Data Available"
            self.table.reloadData()
            self.timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(self.spiner), userInfo: nil, repeats: false)
        })
    }
    
    func GetProviderList(){
        AllMethods().providerList(with: "", completion: { (ProviderList) in
//            print("providerList call")
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
    func GetProviderType() {
        //        var parameter : NSString
        //        parameter = "&display_abbr=true"
        
        AllMethods().ProviderType(with: "", completion: { (ProviderList) in
            print("providerList call")
            self.ProvideType = [DropDownListData]()
            let cmd = DropDownListData(Drp_Id:"0000",
                                       Drp_StateId: "000",
                                       Drp_Name: "Select Customer Type"
            )
            self.ProvideType.append(cmd)
            self.ProvideType.append(contentsOf:ProviderList)
            //self.ProvideList = ProviderList
            
//            DispatchQueue.main.async {
//                if self.stringStatus == "View Provider"{
//                    for  i in 0..<ProviderList.count{
//                        //print("demo \(self.ProvideList[i].PRV_Name as String)")
//                        //                    var cmd = DropDownListData()
//                        //                    cmd.Drp_Id = ProviderList[i].Drp_Id as String
//                        //                    cmd.Drp_Name = ProviderList[i].Drp_Name as String
//                        //                    cmd.Drp_StateId = "Testing"
//                        //                    self.ProvideList.append(cmd)
//                        if self.GetData[0].PRV_Type as String == ProviderList[i].Drp_Name{
//                            self.txtProviderType.text = self.GetData[0].PRV_Type
//                            self.ProviderTypeId =  ProviderList[i].Drp_Id as String
//                            self.txtProviderType.text = ProviderList[i].Drp_Name as String
//                        }
//                    }
//                }
//            }
        })
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControlEvents.valueChanged)
        return refreshControl
    }()
    
    func handleRefresh(refreshControl: UIRefreshControl) {
//        print("Refresh ")
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(stopReferesh), userInfo: nil, repeats: false)
    }
    
    func stopReferesh()  {
//        print("Stop Refresh")
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func GoActive(){
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=1")
        //   LoginApi.Web_CallStatus
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&prv_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
            
        }
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_ProviderStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                parameter = "token="
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                self.ProviderListDetail = [ProviderDetailListData]()
                self.GetProviderDetail(parameter: parameter)
            }
        })
    }
    
    func GoInactive()  {
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=0")
        
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&prv_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
        //print(parameter)
        
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_ProviderStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                parameter = "token="
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                self.ProviderListDetail = [ProviderDetailListData]()
                self.GetProviderDetail(parameter: parameter)
            }
        })
    }
    func GoArchivew()  {
        var parameter = String()
        parameter = "token=".appending(appDelegate.TOKEN as String).appending("&status=2")
        
        for i in 0..<self.idList.count{
            parameter  = parameter.appending("&prv_id[").appending("\(i)".appending("]=").appending(self.idList[i] as! String))
        }
        //print(parameter)
        
        AllMethods().changeStatus(with: parameter , API: LoginApi.Web_ProviderStatus as String, completion: {(Response) in
            self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
            self.deSelectAllCall()
            DispatchQueue.main.async {
                var parameter = NSString()
                parameter = "token="
                parameter = parameter.appending(appDelegate.TOKEN as String) as NSString
                self.ProviderListDetail = [ProviderDetailListData]()
                self.GetProviderDetail(parameter: parameter)
            }
        })
    }
    
    
    func rowSelection(row : Int) {
        var Index = Int()
        Index = row
        if ProviderListDetail[Index].Is_Checked{
        if ProviderListDetail[Index].SELECTED == 0{
            ProviderListDetail[Index].SELECTED = 1
        }else{
            ProviderListDetail[Index].SELECTED = 0
        }
        COUNT = 0
        self.idList = []
        for i in 0..<self.ProviderListDetail.count{
            COUNT = COUNT+ProviderListDetail[i].SELECTED
            if ProviderListDetail[i].SELECTED == 1{
                self.idList.add(ProviderListDetail[i].PRV_Id)
            }
        }
        
        if COUNT == 0{
            self.initialNavigationbar()
        }else if COUNT == 1{
            let count = "\(COUNT)"
            self.title = ""
            navigationController?.navigationBar.barTintColor = UIColor().selectTintColor()
            let button1 = UIBarButtonItem(title: "Active", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.GoActive))
            
            let button2 = UIBarButtonItem(title: "Inactive", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.GoInactive))
            
            let button3 = UIBarButtonItem(title: "Archive", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.GoArchivew))
            
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.nullAll))
            
            self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
            
            self.navigationItem.setRightBarButtonItems([button3,button2, button1], animated: true)
            
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
            self.navigationItem.leftBarButtonItem!.tintColor = UIColor.white
        }else{
            let count = "\(COUNT)"
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.nullAll))
            
            self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
        }
        let indexPath = NSIndexPath(row: Index, section: 0)
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }else{
            self.ShowAlertMessage(title: "", message: "You can not Select Active Customer", buttonText: "OK");
        }
    }
    
    func deSelectAllCall()  {
        COUNT = 0
        idList =  NSMutableArray()
        for i in 0..<self.ProviderListDetail.count{
            ProviderListDetail[i].SELECTED = 0
        }
        self.initialNavigationbar()
        table.reloadData()
    }
    
    func initialNavigationbar()  {
        self.title = "Customers"
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardFilterSet"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.AdvanceSearch(_:)))
        
        let button2 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardArchive"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.Archived(_:)))
        
        let button3 = UIBarButtonItem(image:#imageLiteral(resourceName: "AddCall"), style: UIBarButtonItemStyle.plain, target: self, action:  #selector(ProviderDashboard.AddUser(_:)))
        
        self.navigationItem.setRightBarButtonItems([button1,button2, button3], animated: true)
        
        let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "SideBarMenu"), style: UIBarButtonItemStyle.plain, target: revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        
        let button5 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.nullAll))
        
        self.navigationItem.setLeftBarButtonItems([button4,button5], animated: true)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem!.tintColor = UIColor.white
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
    
}

// MARK: - UITableview Delegate and DataSourse

extension ProviderDashboard : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.ProviderListDetail.count > 0 {
            return self.ProviderListDetail.count
        } else {
            TableViewHelper.EmptyMessage(message: self.NoData as String, viewController: self.table)
            return 0
        }
    }
    
    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! CustomCell
        let printData = ProviderListDetail[indexPath.row]
        cell.btnSelect.tag = indexPath.row
        
        cell.backgroundColor = UIColor.white
        cell.lblAbbrivation.layer.masksToBounds = true
        cell.lblAbbrivation.backgroundColor = hexStringToUIColor(hex: printData.PRV_Abbr_Color)
        cell.lblAbbrivation.layer.cornerRadius = cell.lblAbbrivation.frame.size.height/2
        cell.lblAbbrivation.text = printData.PRV_Abbr as String
        cell.lblUserName.text = printData.PRV_Name as String
        cell.lblUserEmail.text = printData.PRV_Type as String
        if printData.PRV_Status as String == "Active"{
            cell.lblStatus.textColor = UIColor().greenColor()
        }else{
            cell.lblStatus.textColor = UIColor().orangColor()
        }
        cell.lblStatus.text = printData.PRV_Status as String
        cell.imgRound.image = UIImage (named: "")
        if printData.SELECTED == 1{
            cell.backgroundColor = UIColor().selectCellColor()
            cell.lblAbbrivation.text = ""
            cell.lblAbbrivation.backgroundColor = UIColor().selectTintColor()
            cell.imgRound.image = #imageLiteral(resourceName: "Save(Done)")
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
         if COUNT == 0{
            var PassData = [ProviderDetailListData]()
            let cmd =  ProviderListDetail[indexPath.row]//ProviderDetailListData()
            PassData.append(cmd)
            let second = self.storyboard?.instantiateViewController(withIdentifier: "AddProvider") as! AddProvider
            second.stringStatus = "View Provider"
            second.GetData = PassData
            self.navigationController?.pushViewController(second, animated: true)
        }else{
            self.rowSelection(row: indexPath.row)
        }
        return indexPath
    }
}

// MARK: - TextField Delegate

extension ProviderDashboard : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
