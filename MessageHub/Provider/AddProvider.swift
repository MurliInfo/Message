//
//  AddProvider.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/24/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class AddProvider: UIViewController,UIScrollViewDelegate,CloseDropDownDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var viewAll: UIView!
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var viewCompanyProfil: UIView!
    @IBOutlet var viewProviderInformation: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewProviderAbbreviation: UIView!
    @IBOutlet var viewProviderType: UIView!
    @IBOutlet var viewKPITime: UIView!
    @IBOutlet var viewProviderTimezone: UIView!
    @IBOutlet var viewStreetNo: UIView!
    @IBOutlet var viewStreeName: UIView!
    @IBOutlet var viewStreetRoad: UIView!
    @IBOutlet var viewState: UIView!
    @IBOutlet var viewCity: UIView!
    @IBOutlet var viewZipCode: UIView!
    @IBOutlet var viewOfficeEmail: UIView!
    @IBOutlet var viewWebsite: UIView!
//    Admin Login Information
    @IBOutlet var viewAdminLoginInformation: UIView!
    @IBOutlet var viewProviderFirstName: UIView!
    @IBOutlet var viewProviderLastName: UIView!
    @IBOutlet var viewLoginEmail: UIView!
    @IBOutlet var viewLoginPassword: UIView!
    @IBOutlet var viewLoginConfirmPassword: UIView!

    @IBOutlet var txtCompanyProfil: UITextField!
    @IBOutlet var txtProviderName: UITextField!
    @IBOutlet var txtProviderAbbreviation: UITextField!
    @IBOutlet var txtProviderType: UITextField!
    @IBOutlet var txtKPITime: UITextField!
    @IBOutlet var txtProviderTimezone: UITextField!
    @IBOutlet var txtStreetNo: UITextField!
    @IBOutlet var txtStreeName: UITextField!
    @IBOutlet var txtStreetRoad: UITextField!
    @IBOutlet var txtState: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtZipCode: UITextField!
    @IBOutlet var txtOfficeEmail: UITextField!
    @IBOutlet var txtWebsite: UITextField!
//    Admin Login Information
    @IBOutlet var txtProviderFirstName: UITextField!
    @IBOutlet var txtProviderLastName: UITextField!
    @IBOutlet var txtLoginEmail: UITextField!
    @IBOutlet var txtLoginPassword: UITextField!
    @IBOutlet var txtLoginConfirmPassword: UITextField!
    
    @IBOutlet var imgCompanyProfil : UIImageView!
    @IBOutlet var imgProviderName : UIImageView!
    @IBOutlet var imgProviderAbbreviation : UIImageView!
    @IBOutlet var imgProviderType : UIImageView!
    @IBOutlet var imgKPITime : UIImageView!
    @IBOutlet var imgProviderTimezone : UIImageView!
    @IBOutlet var imgStreetNo : UIImageView!
    @IBOutlet var imgStreeName : UIImageView!
    @IBOutlet var imgStreetRoad : UIImageView!
    @IBOutlet var imgState : UIImageView!
    @IBOutlet var imgCity : UIImageView!
    @IBOutlet var imgZipCode : UIImageView!
    @IBOutlet var imgOfficeEmail : UIImageView!
    @IBOutlet var imgWebsite : UIImageView!
    
    @IBOutlet var btnCity: UIButton!
    @IBOutlet var btnState: UIButton!
    @IBOutlet var btnStreetRoad: UIButton!
    @IBOutlet var btnProviderTimeZone: UIButton!
    @IBOutlet var btnKPITime: UIButton!
    @IBOutlet var btnProviderTime: UIButton!
    
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
    var DropDownSelection = NSString()
    var ProviderTypeId = String()
    var ProviderTimeZoneId = String()
    var StreetRoadId = String()
    var StateId = String()
    var CityId = String()
    
    let LoginApi = AllWebservices()
    var StreetList = [DropDownListData]()
    var StateList = [DropDownListData]()
    var CityList = [DropDownListData]()
    var DropDownList = [DropDownListData]()
    var UserTypeList = [DropDownListData]()
    var ProvideList = [DropDownListData]()
    var TimeZoneList = [DropDownListData]()
    var KPITimeList = [DropDownListData]()
    var stringStatus = ""
    var GetData = [ProviderDetailListData]()
    
    var imagePicker = UIImagePickerController()

    var frameScroll = CGRect()
      // MARK: - Method Start
      // MARK: -
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        imgCompanyProfil.layer.masksToBounds = true
        imgCompanyProfil.layer.cornerRadius = imgCompanyProfil.frame.size.height/2
        imagePicker.delegate = self
        
        print(stringStatus)
        if stringStatus == "View Provider"{
            self.title = "View Customer"
            self.ManageViewEdit(viewType: "View")
            let image =  #imageLiteral(resourceName: "CallEdit")
            //            image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddProvider.ViewProviderData))
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
            
             ViewProvider(status: false)
        }
        else{
            self.title = "Add Customer"
            ViewProvider(status: true)
            let image =  #imageLiteral(resourceName: "Save(Done)")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action:  #selector(AddProvider.AddProviderData))
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        }
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: viewAll.frame.size.height)
        frameScroll = scroll.frame
        //image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
//        self.GetProviderType()
//        DispatchQueue.main.async {
//            self.GetProviderTimeZone()
//        }
//        DispatchQueue.main.async {
//            self.GetStreetRoad()
//        }
//        DispatchQueue.main.async {
//            self.GetState()
//        }
//        DispatchQueue.main.async {
//            self.GetKPITime()
//        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if stringStatus == "View Provider"{
           // self.ManageViewEdit(viewType: "View")
          //  self.ViewProviderData()
            
        }
        DispatchQueue.main.async {
            self.GetKPITime()
        }
        
        DispatchQueue.main.async {
            self.GetProviderType()
        }
        DispatchQueue.main.async {
            self.GetProviderTimeZone()
        }
        DispatchQueue.main.async {
            self.GetStreetRoad()
        }
        DispatchQueue.main.async {
            self.GetState()
        }
        DispatchQueue.main.async {
            self.GetKPITime()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ViewProviderData() {
        ViewProvider(status: true)
        let image =  #imageLiteral(resourceName: "Save(Done)")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action:  #selector(AddProvider.AddProviderData))
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
    }
     func AddProviderData() {
        
        self.view.endEditing(true)
        var parameter = String()
       
        
        parameter = "token="
        parameter = parameter.appending(appDelegate.TOKEN as String) as String
        //        StreetId = "0000"
        //        StateId = "0000"
        //        CityId = "0000"
        //        UserTypeId = "0000"
       
        if txtProviderName.text == ""{
            showAlertMessage(title: "Alert", message: "Required Customer Name")
        }else
        if txtProviderAbbreviation.text == ""{
            showAlertMessage(title: "Alert", message: "Required Customer Abbreviation   ")
        }else
        if ProviderTypeId == "0000" || ProviderTypeId == "" {
            showAlertMessage(title: "Alert", message: "Required Customer Type")
        }else
        if txtKPITime.text == "Select KPI Time"{
            showAlertMessage(title: "Alert", message: "Required KPI Time")
        }else
        if ProviderTimeZoneId == "0000" || ProviderTimeZoneId == ""{
            showAlertMessage(title: "Alert", message: "Required Customer Timezone")
        }else
        if txtProviderFirstName.text == "" && stringStatus == "Add Provider"{
            showAlertMessage(title: "Alert", message: "Required Customer First Name")
        }else
        if txtProviderLastName.text == "" && stringStatus == "Add Provider"{
            showAlertMessage(title: "Alert", message: "Required Customer Last Name")
        }else
        if txtLoginEmail.text == "" && stringStatus == "Add Provider"{
            showAlertMessage(title: "Alert", message: "Required Login Email")
        }else
        if txtLoginPassword.text == "" && stringStatus == "Add Provider"{
            showAlertMessage(title: "Alert", message: "Required Login Password")
        }else
        if txtLoginConfirmPassword.text == "" && stringStatus == "Add Provider"{
            showAlertMessage(title: "Alert", message: "Required Login Confirm Password")
        }else{
            if stringStatus == "View Provider"{
                parameter = parameter.appending("&prv_id=").appending(GetData[0].PRV_Id) as String
            }
            parameter = parameter.appending("&prv_name=").appending(txtProviderName.text!)
                .appending("&prv_abbr=").appending(txtProviderAbbreviation.text!)
                .appending("&prv_type=").appending(ProviderTypeId)
                .appending("&prv_kpi_limit=").appending(txtKPITime.text!)
                .appending("&prv_timezone=").appending(ProviderTimeZoneId)
                if self.stringStatus == "View Provider"{
            
                }else{
                    parameter = parameter.appending("&user_fname=").appending(txtProviderFirstName.text!)
                    .appending("&user_lname=").appending(txtProviderLastName.text!)
                    .appending("&user_email=").appending(txtLoginEmail.text!)
                    .appending("&user_password=").appending(txtLoginPassword.text!)
                    .appending("&confirm_password=").appending(txtLoginConfirmPassword.text!)
                }
            if txtStreetNo.text != "" {
                parameter = parameter.appending("&user_street_no=").appending(txtStreetNo.text!)
            }
            if txtStreeName.text != "" {
                parameter = parameter.appending("&user_street_name=").appending(txtStreeName.text!)
            }
            if  StreetRoadId != "0000" && StreetRoadId != "" {
                parameter = parameter.appending("&user_street_road_id=").appending(StreetRoadId)
            }
            if StateId != "0000" && StateId != "" {
                parameter = parameter.appending("&user_state_id=").appending(StateId)
            }
            if CityId != "0000" && CityId != "" {
                parameter = parameter.appending("&user_city_id=").appending(CityId)
            }
            if txtZipCode.text != "" {
                parameter = parameter.appending("&user_zip_code=").appending(txtZipCode.text!)
            }
            if txtOfficeEmail.text != "" {
                parameter = parameter.appending("&prv_company_email=").appending(txtOfficeEmail.text!)
            }
            if txtWebsite.text != "" {
                parameter = parameter.appending("&prv_company_website=").appending(txtWebsite.text!)
            }

            print("parameter :-\(parameter)")
            DispatchQueue.main.async {
                var API = ""
                if self.stringStatus == "View Provider"{
                    API = self.LoginApi.Web_EditProvider as String
                }else{
                    API = self.LoginApi.Web_AddProvider as String
                }
                AllMethods().AddEditProvider(with: parameter, Api: API, completion: {(Message) in
                 print("Responce Message Add Provider = \(Message)")
                    self.showAlertMessage(title: "Alert", message: Message)
                     self.navigationController?.popViewController(animated: true)
                })
//                AllMethods().AddUser(with: parameter as String, completion: { (Message) in
//                    print("Responce Message Add User = \(Message)")
//                    if "User has been added successfully." == Message {
//                     //   self.GoBack()
//                    }
//                })
            }
        }
    }
    
    @IBAction func SelectProfile(_ sender: Any) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default){
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
            UIAlertAction in
        }
        // Add the actions
        imagePicker.delegate = self
        imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }
        else{
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
          //  let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles: nil)
            //alertWarning.show()
        }
    }
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    //PickerView Delegate Methods
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imgCompanyProfil.image = image
            imgCompanyProfil.layer.masksToBounds = true
             imgCompanyProfil.layer.cornerRadius = imgCompanyProfil.frame.size.height/2
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
//    {
//        picker .dismiss(animated: true, completion: nil)
//        //imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//        //imgCompanyProfil.image = info[UIImagePickerControllerOriginalImage] as? UIImage
//
//    }
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imgCompanyProfil.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func SelectProviderType(_ sender: Any) {
        DropDownSelection = "SelectProviderType"
         self.DropUp(list: self.ProvideList, view: viewProviderType, textField: txtProviderType)
    }
    
    @IBAction func SelectKPITime(_ sender: Any) {
        DropDownSelection = "SelectKPITime"
         self.DropUp(list: self.KPITimeList, view: viewKPITime, textField: txtKPITime)
    }
   
    @IBAction func SelectTimeZone(_ sender: Any) {
        DropDownSelection = "SelectTimeZone"
         self.DropUp(list: self.TimeZoneList, view: viewProviderTimezone, textField: txtProviderTimezone)
    }
    
    @IBAction func SelectStreetRoad(_ sender: Any) {
        DropDownSelection = "SelectStreetRoad"
         self.DropUp(list: self.StreetList, view: viewStreetRoad, textField: txtStreetRoad)
    }
    
    @IBAction func SelectState(_ sender: Any) {
        DropDownSelection = "SelectState"
         self.DropUp(list: self.StateList, view: viewState, textField: txtState)
    }
    
    @IBAction func SelectCity(_ sender: Any) {
        DropDownSelection = "SelectCity"
         self.DropUp(list: self.CityList, view: viewCity, textField: txtCity)
    }
    
    // MARK: - Dropdown Delegate
    func SelectedValue(time:NSInteger){
        
         if DropDownSelection == "SelectProviderType"{
            txtProviderType.text = self.ProvideList[time].Drp_Name
            ProviderTypeId = self.ProvideList[time].Drp_Id as String
           dropdown.removeFromSuperview()
            if time == 0{
                ProviderTypeId = ""
            }
            
            //            txtProviderType.text = ""
//            ProvideList
        }
        if DropDownSelection == "SelectKPITime"{
            txtKPITime.text = self.KPITimeList[time].Drp_Name
           // KPITimeId = self.KPITimeList[time].Drp_Id as String
            dropdown.removeFromSuperview()
        }
        if DropDownSelection == "SelectTimeZone"{
            txtProviderTimezone.text = self.TimeZoneList[time].Drp_Name
            ProviderTimeZoneId = self.TimeZoneList[time].Drp_Id as String
            dropdown.removeFromSuperview()
            if time == 0{
                ProviderTimeZoneId = ""
            }

//            TimeZoneList
        }
        if DropDownSelection == "SelectState"{
            txtState.text = self.StateList[time].Drp_Name
            StateId = self.StateList[time].Drp_Id as String
            txtCity.text = ""
            CityId = "0000"
            
            if time == 0{
                CityId = ""
            }else{
                self.GetCity(stateId: StateId)
            }
            dropdown.removeFromSuperview()
//            StateList
        }
        if DropDownSelection == "SelectCity"{
            txtCity.text = self.CityList[time].Drp_Name
            CityId = self.CityList[time].Drp_Id as String
            dropdown.removeFromSuperview()
            if time == 0{
                CityId = ""
            }
//            CityList
        }
        
        if DropDownSelection == "SelectStreetRoad"{
            txtStreetRoad.text = self.StreetList[time].Drp_Name
            StreetRoadId = self.StreetList[time].Drp_Id as String
            if time == 0{
                StreetRoadId = ""
            }
            dropdown.removeFromSuperview()
        }
    }

    func GetProviderType() {
//        var parameter : NSString
//        parameter = "&display_abbr=true"
        
        AllMethods().ProviderType(with: "", completion: { (ProviderList) in
            print("providerList call")
            self.ProvideList = [DropDownListData]()
            let cmd = DropDownListData(Drp_Id:"0000",
                                       Drp_StateId: "000",
                                       Drp_Name: "Select Customer Type"
            )
            self.ProvideList.append(cmd)
             self.ProvideList.append(contentsOf:ProviderList)
              //self.ProvideList = ProviderList
            
            DispatchQueue.main.async {
                if self.stringStatus == "View Provider"{
                    for  i in 0..<ProviderList.count{
                    //print("demo \(self.ProvideList[i].PRV_Name as String)")
//                    var cmd = DropDownListData()
//                    cmd.Drp_Id = ProviderList[i].Drp_Id as String
//                    cmd.Drp_Name = ProviderList[i].Drp_Name as String
//                    cmd.Drp_StateId = "Testing"
//                    self.ProvideList.append(cmd)
                        if self.GetData[0].PRV_Type as String == ProviderList[i].Drp_Name{
                            self.txtProviderType.text = self.GetData[0].PRV_Type
                            self.ProviderTypeId =  ProviderList[i].Drp_Id as String
                            self.txtProviderType.text = ProviderList[i].Drp_Name as String
                        }
                    }
                }
            }
        })
    }

    func GetProviderTimeZone() {
        AllMethods().TimeZone(with: "", completion: { (ProviderList) in
            print("providerList call")
            self.TimeZoneList = [DropDownListData]()
            let cmd = DropDownListData(Drp_Id:"0000",
                                      Drp_StateId: "000",
                                       Drp_Name: "Select TimeZone"
            )
            self.TimeZoneList.append(cmd)
            self.TimeZoneList.append(contentsOf:ProviderList)
            //self.ProvideList = ProviderList
            
            DispatchQueue.main.async {
                for  i in 0..<ProviderList.count{
                    //print("demo \(self.ProvideList[i].PRV_Name as String)")
//                    var cmd = DropDownListData()
//                    cmd.Drp_Id = ProviderList[i].Drp_Id as String
//                    cmd.Drp_Name = ProviderList[i].Drp_Name as String
//                    cmd.Drp_StateId = "Testing"
//                    self.TimeZoneList.append(cmd)
                    if self.stringStatus == "View Provider"{
                        if self.GetData[0].Timezone_Name as String == ProviderList[i].Drp_Name{
                            self.txtProviderTimezone.text = self.GetData[0].Timezone_Name
                            self.ProviderTimeZoneId =  ProviderList[i].Drp_Id as String
                            self.txtProviderTimezone.text = ProviderList[i].Drp_Name as String
                        }
                    }
                }
            }
        })

    }
    
    func GetStreetRoad() {
        var parameters = NSString()
        // parameters = "token="
        parameters = ("token=").appending(appDelegate.TOKEN as String) as NSString
        AllMethods().StreetCityStateDetail(with: parameters as String,API: LoginApi.Web_StreetDetail as String, completion: { (ProviderList) in
            self.StreetList = [DropDownListData]()
            let cmd = DropDownListData(Drp_Id:"0000",
                                       Drp_StateId: "000",
                                       Drp_Name: "Select Street"
            )
            self.StreetList.append(cmd)
            DispatchQueue.main.async {
                self.StreetList.append(contentsOf:ProviderList)
                
                if self.stringStatus == "View Provider"{
                    for  i in 0..<ProviderList.count{
                        if self.GetData[0].User_Street_Road_Id == ProviderList[i].Drp_Id{
                            self.StreetRoadId =  ProviderList[i].Drp_Id as String
                            self.txtStreetRoad.text = ProviderList[i].Drp_Name as String
                        }
                    }
                }
            }
        })
    }
    func GetState() {
        var parameters = NSString()
        parameters = ("token=").appending(appDelegate.TOKEN as String) as NSString
        AllMethods().StreetCityStateDetail(with: parameters as String,API: LoginApi.Web_StateDetail as String, completion: { (ProviderList) in
            DispatchQueue.main.async {
                let cmd = DropDownListData(Drp_Id:"0000",
                                           Drp_StateId: "Select State",
                                           Drp_Name: "Select State"
                )
                self.StateList = [DropDownListData]()
                
                self.StateList.append(cmd)
                self.StateList.append(contentsOf:ProviderList)
                if self.stringStatus == "View Provider"{
                    print("sadhsyfkdsfjkdshjks fghds \(self.GetData[0].User_State_Id as NSString)")
                    for  i in 0..<ProviderList.count{
                        if self.GetData[0].User_State_Id as String == ProviderList[i].Drp_Id{
                            self.StateId =  ProviderList[i].Drp_Id as String
                            self.txtState.text = ProviderList[i].Drp_Name as String
                            self.GetCity(stateId: self.StateId)
                        }
                    }
                }
                
            }
        })

    }
    func GetCity(stateId : String) {
        var parameters = NSString()
        parameters = ("token=").appending(appDelegate.TOKEN as String).appending("&state_id=").appending(stateId as String) as NSString
        print("city parameter \(parameters)")
        AllMethods().CityDetail(with: parameters as String,API: LoginApi.Web_CityDetail as String, completion: { (ProviderList) in
            DispatchQueue.main.async {
                self.CityList = [DropDownListData]()
                let cmd = DropDownListData(Drp_Id:"0000",
                                           Drp_StateId: "Select City",
                                           Drp_Name: "Select City"
                )
                self.CityList.append(cmd)
                self.CityList.append(contentsOf: ProviderList)
                if self.stringStatus == "View Provider"{
                    for  i in 0..<ProviderList.count{
                        if self.GetData[0].User_City_Id as String == ProviderList[i].Drp_Id{
                            self.CityId =  ProviderList[i].Drp_Id as String
                            self.txtCity.text = ProviderList[i].Drp_Name as String
                        }
                    }
                }
            }
        })
    }
    func GetKPITime() {
        self.KPITimeList = [DropDownListData]()
        let cmd = DropDownListData(Drp_Id:"0000",
                                   Drp_StateId: "Select KPI Timey",
                                   Drp_Name: "Select KPI Time"
        )
        self.KPITimeList.append(cmd);
        for i in 00..<24{
//            var kpi = String(i)//i.stringValue
            if i < 10{
                let kpi = "0".appending(String(i)).appending(":00")
                let cmd = DropDownListData(Drp_Id:"0000",
                                           Drp_StateId: "Select City",
                                           Drp_Name: kpi
                )
                self.KPITimeList.append(cmd);
            }else{
                let kpi = String(i).appending(":00")
                let cmd = DropDownListData(Drp_Id:"0000",
                                       Drp_StateId: "Select City",
                                       Drp_Name: kpi
                )
                self.KPITimeList.append(cmd);
            }
        }
    }

    func DropUp(list : [DropDownListData],view :UIView,textField : UITextField) {
        //DropDownSelection = "SelectCity"
        self.view.endEditing(true)
        if !self.DropDownView.isDescendant(of: self.viewAll){
            if list.count > 0 {
                print(textField.frame.origin.y+textField.frame.height)
                DropDownList = self.CityList//[DropDownListData]()
                let frame = CGRect(x: textField.frame.origin.x, y: viewAll.frame.origin.y+view.frame.origin.y+textField.frame.origin.y+textField.frame.height, width: textField.frame.width, height: 400)
                print(frame)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: list)
                self.viewAll.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }else{
            self.DropDownView.removeFromSuperview()
        }
    }
    func showAlertMessage(title : NSString,message : NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Keyboard Hide Show
    
    func keyboardWillShow(notification: NSNotification) {
        //            print("Keyboar will appear")
        dropdown.removeFromSuperview()
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.scroll.frame = frameScroll
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            print("Keyboar will appear\(keyboardFrame.size.height)")
            var demo = self.scroll.frame
            demo.size.height = self.scroll.frame.size.height - keyboardFrame.size.height
            self.scroll.frame = demo
            //self.scroll.constraints = keyboardFrame.size.height + 20
            //self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+keyboardFrame.size.height-64)
        })
    }

    func keyboardWillHide(notification: NSNotification) {
        print("keyboarhide")
        self.scroll.frame = frameScroll
        //self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-64)
    }
    
    func ManageViewEdit(viewType: NSString)  {
        txtProviderName.text = GetData[0].PRV_Name
        txtProviderAbbreviation.text = GetData[0].PRV_Abbr
//        txtProviderType.text = GetData[0].PRV
        txtKPITime.text = GetData[0].PRV_Kpi_Limit
        txtProviderTimezone.text = GetData[0].Timezone_Name
        txtStreetNo.text = GetData[0].User_Street_No
        txtStreeName.text = GetData[0].User_Street_Name
//        txtStreetRoad.text = ""
//        txtState.text = ""
//        txtCity.text = ""
//        txtZipCode.text = ""
        txtOfficeEmail.text = GetData[0].PRV_Company_Email
        txtWebsite.text = GetData[0].PRV_Company_Website
        
//        btnCity.isHidden = true
//        btnState.isHidden = true
//        btnStreetRoad.isHidden = true
//        btnProviderTimeZone.isHidden = true
//        btnKPITime.isHidden = true
//        btnProviderTime.isHidden = true
        
        viewAdminLoginInformation.isHidden = true
        viewProviderFirstName.isHidden = true
        viewProviderLastName.isHidden = true
        viewLoginEmail.isHidden = true
        viewLoginPassword.isHidden = true
        viewLoginConfirmPassword.isHidden = true
        
        
        var frameView = viewAll.frame
        frameView.size.height = viewWebsite.frame.origin.y+viewWebsite.frame.size.height
        viewAll.frame = frameView
    }
    
    func ViewProvider(status : Bool) {
        txtProviderName.isUserInteractionEnabled = status
        txtProviderAbbreviation.isUserInteractionEnabled = status
       // txtProviderType.isUserInteractionEnabled = status
       // txtKPITime.isUserInteractionEnabled = status
      //  txtProviderTimezone.isUserInteractionEnabled = status
        txtStreetNo.isUserInteractionEnabled = status
        txtStreeName.isUserInteractionEnabled = status
       // txtStreetRoad.isUserInteractionEnabled = status
        //txtState.isUserInteractionEnabled = status
        //txtCity.isUserInteractionEnabled = status
        txtZipCode.isUserInteractionEnabled = status
        txtOfficeEmail.isUserInteractionEnabled = status
        txtWebsite.isUserInteractionEnabled = status

        
        btnCity.isHidden = !status
        btnState.isHidden = !status
        btnStreetRoad.isHidden = !status
        btnProviderTimeZone.isHidden = !status
        btnKPITime.isHidden = !status
        btnProviderTime.isHidden = !status
        
        
        
        imgProviderName.isHidden = status
        imgProviderAbbreviation.isHidden = status
        imgProviderType.isHidden = status
        imgKPITime.isHidden = status
        imgProviderTimezone.isHidden = status
        imgStreetNo.isHidden = status
        imgStreeName.isHidden = status
        imgStreetRoad.isHidden = status
        imgState.isHidden = status
        imgCity.isHidden = status
        imgZipCode.isHidden = status
        imgOfficeEmail.isHidden = status
        imgWebsite.isHidden = status
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

extension AddProvider : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.txtProviderAbbreviation{
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 4 // Bool
        }else{
            return true
        }
    }
    
}
