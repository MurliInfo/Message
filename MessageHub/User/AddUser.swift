//
//  AddUser.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/24/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class AddUser: UIViewController,UIScrollViewDelegate,CloseDropDownDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    // MARK: - Storyboade declaration

    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet var viewAll: UIView!
    @IBOutlet var viewUserType: UIView!
    @IBOutlet var viewProviderName: UIView!
    @IBOutlet var viewFirstName: UIView!
    @IBOutlet var viewLastName: UIView!
    @IBOutlet var viewEmail: UIView!
    @IBOutlet var viewPassword: UIView!
    @IBOutlet var viewConfirmPassword: UIView!
    @IBOutlet var viewMobileNo: UIView!
    @IBOutlet var viewOfficeNo: UIView!
    @IBOutlet var viewStreetNo: UIView!
    @IBOutlet var viewStreetName: UIView!
    @IBOutlet var viewStreetRoad: UIView!
    @IBOutlet var viewState: UIView!
    @IBOutlet var viewCity: UIView!
    @IBOutlet var viewZipCode: UIView!
    @IBOutlet var viewUserProfile: UIView!
    @IBOutlet var viewButton: UIView!
    
    @IBOutlet var txtUserType: UITextField!
    
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var txtMobileNo: UITextField!
    @IBOutlet var txtOfficeNo: UITextField!
    @IBOutlet var txtStreetNo: UITextField!
    @IBOutlet var txtStreetName: UITextField!
    @IBOutlet var txtStreetRoad: UITextField!
    @IBOutlet var txtState: UITextField!
    @IBOutlet var txtCity: UITextField!
    @IBOutlet var txtZipCode: UITextField!
    @IBOutlet var txtProviderName: UITextField!
    
    @IBOutlet var btnUserType: UIButton!
    @IBOutlet var btnStreetRoad: UIButton!
    @IBOutlet var btnState: UIButton!
    @IBOutlet var btnCity: UIButton!
    @IBOutlet var btnProviderName: UIButton!
//    @IBOutlet var btnCancel: UIButton!
//    @IBOutlet var btnSubmit: UIButton!
//    
    @IBOutlet var lblLineUserType: UILabel!
    @IBOutlet var lblLineProviderName: UILabel!
    @IBOutlet var lblLineFirstName: UILabel!
    @IBOutlet var lblLineLastName: UILabel!
    @IBOutlet var lblLineEmail: UILabel!
    @IBOutlet var lblLinePassword: UILabel!
    @IBOutlet var lblLineConfirmPassword: UILabel!
    @IBOutlet var lblLineMobileNo: UILabel!
    @IBOutlet var lblLineOfficeNo: UILabel!
    @IBOutlet var lblLineStreetNo: UILabel!
    @IBOutlet var lblLineStreetName: UILabel!
    @IBOutlet var lblLineStreetRoad: UILabel!
    @IBOutlet var lblLineState: UILabel!
    @IBOutlet var lblLineCity: UILabel!
    @IBOutlet var lblLineZipCode: UILabel!
    
    @IBOutlet var lblStarUserType: UILabel!
    @IBOutlet var lblStarProviderName: UILabel!
    @IBOutlet var lblStarFirstName: UILabel!
    @IBOutlet var lblStarLastName: UILabel!
    @IBOutlet var lblStarEmail: UILabel!
    @IBOutlet var lblStarPassword: UILabel!
    @IBOutlet var lblStarConfirmPassword: UILabel!
    
    @IBOutlet var imgUserProfil: UIImageView!
    
    // MARK: - Local Declatation

    let LoginApi = AllWebservices()
    var StreetList = [DropDownListData]()
    var StateList = [DropDownListData]()
    var CityList = [DropDownListData]()
    var DropDownList = [DropDownListData]()
    var UserTypeList = [DropDownListData]()
    var ProvideList = [DropDownListData]()
    var DropDownSelection = NSString()
    var GetData = [UserListData]()
    
    var stringStatus = ""
    var StreetId = NSString()
    var StateId = NSString()
    var CityId = NSString()
    var UserTypeId = NSString()
    var ProviderId = NSString()
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
    var imagePicker = UIImagePickerController()

         // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        self.title = "Add User"
        imgUserProfil.layer.masksToBounds = true
        imgUserProfil.layer.cornerRadius = imgUserProfil.frame.size.height/2
        imagePicker.delegate = self
        
        viewProviderName.isHidden = true
        DropDownSelection = "Not Selected"
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: viewAll.frame.size.height)
        
        StreetId = "0000"
        StateId = "0000"
        CityId = "0000"
        UserTypeId = "0000"
        ProviderId = "0000"
        
        self.GetStreet()
        DispatchQueue.main.async {
            self.GetState()
        }
        DispatchQueue.main.async {
            self.GetUserType()
        }
        DispatchQueue.main.async {
            self.GetProviderList()
        }
        if stringStatus == "View User"{
            DispatchQueue.main.async {
                self.title = "View User"
                let image =  #imageLiteral(resourceName: "CallEdit")
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.isEdit))
                self.ViewUser()
            }
        }else{
            let image =  #imageLiteral(resourceName: "Save(Done)")
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.done, target: self, action:  #selector(self.AddUserData(_:)))
            
            btnUserType.tag = 1
            btnStreetRoad.tag = 1
            btnState.tag = 1
            btnCity.tag = 1
            btnProviderName.tag = 1
//            btnCancel.tag = 1
//            btnSubmit.tag = 1
        }
     // Do any additional setup after loading the view.
    }

    // MARK: - Action Methods

    @IBAction func AddUserData(_ sender: Any) {
       
         self.view.endEditing(true)
        var parameter = NSString()
         var CheckValu = Bool()
        CheckValu = true
        parameter = ""
//        StreetId = "0000"
//        StateId = "0000"
//        CityId = "0000"
//        UserTypeId = "0000"
        if UserTypeId == "0000"{
            self.lblLineUserType.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtFirstName.text == ""{
            self.lblLineFirstName.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtLastName.text == ""{
         self.lblLineLastName.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtEmail.text == ""{
            self.lblLineEmail.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtPassword.text == ""{
            self.lblLinePassword.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtPassword.text == ""{
            self.lblLinePassword.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtConfirmPassword.text == ""{
            self.lblLineConfirmPassword.backgroundColor = UIColor.red
            CheckValu = false
        }
        if UserTypeId == "3" || UserTypeId == "5" {
            if ProviderId == "0000" {
                self.lblLineProviderName.backgroundColor = UIColor.red
                CheckValu = false
            }
        }
        if CheckValu{
            parameter = parameter.appending("&user_type=").appending(UserTypeId as String).appending("&user_fname=").appending(txtFirstName.text!).appending("&user_lname=").appending(txtLastName.text!).appending("&user_email=").appending(txtEmail.text!).appending("&user_password=").appending(txtPassword.text!).appending("&confirm_password=").appending(txtConfirmPassword.text!) as NSString
            if  appDelegate.USERTYPE == "5" {
                parameter = parameter.appending("&user_provider_id=").appending(appDelegate.PROVIDERID as String ) as NSString
            }else{
            
                if UserTypeId == "3" || UserTypeId == "5" {
                    parameter = parameter.appending("&user_provider_id=").appending(ProviderId as String ) as NSString
                }
            }
            
            //user_provider_id
            if txtMobileNo.text != ""{
                parameter = parameter.appending("&user_phone_no=").appending(txtMobileNo.text!) as NSString
            }
            if txtOfficeNo.text != ""{
                parameter = parameter.appending("&user_office_no=").appending(txtOfficeNo.text!) as NSString
            }
            if txtStreetNo.text != ""{
                parameter = parameter.appending("&user_street_no=").appending(txtStreetNo.text!) as NSString
            }
            if txtStreetName.text != ""{
                parameter = parameter.appending("&user_street_name=").appending(txtStreetName.text!) as NSString
            }
            if StreetId != "0000"{
                parameter = parameter.appending("&user_street_road_id=").appending(StreetId as String) as NSString
            }
            if StateId != "0000"{
                parameter = parameter.appending("&user_state_id=").appending(StateId as String) as NSString
            }
            if CityId != "0000"{
                parameter = parameter.appending("&user_city_id=").appending(CityId as String) as NSString
            }
            if txtZipCode.text != ""{
                parameter = parameter.appending("&user_zip_code=").appending(txtZipCode.text!) as NSString
            }
         //   print("parameter :-\(parameter)")
            DispatchQueue.main.async {
                AllMethods().AddUser(with: parameter as String, completion: { (Message) in
                    print("Responce Message Add User = \(Message)")
                    if "User has been added successfully." == Message {
                        self.GoBack()
                    }
                })
            }
            // AddUser
        }else{
//            please fill requieds field
            print("please fill requieds field")
        }
//        }else{
//            EditUserSubmit()
//        }
    }
 
    @IBAction func Cancel(_ sender: Any) {
        self.view.endEditing(true)
        StreetId = "0000"
        StateId = "0000"
        CityId = "0000"
        UserTypeId = "0000"
        ProviderId = "0000"
        txtUserType.text = "Select User Type"
        txtFirstName.text = ""
        txtLastName.text = ""
        txtEmail.text = ""
        txtPassword.text = ""
        txtConfirmPassword.text = ""
        txtMobileNo.text = ""
        txtOfficeNo.text = ""
        txtStreetNo.text = ""
        txtStreetName.text = ""
        txtStreetRoad.text = "Select Street"
        txtState.text = "Select State"
        txtCity.text = "Select City"
        txtZipCode.text = ""
        self.GoBack()
    }   
    
    func isEdit() {
        self.title = "Edit User"
        lblStarPassword.isHidden = true
        lblStarConfirmPassword.isHidden = true
        self.StatusUser(isHide: false, ButtonTag: 2)
        self.ManageViewEdit(viewType: "Edit View")
        lblStarPassword.isHidden = true
        lblStarConfirmPassword.isHidden = true
        let image =  #imageLiteral(resourceName: "Save(Done)")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.done, target: self, action:  #selector(self.EditUserSubmit))
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
            
            imgUserProfil.image = image
            imgUserProfil.layer.masksToBounds = true
            imgUserProfil.layer.cornerRadius = imgUserProfil.frame.size.height/2
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imgUserProfil.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func SelectCity(_ sender: Any) {
        DropDownSelection = "SelectCity"
        self.DropUp(list: self.CityList, view: viewCity, textField: txtCity)
    }
    
    @IBAction func SelectProviderName(_ sender: Any) {
        DropDownSelection = "SelectProviderName"
        self.DropUp(list: self.ProvideList, view: viewProviderName, textField: txtProviderName)
    }
    
    @IBAction func SelectState(_ sender: Any) {
        DropDownSelection = "SelectState"
        self.DropUp(list: self.StateList, view: viewState, textField: txtState)
    }

    @IBAction func SelectStreetRoad(_ sender: Any) {
        DropDownSelection = "SelectStreetRoad"
        self.DropUp(list: self.StreetList, view: viewStreetRoad, textField: txtStreetRoad)
    }

    @IBAction func SelectUserType(_ sender: Any) {
         DropDownSelection = "SelectUserType"
            self.DropUp(list: self.UserTypeList, view: viewUserType, textField: txtUserType)
    }

    // MARK: - Dropdown Delegate
    func SelectedValue(time:NSInteger){
        if DropDownSelection == "SelectStreetRoad"{
           txtStreetRoad.text = self.StreetList[time].Drp_Name
           StreetId = self.StreetList[time].Drp_Id as NSString
           dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectState"{
            txtState.text = self.StateList[time].Drp_Name
            StateId = self.StreetList[time].Drp_Id as NSString
            self.GetCity(stateId: StateId)
            dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectCity"{
            txtCity.text = self.CityList[time].Drp_Name
            CityId = self.CityList[time].Drp_Id as NSString
            dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectUserType"{
            txtUserType.text = self.UserTypeList[time].Drp_Name
            UserTypeId = self.UserTypeList[time].Drp_Id as NSString
            self.ManageView(UserId: UserTypeId)
            dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectProviderName"{
            txtProviderName.text = self.ProvideList[time].Drp_Name
            ProviderId = self.ProvideList[time].Drp_Id as NSString
            dropdown.removeFromSuperview()
        }
    }

    // MARK: -View Detail from dashboard
    func ViewUser(){
        lblStarPassword.isHidden = true
        lblStarConfirmPassword.isHidden = true
        print(GetData[0].User_Type_Name as String)
        txtUserType.text = GetData[0].User_Type_Name as String
        UserTypeId = GetData[0].User_Type as NSString
        
        txtFirstName.text = GetData[0].User_Fname as String
        txtLastName.text = GetData[0].User_Lname as String
        txtEmail.text = GetData[0].User_Email as String
        txtMobileNo.text = GetData[0].User_Phone_No as String
        txtOfficeNo.text = GetData[0].User_Office_No as String
        txtStreetNo.text = GetData[0].User_Street_No as String
        txtStreetName.text = GetData[0].User_Street_Name as String
        txtZipCode.text = GetData[0].User_Zip_Code as String
      
        self.StatusUser(isHide: true, ButtonTag: 1)
        self.ManageViewEdit(viewType: "View")
    }
    
    // MARK: - User define methosds
    func EditUserSubmit()  {
        self.view.endEditing(true)
        var parameter = NSString()
        var CheckValu = Bool()
        CheckValu = true
        parameter = ""
        if UserTypeId == "0000" || UserTypeId == "0"{
            self.lblLineUserType.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtFirstName.text == ""{
            self.lblLineFirstName.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtLastName.text == ""{
            self.lblLineLastName.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtEmail.text == ""{
            self.lblLineEmail.backgroundColor = UIColor.red
            CheckValu = false
        }
        if txtPassword.text != ""{
            if txtPassword.text == "" || (txtPassword.text?.characters.count)! < 5 {
                self.lblLinePassword.backgroundColor = UIColor.red
                CheckValu = false
            }
            if txtConfirmPassword.text == ""{
                self.lblLinePassword.backgroundColor = UIColor.red
                CheckValu = false
            }
            if txtConfirmPassword.text != txtPassword.text{
                self.lblLineConfirmPassword.backgroundColor = UIColor.red
                CheckValu = false
            }
        }
        if txtConfirmPassword.text != ""{
            if txtPassword.text == "" || (txtPassword.text?.characters.count)! < 5 {
                self.lblLinePassword.backgroundColor = UIColor.red
                print("please fill \(txtPassword.text!.characters.count)")
                CheckValu = false
            }
            if txtConfirmPassword.text == ""{
                self.lblLinePassword.backgroundColor = UIColor.red
                CheckValu = false
            }
            if txtConfirmPassword.text != txtPassword.text{
                self.lblLineConfirmPassword.backgroundColor = UIColor.red
                CheckValu = false
            }
        }

//        if txtPassword.text == ""{
//            self.lblLinePassword.backgroundColor = UIColor.red
//            CheckValu = false
//        }
//        if txtPassword.text == ""{
//            self.lblLinePassword.backgroundColor = UIColor.red
//            CheckValu = false
//        }
//        if txtConfirmPassword.text == ""{
//            self.lblLineConfirmPassword.backgroundColor = UIColor.red
//            CheckValu = false
//        }
        if UserTypeId == "3" || UserTypeId == "5" {
            if ProviderId == "0000" {
                self.lblLineProviderName.backgroundColor = UIColor.red
                CheckValu = false
            }
        }
        if CheckValu{
            parameter = parameter.appending("&user_id=").appending(GetData[0].User_Id) as NSString
          
            parameter = parameter.appending("&user_type=").appending(UserTypeId as String).appending("&user_fname=").appending(txtFirstName.text!).appending("&user_lname=").appending(txtLastName.text!).appending("&user_email=").appending(txtEmail.text!).appending("&user_password=").appending(txtPassword.text!).appending("&confirm_password=").appending(txtConfirmPassword.text!) as NSString
            if UserTypeId == "3" || UserTypeId == "5" {
                parameter = parameter.appending("&user_provider_id=").appending(ProviderId as String) as NSString
            }
                parameter = parameter.appending("&user_phone_no=").appending(txtMobileNo.text!) as NSString
                parameter = parameter.appending("&user_office_no=").appending(txtOfficeNo.text!) as NSString
                parameter = parameter.appending("&user_street_no=").appending(txtStreetNo.text!) as NSString
                parameter = parameter.appending("&user_street_name=").appending(txtStreetName.text!) as NSString
                parameter = parameter.appending("&user_street_road_id=").appending(StreetId as String) as NSString
                parameter = parameter.appending("&user_state_id=").appending(StateId as String) as NSString
                parameter = parameter.appending("&user_city_id=").appending(CityId as String) as NSString
                parameter = parameter.appending("&user_zip_code=").appending(txtZipCode.text!) as NSString
             DispatchQueue.main.async {
                AllMethods().EditUser(with: parameter as String, completion: { (Message) in
                    print("Responce Message Edit User = \(Message)")
                    if "User has been updated successfully." == Message {
                        self.GoBack()
                    }else{
                        self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
                    }
                })
            }
        }else{
            self.ShowAlertMessage(title: "", message: "please fill required field" as String, buttonText: "OK")
            print("please fill requieds field")
        }
  }
    
    func GetCity(stateId : NSString) {
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
                if self.stringStatus == "View User"{
                    for  i in 0..<ProviderList.count{
                        if self.GetData[0].User_City_Id as String == ProviderList[i].Drp_Id{
                            self.CityId =  ProviderList[i].Drp_Id as NSString
                            self.txtCity.text = ProviderList[i].Drp_Name as String
                        }
                    }
                }
            }
        })
    }

    func GetStreet() {
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
                
                if self.stringStatus == "View User"{
                    NSLog("Iddsfds %@ ",self.GetData[0].User_Provider_Id)
                    for  i in 0..<ProviderList.count{
                        if self.GetData[0].User_Street_Road_Id == ProviderList[i].Drp_Id{
                            self.StreetId =  ProviderList[i].Drp_Id as NSString
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
                if self.stringStatus == "View User"{
                    print("sadhsyfkdsfjkdshjks fghds \(self.GetData[0].User_State_Id as NSString)")
                    for  i in 0..<ProviderList.count{
                        if self.GetData[0].User_State_Id as String == ProviderList[i].Drp_Id{
                            self.StateId =  ProviderList[i].Drp_Id as NSString
                            self.txtState.text = ProviderList[i].Drp_Name as String
                            self.GetCity(stateId: self.StateId)
                        }
                    }
                }

           }
        })
    }
/*

*/
    func GetProviderList(){
//        var parameter : NSString
//        parameter = "&display_abbr=true"
//        
        AllMethods().providerList(with: "", completion: { (ProviderList) in
            print("providerList call")
            self.ProvideList = [DropDownListData]()
          //  self.ProvideList = ProviderList
            DispatchQueue.main.async {
                for  i in 0..<ProviderList.count{
                    //print("demo \(self.ProvideList[i].PRV_Name as String)")
                    var cmd = DropDownListData()
                    cmd.Drp_Id = ProviderList[i].PRV_Id as String
                    cmd.Drp_Name = ProviderList[i].PRV_Name as String
                    cmd.Drp_StateId = "Testing"
                    self.ProvideList.append(cmd)
                    if self.stringStatus == "View User"{
                        if self.GetData[0].User_Provider_Id as String == ProviderList[i].PRV_Id{
                            self.ProviderId =  ProviderList[i].PRV_Id as NSString
                            self.txtProviderName.text = ProviderList[i].PRV_Name as String
                        }
                    }

                }
            }
        })
    }
    
    func GetUserType() {
        UserTypeList = [DropDownListData]()
        var cmd = DropDownListData(Drp_Id:"0000",
                                   Drp_StateId: "Select user type",
                                   Drp_Name: "Select User Type"
        )
//        Agent 1
//        Admin 5
//        staff 3

        UserTypeList.append(cmd)
         if appDelegate.USERTYPE != appDelegate.PROVIDERADMIN{
        cmd = DropDownListData(Drp_Id:"1",
                                    Drp_StateId: "Agent",
                                    Drp_Name: "Agent"
        )
        UserTypeList.append(cmd)
        }
            cmd = DropDownListData(Drp_Id:"5",
                                   Drp_StateId: "Admin",
                                   Drp_Name: "Admin"
            )
            UserTypeList.append(cmd)
        
        
        cmd = DropDownListData(Drp_Id:"3",
                                   Drp_StateId: "Staff",
                                   Drp_Name: "Staff"
        )
        UserTypeList.append(cmd)
        
    }

    func ManageView(UserId: NSString)  {
        if UserTypeId == "5" || UserTypeId == "3"{
            viewProviderName.isHidden = false
            viewProviderName.frame = ManageFrame(FrameMain: viewProviderName.frame, FrameSecond: viewUserType.frame);
            viewFirstName.frame = ManageFrame(FrameMain: viewFirstName.frame, FrameSecond: viewProviderName.frame);
            viewLastName.frame = ManageFrame(FrameMain: viewLastName.frame, FrameSecond: viewFirstName.frame);
            viewEmail.frame = ManageFrame(FrameMain: viewEmail.frame, FrameSecond: viewLastName.frame);
            viewPassword.frame = ManageFrame(FrameMain: viewPassword.frame, FrameSecond: viewEmail.frame);
            viewConfirmPassword.frame = ManageFrame(FrameMain: viewConfirmPassword.frame, FrameSecond: viewPassword.frame);
            viewMobileNo.frame = ManageFrame(FrameMain: viewMobileNo.frame, FrameSecond: viewConfirmPassword.frame);
            viewOfficeNo.frame = ManageFrame(FrameMain: viewOfficeNo.frame, FrameSecond: viewMobileNo.frame);
            viewStreetNo.frame = ManageFrame(FrameMain: viewStreetNo.frame, FrameSecond: viewOfficeNo.frame);
            viewStreetName.frame = ManageFrame(FrameMain: viewStreetName.frame, FrameSecond: viewStreetNo.frame);
            viewStreetRoad.frame = ManageFrame(FrameMain: viewStreetRoad.frame, FrameSecond: viewStreetName.frame);
            viewState.frame = ManageFrame(FrameMain: viewState.frame, FrameSecond: viewStreetRoad.frame);
            viewCity.frame = ManageFrame(FrameMain: viewCity.frame, FrameSecond: viewState.frame);
            viewZipCode.frame = ManageFrame(FrameMain: viewZipCode.frame, FrameSecond: viewCity.frame);
         //   viewUserProfile.frame = ManageFrame(FrameMain: viewUserProfile.frame, FrameSecond: viewZipCode.frame);
           // viewButton.frame = ManageFrame(FrameMain: viewButton.frame, FrameSecond: viewUserProfile.frame);
        }else{
            viewProviderName.isHidden = true
            viewFirstName.frame = ManageFrame(FrameMain: viewFirstName.frame, FrameSecond: viewUserType.frame);
            viewLastName.frame = ManageFrame(FrameMain: viewLastName.frame, FrameSecond: viewFirstName.frame);
            viewEmail.frame = ManageFrame(FrameMain: viewEmail.frame, FrameSecond: viewLastName.frame);
            viewPassword.frame = ManageFrame(FrameMain: viewPassword.frame, FrameSecond: viewEmail.frame);
            viewConfirmPassword.frame = ManageFrame(FrameMain: viewConfirmPassword.frame, FrameSecond: viewPassword.frame);
            viewMobileNo.frame = ManageFrame(FrameMain: viewMobileNo.frame, FrameSecond: viewConfirmPassword.frame);
            viewOfficeNo.frame = ManageFrame(FrameMain: viewOfficeNo.frame, FrameSecond: viewMobileNo.frame);
            viewStreetNo.frame = ManageFrame(FrameMain: viewStreetNo.frame, FrameSecond: viewOfficeNo.frame);
            viewStreetName.frame = ManageFrame(FrameMain: viewStreetName.frame, FrameSecond: viewStreetNo.frame);
            viewStreetRoad.frame = ManageFrame(FrameMain: viewStreetRoad.frame, FrameSecond: viewStreetName.frame);
            viewState.frame = ManageFrame(FrameMain: viewState.frame, FrameSecond: viewStreetRoad.frame);
            viewCity.frame = ManageFrame(FrameMain: viewCity.frame, FrameSecond: viewState.frame);
            viewZipCode.frame = ManageFrame(FrameMain: viewZipCode.frame, FrameSecond: viewCity.frame);
           // viewUserProfile.frame = ManageFrame(FrameMain: viewUserProfile.frame, FrameSecond: viewZipCode.frame);
           // viewButton.frame = ManageFrame(FrameMain: viewButton.frame, FrameSecond: viewUserProfile.frame);
        }
    }
    
    func ManageViewEdit(viewType: NSString)  {
        
        if viewType == "View" {
            var frame = CGRect()
            viewPassword.isHidden = true
            viewConfirmPassword.isHidden = true
            viewProviderName.isHidden = false
            if UserTypeId == "5" || UserTypeId == "3"{
                viewProviderName.frame = ManageFrame(FrameMain: viewProviderName.frame, FrameSecond: viewUserType.frame);
                frame = viewProviderName.frame;
            }else{
                viewProviderName.isHidden = true
                frame = viewUserType.frame;
            }
            viewFirstName.frame = ManageFrame(FrameMain: viewFirstName.frame, FrameSecond: frame);
            viewLastName.frame = ManageFrame(FrameMain: viewLastName.frame, FrameSecond: viewFirstName.frame);
            viewEmail.frame = ManageFrame(FrameMain: viewEmail.frame, FrameSecond: viewLastName.frame);
            viewMobileNo.frame = ManageFrame(FrameMain: viewMobileNo.frame, FrameSecond: viewEmail.frame);
            viewOfficeNo.frame = ManageFrame(FrameMain: viewOfficeNo.frame, FrameSecond: viewMobileNo.frame);
            viewStreetNo.frame = ManageFrame(FrameMain: viewStreetNo.frame, FrameSecond: viewOfficeNo.frame);
            viewStreetName.frame = ManageFrame(FrameMain: viewStreetName.frame, FrameSecond: viewStreetNo.frame);
            viewStreetRoad.frame = ManageFrame(FrameMain: viewStreetRoad.frame, FrameSecond: viewStreetName.frame);
            viewState.frame = ManageFrame(FrameMain: viewState.frame, FrameSecond: viewStreetRoad.frame);
            viewCity.frame = ManageFrame(FrameMain: viewCity.frame, FrameSecond: viewState.frame);
            viewZipCode.frame = ManageFrame(FrameMain: viewZipCode.frame, FrameSecond: viewCity.frame);
            //viewUserProfile.frame = ManageFrame(FrameMain: viewUserProfile.frame, FrameSecond: viewZipCode.frame);
            //viewButton.frame = ManageFrame(FrameMain: viewButton.frame, FrameSecond: viewUserProfile.frame);
        }else{
            var frame = CGRect()
            viewPassword.isHidden = false
            viewConfirmPassword.isHidden = false
            if UserTypeId == "5" || UserTypeId == "3"{
                viewProviderName.frame = ManageFrame(FrameMain: viewProviderName.frame, FrameSecond: viewUserType.frame);
                frame = viewProviderName.frame;
            }else{
                viewProviderName.isHidden = true
                frame = viewUserType.frame;
            }
            viewFirstName.frame = ManageFrame(FrameMain: viewFirstName.frame, FrameSecond: frame);
            viewLastName.frame = ManageFrame(FrameMain: viewLastName.frame, FrameSecond: viewFirstName.frame);
            viewEmail.frame = ManageFrame(FrameMain: viewEmail.frame, FrameSecond: viewLastName.frame);
            viewPassword.frame = ManageFrame(FrameMain: viewPassword.frame, FrameSecond: viewEmail.frame);
            viewConfirmPassword.frame = ManageFrame(FrameMain: viewConfirmPassword.frame, FrameSecond: viewPassword.frame);
            viewMobileNo.frame = ManageFrame(FrameMain: viewMobileNo.frame, FrameSecond: viewConfirmPassword.frame);
            viewOfficeNo.frame = ManageFrame(FrameMain: viewOfficeNo.frame, FrameSecond: viewMobileNo.frame);
            viewStreetNo.frame = ManageFrame(FrameMain: viewStreetNo.frame, FrameSecond: viewOfficeNo.frame);
            viewStreetName.frame = ManageFrame(FrameMain: viewStreetName.frame, FrameSecond: viewStreetNo.frame);
            viewStreetRoad.frame = ManageFrame(FrameMain: viewStreetRoad.frame, FrameSecond: viewStreetName.frame);
            viewState.frame = ManageFrame(FrameMain: viewState.frame, FrameSecond: viewStreetRoad.frame);
            viewCity.frame = ManageFrame(FrameMain: viewCity.frame, FrameSecond: viewState.frame);
            viewZipCode.frame = ManageFrame(FrameMain: viewZipCode.frame, FrameSecond: viewCity.frame);
         //   viewUserProfile.frame = ManageFrame(FrameMain: viewUserProfile.frame, FrameSecond: viewZipCode.frame);
        //    viewButton.frame = ManageFrame(FrameMain: viewButton.frame, FrameSecond: viewUserProfile.frame);
        }
    }

    
    func ManageFrame(FrameMain : CGRect, FrameSecond : CGRect)-> CGRect {
        var frame = CGRect()
        frame = FrameMain;
        frame.origin.y = FrameSecond.size.height+FrameSecond.origin.y;
        return frame
    }
    func StatusUser(isHide : Bool , ButtonTag : Int)   {
        lblStarUserType.isHidden = isHide
        lblStarProviderName.isHidden = isHide
        lblStarFirstName.isHidden = isHide
        lblStarLastName.isHidden = isHide
        lblStarEmail.isHidden = isHide
        lblStarPassword.isHidden = isHide
        lblStarConfirmPassword.isHidden = isHide
        
        btnUserType.tag = ButtonTag
        btnStreetRoad.tag = ButtonTag
        btnState.tag = ButtonTag
        btnCity.tag = ButtonTag
        btnProviderName.tag = ButtonTag
//        btnCancel.tag = ButtonTag
//        btnSubmit.tag = ButtonTag
//        btnCancel.isHidden = isHide
//        btnSubmit.isHidden = isHide
        btnUserType.isUserInteractionEnabled = !isHide
        btnStreetRoad.isUserInteractionEnabled = !isHide
        btnState.isUserInteractionEnabled = !isHide
        btnCity.isUserInteractionEnabled = !isHide
        btnProviderName.isUserInteractionEnabled = !isHide
        
        txtFirstName.isUserInteractionEnabled = !isHide
        txtLastName.isUserInteractionEnabled = !isHide
        txtEmail.isUserInteractionEnabled = !isHide
        txtMobileNo.isUserInteractionEnabled = !isHide
        txtOfficeNo.isUserInteractionEnabled = !isHide
        txtStreetNo.isUserInteractionEnabled = !isHide
        txtStreetName.isUserInteractionEnabled = !isHide
        txtZipCode.isUserInteractionEnabled = !isHide

    }
    
    func DropUp(list : [DropDownListData],view :UIView,textField : UITextField) {
                //DropDownSelection = "SelectCity"
        self.view.endEditing(true)
        if !self.DropDownView.isDescendant(of: self.viewAll){
            if list.count > 0 {
                DropDownList = self.CityList//[DropDownListData]()
                let frame = CGRect(x: textField.frame.origin.x, y: viewAll.frame.origin.y+view.frame.origin.y+textField.frame.origin.y+textField.frame.height, width: textField.frame.width, height: 400)
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
    
    func GoBack()  {
        self.navigationController?.popViewController(animated: true)
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
    }
}

// MARK: - Extensions

extension AddUser : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            //lblLineFrom.backgroundColor =
//            self.lblLineUserType.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineFirstName.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineLastName.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineEmail.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLinePassword.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineConfirmPassword.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineMobileNo.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineOfficeNo.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineStreetNo.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineStreetName.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineStreetRoad.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineState.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineCity.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineZipCode.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
        }
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            //lblLineFrom.backgroundColor =
//            self.lblLineUserType.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineFirstName.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineLastName.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineEmail.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLinePassword.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineConfirmPassword.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineMobileNo.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineOfficeNo.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineStreetNo.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineStreetName.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineStreetRoad.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineState.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineCity.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineZipCode.backgroundColor = GlobalMethods().hexStringToUIColor(hex: "EFEFEF" )
        }
//        switch textField.tag {
//            
//        case  1:
//                self.lblLineUserType.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  2:
//                self.lblLineFirstName.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  3:
//                self.lblLineLastName.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  4:
//                self.lblLineEmail.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  5:
//                self.lblLinePassword.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  6:
//                self.lblLineConfirmPassword.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  7:
//                self.lblLineMobileNo.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  8:
//                self.lblLineOfficeNo.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  9:
//                self.lblLineStreetNo.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  10:
//                  self.lblLineStreetName.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  11:
//                 self.lblLineStreetRoad.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  12:
//                self.lblLineState.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  13:
//                self.lblLineCity.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            case  14:
//                self.lblLineZipCode.backgroundColor = AllMethods().hexStringToUIColor(hex: "303F9F" )
//            break
//            default: break
//        }
        if textField.tag == 1{
            DispatchQueue.main.async {
                self.lblLineUserType.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else  if textField.tag == 2{
            DispatchQueue.main.async {
                self.lblLineFirstName.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 3{
            DispatchQueue.main.async {
                self.lblLineLastName.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 4{
            DispatchQueue.main.async {
                self.lblLineEmail.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 5{
            DispatchQueue.main.async {
                self.lblLinePassword.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 6{
            DispatchQueue.main.async {
                self.lblLineConfirmPassword.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        } else if textField.tag == 7{
            DispatchQueue.main.async {
                self.lblLineMobileNo.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else  if textField.tag == 8{
            DispatchQueue.main.async {
                self.lblLineOfficeNo.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 9{
            DispatchQueue.main.async {
                self.lblLineStreetNo.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 10{
            DispatchQueue.main.async {
                self.lblLineStreetName.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 11{
            DispatchQueue.main.async {
                self.lblLineStreetRoad.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 12{
            DispatchQueue.main.async {
                self.lblLineState.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 13{
            DispatchQueue.main.async {
                self.lblLineCity.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else if textField.tag == 14{
            DispatchQueue.main.async {
                self.lblLineZipCode.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
            }
        }else{
            DispatchQueue.main.async {
                //lblLineFrom.backgroundColor =
                
            }
            
        }
        print(textField.tag)
    }
}

