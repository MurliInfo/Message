//
//  ArchivedProvider.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/24/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class ArchivedProvider: UIViewController ,CloseDropDownDelegate{
    @IBOutlet var table: UITableView!
    
    
    @IBOutlet var imgMenuIcone: UIImageView!
    @IBOutlet var imgSearch: UIImageView!
    @IBOutlet var imgArchive: UIImageView!
    @IBOutlet var imgAddCall: UIImageView!
    
    @IBOutlet var txtProvider: UITextField!
    @IBOutlet var txtResponsible: UITextField!
    @IBOutlet var txtStatus: UITextField!
    @IBOutlet var txtSearch: UITextField!
    
    @IBOutlet var viewAdvanceSearch: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewResponsibleName: UIView!
    @IBOutlet var viewStatus: UIView!
    @IBOutlet var viewAdvancAll: UIView!
    

    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
    let refresh = UIRefreshControl()
    var timer: Timer!
    var ProviderListDetail = [ProviderDetailListData]()

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
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        NoData = ""//No Data Available
        navigationController?.navigationBar.barTintColor = UIColor().hexStringToUIColor(hex: "3F51B5")
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.table.delegate = self
        self.table.dataSource = self
        
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
        viewAdvanceSearch.isHidden = true
        self.ProviderListDetail = [ProviderDetailListData]()
        ProviderListDetail = [ProviderDetailListData]()
        print("View will")
        self.table.reloadData()
        
        DispatchQueue.main.async {
            var parameter = NSString()
            parameter = "token="
            parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=2") as NSString
            
            self.ProviderListDetail = [ProviderDetailListData]()
            //self.DashboardData = dashboardData
            self.GetProviderDetail(parameter: parameter)
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
    // MARK: - Advance Search click
    @IBAction func Cancel(_ sender: Any) {
        self.view.endEditing(true)
        viewAdvanceSearch.isHidden = true
    }
    
    @IBAction func Reset(_ sender: Any) {
        self.view.endEditing(true)
        
        txtSearch.text = ""
        DispatchQueue.main.async {
            var parameter = NSString()
            parameter = "token="
            parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=2") as NSString
            self.ProviderListDetail = [ProviderDetailListData]()
            //self.DashboardData = dashboardData
            self.GetProviderDetail(parameter: parameter)
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
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String).appending("&status=2") as NSString
        if txtSearch.text != ""{
            parameter = parameter.appending("&search=") as NSString
            parameter = parameter.appending(txtSearch.text!) as NSString
        }
        self.ProviderListDetail = [ProviderDetailListData]()
        print("Parameter \(parameter)")
        self.GetProviderDetail(parameter: parameter)
    }
    
    
    // MARK: - UDF methods
    func GetProviderDetail(parameter :NSString){
        print("Paramete \(parameter)")
        
        AllMethods().ProviderListDetail(with: parameter as String, completion: { (dashboardData) in
            self.ProviderListDetail = dashboardData
            self.viewAdvanceSearch.isHidden = true
            self.NoData = "No Data Available"
            self.table.reloadData()
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
        }else {//if COUNT == 1{
            let count = "\(COUNT)"
            self.title = ""
            navigationController?.navigationBar.barTintColor = UIColor().selectTintColor()
            let button1 = UIBarButtonItem(title: "Active", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.GoActive))
            
            let button2 = UIBarButtonItem(title: "Inactive", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.GoInactive))
          
            let button4 = UIBarButtonItem(image: #imageLiteral(resourceName: "Logout"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.deSelectAllCall))
            
            let button5 = UIBarButtonItem(title: count, style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProviderDashboard.nullAll))
            
            self.navigationItem.setRightBarButtonItems([button2,button1,button5,button4], animated: true)

            self.navigationController?.navigationBar.tintColor = UIColor.white;
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        }

        let indexPath = NSIndexPath(row: Index, section: 0)
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
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
        self.title = "Archived"
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "DashboardFilterSet"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedProvider.AdvanceSearch(_:)))
        
        let button2 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedProvider.nullAll))
        
        let button4 = UIBarButtonItem(title : "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedProvider.nullAll))
        
        let button5 = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArchivedProvider.nullAll))
        
          self.navigationItem.setRightBarButtonItems([button1,button2, button5, button4], animated: true)
        
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
}


// MARK: - UITableview Delegate and DataSourse
extension ArchivedProvider : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  print("Inside")
        if self.ProviderListDetail.count > 0 {
            return self.ProviderListDetail.count
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
        let printData = self.ProviderListDetail[indexPath.row]
        cell.btnSelect.tag = indexPath.row
        cell.backgroundColor = UIColor.white
        
        cell.lblAbbrivation.layer.masksToBounds = true
        cell.lblAbbrivation.backgroundColor = UIColor().hexStringToUIColor(hex: ProviderListDetail[indexPath.row].PRV_Abbr_Color)
        cell.lblAbbrivation.layer.cornerRadius = cell.lblAbbrivation.frame.size.height/2
        cell.lblAbbrivation.text = ProviderListDetail[indexPath.row].PRV_Abbr as String
        cell.lblUserName.text = ProviderListDetail[indexPath.row].PRV_Name as String
        //cell.lblUserType.text = ProviderListDetail[indexPath.row].Modify_By as String
        // cell.lblModifyBy.text = ProviderListDetail[indexPath.row].Modify_By as String
        // cell.lblUserModifidDate.text = ProviderListDetail[indexPath.row].PRV_Modified_Date as String
        cell.lblUserEmail.text = ProviderListDetail[indexPath.row].PRV_Type as String
        if ProviderListDetail[indexPath.row].PRV_Status as String == "Active"{
            cell.lblStatus.textColor =  UIColor().hexStringToUIColor(hex: "388E3C")
        }else{
            cell.lblStatus.textColor =  UIColor().hexStringToUIColor(hex: "FE6902")
        }
         cell.imgRound.image = UIImage(named: "")
        if printData.SELECTED == 1{
            cell.backgroundColor = UIColor().selectCellColor()
            cell.lblAbbrivation.text = ""
            cell.lblAbbrivation.backgroundColor = UIColor().selectTintColor()
            cell.imgRound.image = #imageLiteral(resourceName: "Save(Done)")
        }
        
        cell.lblStatus.text = ProviderListDetail[indexPath.row].PRV_Status as String
        return cell
    }
    
       public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if COUNT != 0{
            self.rowSelection(row: indexPath.row)
        }
        
        //        var PassData = [CallDetailData]()
    //        var cmd = CallDetailData()
    //        cmd = DashboardData[indexPath.row]
    //        PassData.append(cmd)
    //        print(PassData[0].CD_Created_Date)
    //        //"View Call"
    //        let second = self.storyboard?.instantiateViewController(withIdentifier: "addcall") as! AddCall
    //        second.stringStatus = "View Call"
    //        second.GetData = PassData
    //        self.navigationController?.pushViewController(second, animated: true)
           return indexPath
        }
}

// MARK: - TextField Delegate
extension ArchivedProvider : UITextFieldDelegate{
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
    
    //    func textFieldDidBeginEditing(_ textField: UITextField) {
    //
    //        DispatchQueue.main.async {
    //            //lblLineFrom.backgroundColor =
    //            self.lblLineFrom.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //            self.lblLinePhoneNumber.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //            self.lblLineEmail.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //            self.lblLineProvider.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //            self.lblLineUserName.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //            self.lblLineResonForCall.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //        }
    //        if textField.tag == 1{
    //            DispatchQueue.main.async {
    //                self.lblLineFrom.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
    //            }
    //        }else  if textField.tag == 2{
    //            DispatchQueue.main.async {
    //                self.lblLinePhoneNumber.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
    //            }
    //        }else if textField.tag == 3{
    //            DispatchQueue.main.async {
    //                self.lblLineEmail.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
    //            }
    //        }else if textField.tag == 4{
    //            DispatchQueue.main.async {
    //                self.lblLineProvider.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
    //            }
    //        }else if textField.tag == 5{
    //            DispatchQueue.main.async {
    //                self.lblLineUserName.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
    //            }
    //        }else if textField.tag == 6{
    //            DispatchQueue.main.async {
    //                self.lblLineResonForCall.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
    //            }
    //        }else{
    //            DispatchQueue.main.async {
    //                //lblLineFrom.backgroundColor =
    //                self.lblLineFrom.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //                self.lblLinePhoneNumber.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //                self.lblLineEmail.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //                self.lblLineProvider.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //                self.lblLineUserName.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //                self.lblLineResonForCall.backgroundColor = AllMethods().hexStringToUIColor(hex: "EFEFEF" )
    //            }
    //
    //        }
    //        print(textField.tag)
    //    }
}
