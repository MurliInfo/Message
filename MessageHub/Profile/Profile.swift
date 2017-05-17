//
//  Profile.swift
//  MessageHub
//
//  Created by Hardik Davda on 3/7/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import CZPicker

class Profile: UIViewController,UIScrollViewDelegate,CloseDropDownDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var table: UITableView!
    @IBOutlet var scroll: UIScrollView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet var viewAll : UIView!
     @IBOutlet var viewUserProfile : UIView!
    @IBOutlet var viewFirstName : UIView!
    @IBOutlet var viewLastName : UIView!
    @IBOutlet var viewEmail : UIView!
    @IBOutlet var viewMobileNo : UIView!
    @IBOutlet var viewOfficeNo : UIView!
    @IBOutlet var viewStreetNo : UIView!
    @IBOutlet var viewStreetName : UIView!
    @IBOutlet var viewStreetRoad : UIView!
    @IBOutlet var viewState : UIView!
    @IBOutlet var viewCity : UIView!
    @IBOutlet var viewZipCode : UIView!
    
    @IBOutlet var txtFirstName : UITextField!
    @IBOutlet var txtLastName : UITextField!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtMobileNo : UITextField!
    @IBOutlet var txtOfficeNo : UITextField!
    @IBOutlet var txtStreetNo : UITextField!
    @IBOutlet var txtStreetName : UITextField!
    @IBOutlet var txtStreetRoad : UITextField!
    @IBOutlet var txtState : UITextField!
    @IBOutlet var txtCity : UITextField!
    @IBOutlet var txtZipCode : UITextField!
    
    @IBOutlet var imgUserProfile: UIImageView!

    @IBOutlet var imgFirstName : UIImageView!
    @IBOutlet var imgLastName : UIImageView!
    @IBOutlet var imgEmail : UIImageView!
    @IBOutlet var imgMobileNo : UIImageView!
    @IBOutlet var imgOfficeNo : UIImageView!
    @IBOutlet var imgStreetNo : UIImageView!
    @IBOutlet var imgStreetName : UIImageView!
    @IBOutlet var imgStreetRoad : UIImageView!
    @IBOutlet var imgState : UIImageView!
    @IBOutlet var imgCity : UIImageView!
    @IBOutlet var imgZipCode : UIImageView!
    
    @IBOutlet var btnStreetRoad : UIButton!
    @IBOutlet var btnState : UIButton!
    @IBOutlet var btnCity : UIButton!
    
    let keyboardToolbar = UIToolbar()
    var picker: CZPickerView?
    var form = [Forms]()
    var userList = [UserListData]()
    var StreetList = [DropDownListData]()
    var StateList = [DropDownListData]()
    var CityList = [DropDownListData]()
    var DropDownList = [DropDownListData]()
    var GetData = [UserListData]()
    var isView = Bool()
    var DropDownSelection = NSString()
    var stringStatus = ""
    var StreetId = NSString()
    var StateId = NSString()
    var CityId = NSString()
    
    var ProfileForms = [ProfileForm]()
    var TableFrame = CGRect()
    var dropdown = PopView()
    var DropDownView : UIView = UIView()
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgUserProfile.layer.masksToBounds = true
        imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.height/2
        imagePicker.delegate = self
        self.addDoneButton()
        self.title = "Profile"
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
      let image =  #imageLiteral(resourceName: "CallEdit")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(Profile.EditProfile(_:)))
        
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.stringStatus = "View User"
        isView = true
        DropDownSelection = "Not Selected"
        self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: viewAll.frame.size.height)
        
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TableFrame = table.frame;
        CustomForm().CreateProfile(completion: { (demo) in
            DispatchQueue.main.async {
                self.form = demo
                self.table.reloadData()
                DispatchQueue.main.async {
                    self.GetUserDetail()
                }
            }
        })
    }
    func addDoneButton() {
        //        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        //        txtPhoneNumber.inputAccessoryView = keyboardToolbar
        //        txtResonForCall.inputAccessoryView = keyboardToolbar
    }
    func keyboardWillShow(notification: NSNotification) {
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            print("Keyboar will appear\(keyboardFrame.size.height)")
        })
    }

    func keyboardWillHide(notification: NSNotification) {
        print("keyboard Hide")
    }

    // MARK: - IBAction
    @IBAction func EditProfile(_ sender: Any){
        isView = false
        table.reloadData()
//        self.title = "Edit Profile"
    
        HideShowImage(status: true)
        let image =  #imageLiteral(resourceName: "Save(Done)")

        //self.navigationItem.setRightBarButton(nil, animated: true)
      //  self.navigationItem.setRightBarButton(<#T##item: UIBarButtonItem?##UIBarButtonItem?#>, animated: <#T##Bool#>)

//        self.navigationItem.rightBarButtonItem = nil;
//
//        image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.done, target: self, action:  #selector(Profile.Done))
//        self.navigationController?.navigationBar.tintColor = UIColor.white;
//        
//        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white;
       
       // self.navigationController?.navigationBar.tintColor = UIColor.white
       
        //self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
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
            
            imgUserProfile.image = image
            imgUserProfile.layer.masksToBounds = true
            imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.height/2
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        imgUserProfile.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SelectDropDown(_ sender: Any) {
        let button = sender
        if (button as AnyObject).tag == 7{
            if StreetList.count != 0{
                DropDownSelection = "SelectStreetRoad"
                picker = CZPickerView(headerTitle: "Street Road", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
                picker?.delegate = self
                picker?.dataSource = self as CZPickerViewDataSource
                picker?.needFooterView = true
                picker?.cancelButtonBackgroundColor = UIColor().textFieldBackgroundColor()
                picker?.headerBackgroundColor = UIColor().tintColor()
                picker?.confirmButtonBackgroundColor = UIColor().tintColor()
                picker?.show()
            }
            
        }
        if (button as AnyObject).tag == 8{
            
            if StateList.count != 0{
               DropDownSelection = "SelectState"
                picker = CZPickerView(headerTitle: "State", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
                picker?.delegate = self
                picker?.dataSource = self as CZPickerViewDataSource
                picker?.needFooterView = true
                picker?.cancelButtonBackgroundColor = UIColor().textFieldBackgroundColor()
                picker?.headerBackgroundColor = UIColor().tintColor()
                picker?.confirmButtonBackgroundColor = UIColor().tintColor()
                picker?.show()
            }
        }
        if (button as AnyObject).tag == 9{
            
            if CityList.count != 0{
                DropDownSelection = "SelectCity"
                picker = CZPickerView(headerTitle: "City", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
                picker?.delegate = self
                picker?.dataSource = self as CZPickerViewDataSource
                picker?.needFooterView = true
                picker?.cancelButtonBackgroundColor = UIColor().textFieldBackgroundColor()
                picker?.headerBackgroundColor = UIColor().tintColor()
                picker?.confirmButtonBackgroundColor = UIColor().tintColor()
                picker?.show()
            }
        }
        self.view.endEditing(true)
    }
    
    @IBAction func SelectCity(_ sender: Any) {
        DropDownSelection = "SelectCity"
        self.DropUp(list: self.CityList, view: viewCity, textField: txtCity)
    }
    
    @IBAction func SelectStreetRoad(_ sender: Any) {
        DropDownSelection = "SelectStreetRoad"
        self.DropUp(list: self.StreetList, view: viewStreetRoad, textField: txtStreetRoad)
    }
  
    @IBAction func SelectState(_ sender: Any) {
        DropDownSelection = "SelectState"
        self.DropUp(list: self.StateList, view: viewState, textField: txtState)
    }
    
    // MARK: - Edit Profile
    func Done () {
        self.view.endEditing(true)
        var parameter = NSString()
//        var CheckValu = Bool()
//        CheckValu = true
        parameter = ""
        if self.form[0].strSelectedValue == ""{
            self.ShowAlertMessage(title: "", message: "Please wirite first name" as String, buttonText: "OK")
        }else
        if self.form[1].strSelectedValue == ""{
            self.ShowAlertMessage(title: "", message: "Please wirite last name" as String, buttonText: "OK")
        }else
        if !GlobalMethods().isValidEmail(testStr: self.form[2].strSelectedValue as String) && self.form[2].strSelectedValue != ""{
            self.ShowAlertMessage(title: "", message: "Please write proper email" as String, buttonText: "OK")
        }else{
            parameter = parameter.appending("&user_id=").appending(userList[0].User_Id) as NSString
           parameter = parameter.appending("&user_type=").appending(self.userList[0].User_Type) as NSString
            for  i in 0..<self.form.count{
                if self.form[i].strSelectedValue != ""{
                    parameter = parameter.appending(self.form[i].strParameter as String).appending(self.form[i].strSelectedValue as String) as NSString
                    print(parameter)
                }
            }
            DispatchQueue.main.async {
                AllMethods().EditUser(with: parameter as String, completion: { (Message) in
                    print("Responce Message Edit User = \(Message)")
                    self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
                    if "User has been updated successfully." == Message {
                        if Message == "User has been updated successfully."{
                            appDelegate.USERNAME = self.txtFirstName.text!.appending(self.txtLastName.text!) as NSString
                        }
                        self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
                        let image =  #imageLiteral(resourceName: "CallEdit")
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(Profile.EditProfile(_:)))
                        self.isView = true
                        self.table.reloadData()
                        self.HideShowImage(status: false)
                    }else{
                        self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
                    }
                })
            }
        }
//        if txtFirstName.text == ""{
//            self.ShowAlertMessage(title: "", message: "Please wirite first name" as String, buttonText: "OK")
//        }else
//        if txtLastName.text == ""{
//            self.ShowAlertMessage(title: "", message: "Please wirite last name" as String, buttonText: "OK")
//        }else
//        if txtEmail.text == ""{
//             self.ShowAlertMessage(title: "", message: "Please wirite Email" as String, buttonText: "OK")
//        }else{
//            parameter = parameter.appending("&user_id=").appending(userList[0].User_Id) as NSString
//              parameter = parameter.appending("&user_type=").appending(self.userList[0].User_Type).appending("&user_fname=").appending(txtFirstName.text!).appending("&user_lname=").appending(txtLastName.text!).appending("&user_email=").appending(txtEmail.text!) as NSString
//           
//            if txtMobileNo.text != ""{
//                parameter = parameter.appending("&user_phone_no=").appending(txtMobileNo.text!) as NSString
//            }
//            if txtOfficeNo.text != ""{
//                parameter = parameter.appending("&user_office_no=").appending(txtOfficeNo.text!) as NSString
//            }
//            if txtStreetNo.text != ""{
//                parameter = parameter.appending("&user_street_no=").appending(txtStreetNo.text!) as NSString
//            }
//            if txtStreetName.text != ""{
//                parameter = parameter.appending("&user_street_name=").appending(txtStreetName.text!) as NSString
//            }
//            if StreetId != "0000"{
//                parameter = parameter.appending("&user_street_road_id=").appending(StreetId as String) as NSString
//            }
//            if StateId != "0000"{
//                parameter = parameter.appending("&user_state_id=").appending(StateId as String) as NSString
//            }
//            if CityId != "0000"{
//                parameter = parameter.appending("&user_city_id=").appending(CityId as String) as NSString
//            }
//            if txtZipCode.text != ""{
//                parameter = parameter.appending("&user_zip_code=").appending(txtZipCode.text!) as NSString
//            }
//            DispatchQueue.main.async {
//                AllMethods().EditUser(with: parameter as String, completion: { (Message) in
//                    print("Responce Message Edit User = \(Message)")
//                      self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
//                    if "User has been updated successfully." == Message {
//                        if Message == "User has been updated successfully."{
//                            appDelegate.USERNAME = self.txtFirstName.text!.appending(self.txtLastName.text!) as NSString
//                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                            let destinationController = UIViewController()
//                            let frontNavigationController = UINavigationController(rootViewController: destinationController)
//                            let rearViewController = storyboard.instantiateViewController(withIdentifier: "MenuView") as? MenuView
//                            let mainRevealController = SWRevealViewController()
//                            mainRevealController.rearViewController = rearViewController
//                            mainRevealController.frontViewController = frontNavigationController
////                            appDelegate.window!.rootViewController = mainRevealController
//                        }
//                          self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
//                        let image =  #imageLiteral(resourceName: "CallEdit")
//                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(Profile.EditProfile(_:)))
//                        self.HideShowImage(status: false)
//                        
//                    }else{
//                        self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
//                        
//                        
//                    }
//                })
//            }
//            print("Done")
//        }
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
        }
    }
    
    // MARK: - UDF
    
    func GetStreet() {
        var parameters = NSString()
        // parameters = "token="
        parameters = ("token=").appending(appDelegate.TOKEN as String) as NSString
        AllMethods().StreetCityStateDetail(with: parameters as String,API: LoginApi.Web_StreetDetail as String, completion: { (ProviderList) in
            self.StreetList = [DropDownListData]()
            let cmd = DropDownListData(Drp_Id:"0000",
                                       Drp_StateId: "0000",
                                       Drp_Name: "Select Street"
            )
            self.StreetList.append(cmd)
            DispatchQueue.main.async {
                self.StreetList.append(contentsOf:ProviderList)
                if self.stringStatus == "View User"{
                    for  i in 0..<ProviderList.count{
                        if self.userList[0].User_Street_Road_Id == ProviderList[i].Drp_Id{
                            self.form[7].strValue = ProviderList[i].Drp_Name! as NSString
                            self.form[7].strSelectedValue = ProviderList[i].Drp_StateId! as NSString
                            
                            let indexPath = NSIndexPath(row: 7, section: 1)
                            self.table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
                            
                            self.StreetId =  ProviderList[i].Drp_StateId as NSString
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
                    for  i in 0..<ProviderList.count{
                        if self.userList[0].User_State_Id as String == ProviderList[i].Drp_Id{
                            self.StateId =  ProviderList[i].Drp_Id as NSString
                            self.txtState.text = ProviderList[i].Drp_Name as String
                            
                            self.form[8].strValue = ProviderList[i].Drp_Name! as NSString
                            self.form[8].strSelectedValue = ProviderList[i].Drp_Id! as NSString
                            
                            let indexPath = NSIndexPath(row: 8, section: 1)
                            self.table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
                            
                            self.GetCity(stateId: self.StateId)
                        }
                    }
                }
            }
        })
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
                        if self.userList[0].User_City_Id as String == ProviderList[i].Drp_Id{
                            self.CityId =  ProviderList[i].Drp_Id as NSString
                            self.txtCity.text = ProviderList[i].Drp_Name as String
                            self.form[9].strValue = ProviderList[i].Drp_Name! as NSString
                            self.form[9].strSelectedValue = ProviderList[i].Drp_Id! as NSString
                            let indexPath = NSIndexPath(row: 9, section: 1)
                            self.table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
                            
                        }
                    }
                }
            }
        })
    }
    
    func GetUserDetail(){
        var parameter : String!
        parameter = "token="
        parameter = (parameter.appending(appDelegate.TOKEN as String) as NSString).appending("&user_id=").appending(appDelegate.USERID as String) as String
        print(parameter)
        AllMethods().UserListDetail(with: parameter as String, completion: { (dashboardData) in
            self.userList = dashboardData
            DispatchQueue.main.async {
                self.PrintData()
            }
        })
    }
    
    func PrintData() {
        HideShowImage(status: false)
        self.form[0].strValue = userList[0].User_Fname! as NSString
        self.form[1].strValue = userList[0].User_Lname! as NSString
        self.form[2].strValue = userList[0].User_Email! as NSString
        self.form[3].strValue = userList[0].User_Phone_No! as NSString
        self.form[4].strValue = userList[0].User_Office_No! as NSString
        self.form[5].strValue = userList[0].User_Street_No! as NSString
        self.form[6].strValue = userList[0].User_Street_Name! as NSString
        self.form[10].strValue = userList[0].User_Zip_Code! as NSString
        
        
        
        self.form[0].strSelectedValue = userList[0].User_Fname! as NSString
        self.form[1].strSelectedValue = userList[0].User_Lname! as NSString
        self.form[2].strSelectedValue = userList[0].User_Email! as NSString
        self.form[3].strSelectedValue = userList[0].User_Phone_No! as NSString
        self.form[4].strSelectedValue = userList[0].User_Office_No! as NSString
        self.form[5].strSelectedValue = userList[0].User_Street_No! as NSString
        self.form[6].strSelectedValue = userList[0].User_Street_Name! as NSString
        self.form[10].strSelectedValue = userList[0].User_Zip_Code! as NSString
        self.table.reloadData()
        
        txtFirstName.text = userList[0].User_Fname
        txtLastName.text = userList[0].User_Lname
        txtEmail.text = userList[0].User_Email
        txtMobileNo.text = userList[0].User_Phone_No
        txtOfficeNo.text = userList[0].User_Office_No
        txtStreetNo.text = userList[0].User_Street_No
        txtStreetName.text = userList[0].User_Street_Name
        txtZipCode.text = userList[0].User_Zip_Code
        if let url = NSURL(string: userList[0].User_Profile_Logo as String) {
            let data = NSData(contentsOf: url as URL)
//            imgUserProfile.layer.masksToBounds = true
//            imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.height/2
//            imgUserProfile.image = UIImage(data: data as! Data)
            //  }
        }
        DispatchQueue.main.async {
            self.GetStreet()
        }
        DispatchQueue.main.async {
            self.GetState()
        }
    }
    
//    func EditUserSubmit()  {
//        self.view.endEditing(true)
//        var parameter = NSString()
//        var CheckValu = Bool()
//        CheckValu = true
//        parameter = ""
//       
//        if txtFirstName.text == ""{
//            CheckValu = false
//        }
//        if txtLastName.text == ""{
//            CheckValu = false
//        }
//        if txtEmail.text == ""{
//            CheckValu = false
//        }
//        if CheckValu{
//            parameter = parameter.appending("&user_id=").appending(GetData[0].User_Id) as NSString
//            
//            parameter = parameter.appending("&user_type=").appending(UserTypeId as String).appending("&user_fname=").appending(txtFirstName.text!).appending("&user_lname=").appending(txtLastName.text!).appending("&user_email=").appending(txtEmail.text!).appending("&user_password=").appending(txtPassword.text!).appending("&confirm_password=").appending(txtConfirmPassword.text!) as NSString
//            if UserTypeId == "3" || UserTypeId == "5" {
//                parameter = parameter.appending("&user_provider_id=").appending(ProviderId as String) as NSString
//            }
//            parameter = parameter.appending("&user_phone_no=").appending(txtMobileNo.text!) as NSString
//            parameter = parameter.appending("&user_office_no=").appending(txtOfficeNo.text!) as NSString
//            parameter = parameter.appending("&user_street_no=").appending(txtStreetNo.text!) as NSString
//            parameter = parameter.appending("&user_street_name=").appending(txtStreetName.text!) as NSString
//            parameter = parameter.appending("&user_street_road_id=").appending(StreetId as String) as NSString
//            parameter = parameter.appending("&user_state_id=").appending(StateId as String) as NSString
//            parameter = parameter.appending("&user_city_id=").appending(CityId as String) as NSString
//            parameter = parameter.appending("&user_zip_code=").appending(txtZipCode.text!) as NSString
//            DispatchQueue.main.async {
//                AllMethods().EditUser(with: parameter as String, completion: { (Message) in
//                    print("Responce Message Edit User = \(Message)")
//                    if "User has been updated successfully." == Message {
//                        self.GoBack()
//                    }else{
//                        self.ShowAlertMessage(title: "", message: Message as String, buttonText: "OK")
//                    }
//                })
//            }
//        }else{
//            self.ShowAlertMessage(title: "", message: "please fill requieds field" as String, buttonText: "OK")
//            print("please fill requieds field")
//        }
//    }
    

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
    
    func HideShowImage(status : Bool) {
  
        imgFirstName.isHidden = status
        imgLastName.isHidden = status
        imgEmail.isHidden = status
        imgMobileNo.isHidden = status
        imgOfficeNo.isHidden = status
        imgStreetNo.isHidden = status
        imgStreetName.isHidden = status
        imgStreetRoad.isHidden = status
        imgState.isHidden = status
        imgCity.isHidden = status
        imgZipCode.isHidden = status
        
        txtFirstName.isUserInteractionEnabled = status
        txtLastName.isUserInteractionEnabled = status
        txtEmail.isUserInteractionEnabled = status
        txtMobileNo.isUserInteractionEnabled = status
        txtOfficeNo.isUserInteractionEnabled = status
        txtStreetNo.isUserInteractionEnabled = status
        txtStreetName.isUserInteractionEnabled = status
        txtStreetRoad.isUserInteractionEnabled = status
        txtState.isUserInteractionEnabled = status
        txtCity.isUserInteractionEnabled = status
        txtZipCode.isUserInteractionEnabled = status
        
        btnCity.isHidden = !status
        btnState.isHidden = !status
        btnStreetRoad.isHidden = !status
        
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
        // Dispose of any resources that can be recreated.
    }
}

extension Profile : UITableViewDataSource,UITableViewDelegate{
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 2;
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }else{
            return form.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell:FormCell = tableView.dequeueReusableCell(withIdentifier: "cel") as UITableViewCell! as! FormCell
            cell.imgDrop.image = #imageLiteral(resourceName: "user_Avtar")
            return cell
        }else{
            let cell:FormCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! FormCell
            let printData = form[indexPath.row]
        
            cell.title.text = printData.strTitle as String
            cell.txtField.placeholder = printData.strPlaceHolder as String
            cell.txtField.text = printData.strValue as String
            cell.txtField.tag = printData.rowNumber
            cell.imgDrop.image = printData.imgDropdown
            cell.btnDrop.tag = printData.rowNumber
            cell.txtField.inputAccessoryView = keyboardToolbar
            cell.txtField.isUserInteractionEnabled = !isView
            cell.btnDrop.isUserInteractionEnabled = !isView
            
            if isView{
                print("INSAID")
                cell.txtField.setBorderPadding()
            }else{
                print("INSAID OUT")
                cell.txtField.removeBorderPadding()
            }
            if !printData.isButton{
                cell.imgDrop.isHidden = true
                cell.btnDrop.isHidden = true
            }else{
                cell.imgDrop.isHidden = false
                cell.btnDrop.isHidden = false
            }
            if appDelegate.USERTYPE == appDelegate.STAFF{
                if indexPath.row == 3{
                    cell.txtField.setBorderPadding()
                    cell.imgDrop.isHidden = true
                        cell.btnDrop.isHidden = true
                    cell.txtField.isUserInteractionEnabled = false
                }
            }
            return cell
        }
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{

        return indexPath
    }
}

extension Profile : UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        self.form[textField.tag].strValue = txtAfterUpdate as NSString
        self.form[textField.tag].strSelectedValue = txtAfterUpdate as NSString
        
        return true
        
    }

    func textFieldDidChange(_ textField: UITextField) {
        print(textField.text! as String)
    }

}
extension Profile : CZPickerViewDelegate,CZPickerViewDataSource {
    
    public func numberOfRows(in pickerView: CZPickerView!) -> Int{
        if DropDownSelection == "SelectCity"{
            return self.CityList.count
        }else
        if DropDownSelection == "SelectStreetRoad"{
            return self.StreetList.count
        }else{
                //        if DropDownSelection == "SelectState"{
                return self.StateList.count
        }
        
//        if DropDownSelection == "SelectProvider"{
//            return self.DropDownProviderList.count
//        }else{
//            return self.DropDownUserList.count
//        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        
        if DropDownSelection == "SelectCity"{
            return self.CityList[row].Drp_Name
        }else
            if DropDownSelection == "SelectStreetRoad"{
                return self.StreetList[row].Drp_Name
            }else{
                //        if DropDownSelection == "SelectState"{
                return self.StateList[row].Drp_Name
        }
        
//        if DropDownSelection == "SelectProvider"{
//            return self.DropDownProviderList[row].Drp_Name
//        }
//        else{
//            return self.DropDownUserList[row].Drp_Name
//        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        if DropDownSelection == "SelectStreetRoad"{
            self.form[7].strValue = self.StreetList[row].Drp_Name! as NSString
            self.form[7].strSelectedValue = self.StreetList[row].Drp_Id as NSString
            
            let indexPath = NSIndexPath(row: 7, section: 1)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            
            self.txtStreetRoad.text = self.StreetList[row].Drp_Name
            self.StreetId = self.StreetList[row].Drp_Id as NSString
        }else if DropDownSelection == "SelectState"{
            self.form[8].strValue = self.StateList[row].Drp_Name! as NSString
            self.form[8].strSelectedValue = self.StateList[row].Drp_Id as NSString
            
            let indexPath = NSIndexPath(row: 8, section: 1)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            
            txtState.text = self.StateList[row].Drp_Name
            StateId = self.StreetList[row].Drp_Id as NSString
            self.GetCity(stateId: StateId)
        }else if DropDownSelection == "SelectCity"{
            self.form[9].strValue = self.CityList[row].Drp_Name! as NSString
            self.form[9].strSelectedValue = self.CityList[row].Drp_Id as NSString
            
            let indexPath = NSIndexPath(row: 9, section: 1)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            
            txtCity.text = self.CityList[row].Drp_Name
            CityId = self.CityList[row].Drp_Id as NSString
        }

        
        if DropDownSelection == "SelectCity"{
        
        }
        if DropDownSelection == "SelectStreetRoad"{
        
        }
        if DropDownSelection == "SelectState"{
        
        }
//        
//        if DropDownSelection == "SelectProvider"{
//            self.form[3].strValue = self.DropDownProviderList[row].Drp_Name! as NSString
//            self.form[3].strSelectedValue = self.DropDownProviderList[row].Drp_Id as NSString
//            
//            let indexPath = NSIndexPath(row: 3, section: 0)
//            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
//            
//            self.form[4].strValue = ""
//            self.form[4].strSelectedValue = ""
//            let indexPath1 = NSIndexPath(row: 4, section: 0)
//            table.reloadRows(at: [indexPath1 as IndexPath], with: UITableViewRowAnimation.none)
//            UserId = ""
//            if row == 0{
//                ProiderId = ""
//            }else{
//                ProiderId = self.DropDownProviderList[row].Drp_Id as NSString
//            }
//            self.DropDownUserList = [DropDownListData]()
//            self.GetUserList()
//        }
//        else{
//            self.form[4].strValue = self.DropDownUserList[row].Drp_Name! as NSString
//            self.form[4].strSelectedValue = self.DropDownUserList[row].Drp_Id as NSString
//            let indexPath = NSIndexPath(row: 4, section: 0)
//            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
//            if row == 0{
//                UserId = ""
//            }else{
//                UserId = self.DropDownUserList[row].Drp_Id as NSString
//            }
//        }
    }
}

