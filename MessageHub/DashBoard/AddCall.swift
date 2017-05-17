//
//  AddCall.swift
//  MessageHub
//
//  Created by Hardik Davda on 2/7/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import CZPicker

class AddCall: UIViewController,UIScrollViewDelegate {
    // MARK: - TextField
    var picker: CZPickerView?
    @IBOutlet var table : UITableView!
     var form = [Forms]()
    // MARK: - Button
    @IBOutlet weak var btnEdit: UIBarButtonItem!
// MARK: - Lacal Declaration
    let keyboardToolbar = UIToolbar()
    var DropDownSelection = NSString()
    var ProiderId = NSString()
    var UserId = NSString()
    var isView = Bool()
    
    var ProvideList = [ProviderListData]()
    var UserList = [ResponsiblePersonListData]()
    
    var DropDownProviderList = [DropDownListData]()
    var DropDownUserList = [DropDownListData]()
    
    var stringStatus = ""
    var GetData = [CallDetailData]()
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        imgDicebleCustomer.isHidden = true
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white;
       
        isView = false

        ProiderId = ""
        DropDownSelection = "Not Selected"
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
        addDoneButton()
        
        
        
        
  
        self.GetProviderList()
//        }
            //for (int i = 0; i<ProvideList.count; i++)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.title = "Add Call"
        DispatchQueue.main.async {
            CustomForm().CreateAddCall(completion: { (demo) in
                DispatchQueue.main.async {
                    self.form = demo
                     if self.stringStatus == "View Call"{
                         self.isView = true
                        self.form[0].strValue = self.GetData[0].CD_From! as NSString
                        self.form[1].strValue = self.GetData[0].CD_Phone_number! as  NSString
                        self.form[2].strValue = self.GetData[0].CD_Email! as NSString
                        self.ProiderId = self.GetData[0].CD_Provider_Id as NSString
                        self.form[4].strValue = self.GetData[0].Responsible_Person! as NSString
                        self.UserId = self.GetData[0].CD_User_Id! as NSString
                        self.form[5].strValue =  self.GetData[0].CD_Reason_For_Call! as NSString
                        
                        self.form[0].strSelectedValue = self.GetData[0].CD_From! as NSString
                        self.form[1].strSelectedValue = self.GetData[0].CD_Phone_number! as  NSString
                        self.form[2].strSelectedValue = self.GetData[0].CD_Email! as NSString
                        self.form[3].strSelectedValue = self.GetData[0].CD_Provider_Id as NSString
                        self.form[4].strSelectedValue = self.GetData[0].CD_User_Id! as NSString
                        self.form[5].strSelectedValue =  self.GetData[0].CD_Reason_For_Call! as NSString
                    }
                    
                    self.table.reloadData()
                }
            })
        }
        
        if appDelegate.USERTYPE == appDelegate.STAFF{
            ProiderId = appDelegate.USERPROVIDERID
            self.GetUserList()
        }
        
        if stringStatus == "View Call"{
            isView = true
            let image =  #imageLiteral(resourceName: "CallEdit")
            self.title = "Edit Call"
//            image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddCall.EditCall(_:)))
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        }
        else{
            isView = false
            let image =  #imageLiteral(resourceName: "Save(Done)")
            self.title = "Add Call"

            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action:  #selector(AddCall.SubmitCall))
            self.navigationController?.navigationBar.tintColor = UIColor.white;
            
            self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
 
        }
        
    }
    // MARK: - Keyboard Hide Show

        func keyboardWillShow(notification: NSNotification) {
            let info = notification.userInfo!
            let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
//                print("Keyboar will appear\(keyboardFrame.size.height)")
                //self.scroll.constraints = keyboardFrame.size.height + 20
            })
            
    }
    func keyboardWillHide(notification: NSNotification) {
//        print("keyboarhide")
    }
    

    // MARK: - Button Events

    @IBAction func Back(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil);

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SelectDropDown(_ sender: Any) {
        let button = sender
        self.view.endEditing(true)
        if (button as AnyObject).tag==3{
            if DropDownProviderList.count != 0{
                DropDownSelection = "SelectProvider"
                DropDownSelection = "SelectProvider"
                picker = CZPickerView(headerTitle: "Customer", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
                picker?.delegate = self
                picker?.dataSource = self as CZPickerViewDataSource
                picker?.needFooterView = true
                picker?.cancelButtonBackgroundColor = UIColor().textFieldBackgroundColor()
                picker?.headerBackgroundColor = UIColor().tintColor()
                picker?.confirmButtonBackgroundColor = UIColor().tintColor()
                picker?.show()
            }
        }else{
            if DropDownUserList.count != 0{
                DropDownSelection = "SelectUserName"
                picker = CZPickerView(headerTitle: "Responsible Person", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
                picker?.delegate = self
                picker?.dataSource = self as CZPickerViewDataSource
                picker?.needFooterView = true
                picker?.cancelButtonBackgroundColor = UIColor().textFieldBackgroundColor()
                picker?.headerBackgroundColor = UIColor().tintColor()
                picker?.confirmButtonBackgroundColor = UIColor().tintColor()
                picker?.show()
            }
        }
        
    }
    
    @IBAction func EditCall(_ sender: Any) {
       self.title = "Edit Call"
        isView = false
        let image =  #imageLiteral(resourceName: "Save(Done)")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action:  #selector(AddCall.SubmitCall))
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        self.navigationItem.rightBarButtonItem!.tintColor = UIColor.white
        table.reloadData()
    }
    func SubmitCall(){
        if self.form[0].strSelectedValue == ""{
            showAlertMessage(title: "Alert", message: "Required from")
        }else if self.form[1].strSelectedValue == ""{
            showAlertMessage(title: "Alert", message: "Required Phone Number")
        }else if ProiderId == ""{
            showAlertMessage(title: "Alert", message: "Select Customer")
        }else if UserId == ""{
            showAlertMessage(title: "Alert", message: "Select Responsible Person")
        }else if self.form[5].strSelectedValue == ""{
            showAlertMessage(title: "Alert", message: "Write reason for call")
        }else if !GlobalMethods().isValidEmail(testStr: self.form[2].strSelectedValue as String) && self.form[2].strSelectedValue != ""{
            showAlertMessage(title: "Alert", message: "Please write proper email")
        }else{
            var parameter : NSString = NSString()
            if stringStatus == "View Call"{
                parameter = parameter.appending("&cd_id=") as String as NSString
                parameter = parameter.appending(GetData[0].CD_Id) as NSString
            }
            for  i in 0..<self.form.count{
                if self.form[i].strSelectedValue != ""{
                    parameter = parameter.appending(self.form[i].strParameter as String).appending(self.form[i].strSelectedValue as String) as NSString
                    print(parameter)
                }
            }
            if stringStatus == "View Call"{
                DispatchQueue.main.async {
                    AllMethods().EditCall(with: parameter as String, completion: { (Message) in
                        print("Responce Message Updated data  = \(Message)")
                        if "Call details has been updated successfully." == Message{
                            self.navigationController?.popViewController(animated: true)
                            self.Cancel(send)
                        }
                    })
                }
            }
            else{
                DispatchQueue.main.async {
                    AllMethods().AddCall(with: parameter as String, completion: { (Message) in
                        self.showAlertMessage(title: "Alert", message: Message)
                        print("Responce Message = \(Message)")
                    })
                }
            }
        }
      }
    @IBAction func Cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - UDF
    
    func EditCallData() {
    
    }
    
    func GetProviderList()  {
//        var parameter : NSString
//        parameter = "&display_abbr=true"
//        
        AllMethods().providerList(with: "", completion: { (ProviderList) in
            self.ProvideList = [ProviderListData]()
            
            self.ProvideList = ProviderList
            DispatchQueue.main.async {
                for  i in 0..<self.ProvideList.count{
//
                    var cmd = DropDownListData()
                    cmd.Drp_Id = self.ProvideList[i].PRV_Id as String
                    cmd.Drp_Name = self.ProvideList[i].PRV_Name as String
                    if appDelegate.USERTYPE == appDelegate.STAFF{
                        if cmd.Drp_Id == appDelegate.USERPROVIDERID as String{
                            self.form[3].strValue = cmd.Drp_Name as NSString
                            self.form[3].strSelectedValue = cmd.Drp_Id! as NSString
                            let indexPath = NSIndexPath(row: 3, section: 0)
                            self.table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
                        }
                    }else{
                        self.DropDownProviderList.append(cmd)
                    }
                    if self.stringStatus == "View Call"{
                        if cmd.Drp_Id == self.GetData[0].CD_Provider_Id{
                            self.form[3].strValue = cmd.Drp_Name as NSString
                            self.form[3].strSelectedValue = cmd.Drp_Id! as NSString
                            let indexPath = NSIndexPath(row: 3, section: 0)
                            self.table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
                            self.ProiderId = cmd.Drp_Id as NSString
                        }
                    }
                }
            }
            if appDelegate.USERTYPE != appDelegate.STAFF{
            if self.stringStatus == "View Call"{
                self.GetUserList()
            }
            }
        })
    }
    
    func GetUserList()  {
        self.DropDownUserList = [DropDownListData]()
        if ProiderId != "" && ProiderId != "00" {
            var parameter = NSString()
            
            parameter = parameter.appending("&provider_id=") as NSString
            parameter = parameter.appending(ProiderId as String) as NSString
            
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
                        if self.stringStatus == "View Call"{
                            if cmd.Drp_Name == self.GetData[0].Responsible_Person{
                                self.UserId = cmd.Drp_Id as NSString
                            }
                        }
                    }
                }
            })
        }
    }
    
    func showAlertMessage(title : NSString,message : NSString) {
        let alert = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - TextField Delegate
extension AddCall : UITextFieldDelegate{
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
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
//        print("Text Return data\(textField.tag)")
//        let indexPath = NSIndexPath(row: textField.tag, section: 0)
        //        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        DispatchQueue.main.async {
            //lblLineFrom.backgroundColor =
//            self.lblLineFrom.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLinePhoneNumber.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineEmail.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineProvider.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineUserName.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            self.lblLineResonForCall.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
        }
//        if textField.tag == 1{
//            DispatchQueue.main.async {
//                self.lblLineFrom.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
//            }
//        }else  if textField.tag == 2{
//            DispatchQueue.main.async {
//                self.lblLinePhoneNumber.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
//            }
//        }else if textField.tag == 3{
//            DispatchQueue.main.async {
//                self.lblLineEmail.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
//            }
//        }else if textField.tag == 4{
//            DispatchQueue.main.async {
//                self.lblLineProvider.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
//            }
//        }else if textField.tag == 5{
//            DispatchQueue.main.async {
//                self.lblLineUserName.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
//            }
//        }else if textField.tag == 6{
//            DispatchQueue.main.async {
//                self.lblLineResonForCall.backgroundColor = UIColor().hexStringToUIColor(hex: "303F9F" )
//            }
//        }else{
//            DispatchQueue.main.async {
//                //lblLineFrom.backgroundColor =
//                self.lblLineFrom.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//                self.lblLinePhoneNumber.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//                self.lblLineEmail.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//                self.lblLineProvider.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//                self.lblLineUserName.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//                self.lblLineResonForCall.backgroundColor = UIColor().hexStringToUIColor(hex: "EFEFEF" )
//            }
//            
//        }
        print(textField.tag)
    }
}

// MARK: - TextView Delegate

extension AddCall : UITextViewDelegate{
    
    func textViewDidEndEditing(_ textView: UITextView) {
//        if self.txtResonForCall.text == ""{
//            self.txtResonForCall.text = "Reson for call"
//            self.txtResonForCall.textColor = UIColor.lightGray
//        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
//        if  txtResonForCall.textColor == UIColor.lightGray {
//            txtResonForCall.text = nil
//            txtResonForCall.textColor = UIColor.black
//        }
    }
}

// MARK: - TextPopUppicker Delegate Datasourse

extension AddCall: CZPickerViewDelegate,CZPickerViewDataSource {

    public func numberOfRows(in pickerView: CZPickerView!) -> Int{
        if DropDownSelection == "SelectProvider"{
            return self.DropDownProviderList.count
        }else{
            return self.DropDownUserList.count
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        if DropDownSelection == "SelectProvider"{
            return self.DropDownProviderList[row].Drp_Name
        }
        else{
            return self.DropDownUserList[row].Drp_Name
        }
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        if DropDownSelection == "SelectProvider"{
            self.form[3].strValue = self.DropDownProviderList[row].Drp_Name! as NSString
            self.form[3].strSelectedValue = self.DropDownProviderList[row].Drp_Id as NSString
            
            let indexPath = NSIndexPath(row: 3, section: 0)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            
            self.form[4].strValue = ""
            self.form[4].strSelectedValue = ""
            let indexPath1 = NSIndexPath(row: 4, section: 0)
            table.reloadRows(at: [indexPath1 as IndexPath], with: UITableViewRowAnimation.none)
            UserId = ""
            if row == 0{
                ProiderId = ""
            }else{
                ProiderId = self.DropDownProviderList[row].Drp_Id as NSString
            }
            self.DropDownUserList = [DropDownListData]()
            self.GetUserList()
        }
        else{
            self.form[4].strValue = self.DropDownUserList[row].Drp_Name! as NSString
            self.form[4].strSelectedValue = self.DropDownUserList[row].Drp_Id as NSString
            let indexPath = NSIndexPath(row: 4, section: 0)
            table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
            if row == 0{
                UserId = ""
            }else{
                UserId = self.DropDownUserList[row].Drp_Id as NSString
            }
        }
    }
}

// MARK: - TableView Delegate

extension AddCall : UITableViewDataSource,UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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



