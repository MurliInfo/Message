//
//  ViewNotes.swift
//  MessageHub
//
//  Created by Hardik Davda on 3/22/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class ViewNotes: UIViewController,CloseDropDownDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    // MARK: - StoryBoard Declaration
    
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var viewAll: UIView!
    @IBOutlet var viewDetail: UIView!
    @IBOutlet var lblFrom: UILabel!
    @IBOutlet var lblPhoneNumber: UILabel!
    @IBOutlet var lblProvider: UILabel!
    @IBOutlet var lblReasonForCall: UILabel!
    @IBOutlet var lblAssignTo: UnderlinedLabel!
    @IBOutlet var btnAssignTo: UIButton!
    
    @IBOutlet var viewCC: UIView!
    @IBOutlet var viewCCPrint: UIView!

    @IBOutlet var lblAddCC: UILabel!
    
    @IBOutlet var ViewButton: UIView!
    @IBOutlet var btnExternal: UIButton!
    @IBOutlet var btnInternal: UIButton!
    @IBOutlet var imgExternal: UIImageView!
    @IBOutlet var imgInternal: UIImageView!
   
    @IBOutlet var txtEmail: UITextField!
    
    @IBOutlet var viewNotes: UIView!
    @IBOutlet var viewAddCC: UIView!
    @IBOutlet var txtNotes: UITextView!
    @IBOutlet var lblPlaceholder: UILabel!
    @IBOutlet var lblWronEmail: UILabel!
    @IBOutlet var lblWronLine: UILabel!
@IBOutlet var lblExternal: UILabel!
    
    @IBOutlet var viewHistory: UIView!
    @IBOutlet var Table: UITableView!
    @IBOutlet var collectionCC: UICollectionView!

    var imagePicker = UIImagePickerController()

    // MARK: - Local Declaration
    var dropdown = PopView()
    var viewDemo  = UIView()
    var viewMacro = UIView()
    var lblMacroTitle = UILabel()
    var btnMacroTitle = UIButton()
    
    var DropDownView : UIView = UIView()
    var timer: Timer!

    var DropDownSelection = String()
    var notesType = String()
    var Status = String()
    var DashboardData = [CallDetailData]()
    var HistoryList = [GetNote]()
    var MacroList = [Macro]()
    
    var DropDownUserList = [DropDownListData]()
    var DropDownMacroList = [DropDownListData]()
    var UserList = [ResponsiblePersonListData]()
    var FileList = [DropDownListData]()
    var CCList = [GetCC]()

    // var demo = RHWebService()
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        viewAddCC.isHidden = true
        self.addDoneButton()
        self.manageView()
        navigationController?.navigationBar.barTintColor = UIColor().tintColor()
        notesType = "0"
        self.Table.estimatedRowHeight = 80
        self.Table.rowHeight = UITableViewAutomaticDimension
        
        self.txtNotes.text = "Write notes"
        self.txtNotes.textColor = UIColor.lightGray
        
        self.Table.setNeedsLayout()
        self.Table.layoutIfNeeded()
        
        self.Table.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        collectionCC.delegate = self
        collectionCC.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        //  let width = UIScreen.main.bounds.width
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        //  layout.itemSize = CGSize(width: width / 2, height: width / 2)
            layout.minimumInteritemSpacing = 10
        
            layout.minimumLineSpacing = 10
            self.collectionCC.collectionViewLayout = layout
        DispatchQueue.main.async {
            self.printData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.CheckButton()
        DispatchQueue.main.async {
            self.Notes(noteType: "3", noteDescription: "Opened an Message.")
        }
//        demo.postImage(toURL: "", withMethod: "", andParams: "", andImage: "", noteId: "", eventId: "", completion: "")
        DispatchQueue.main.async {
             self.GetUserList()
        }

        DispatchQueue.main.async {
            self.getHistory()
        }
        DispatchQueue.main.async {
            self.getMacro()
        }
        DispatchQueue.main.async {
            self.getCC()
        }
    //        self.manageView()
    }
    
    func CheckButton()  {
        if DashboardData[0].CD_Email == ""{
            btnExternal.isHidden = true
            imgExternal.isHidden = true
            lblExternal.isHidden = true
            
        }else{
            btnExternal.isHidden = false
            imgExternal.isHidden = false
            lblExternal.isHidden = false
        }
        //        CD_Email
    }
    // MARK: - Button Events (Click Methods)
    func Notes(noteType : String, noteDescription : String){
        let parameter = "&nt_call_id=".appending(DashboardData[0].CD_Id).appending("&nt_type=").appending(noteType).appending("&nt_desc=").appending(noteDescription) as String
        
        DispatchQueue.main.async {
            AllMethods().AddNotes(with: parameter , API: LoginApi.Web_AddNote as String, completion: {(Response) in
                if noteType == "3" || noteType == "4"{
                    self.getHistory()
                }else{
                        print("Response \(Response)")
                    self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
                    self.txtNotes.text = ""
                    self.getHistory()
                }//self.getCC()
                //self.view.endEditing(true)
                //self.viewAddCC.isHidden = true
            })
        }
        
    }
    
    @IBAction func SelectExternalNotes(_ sender: Any) {
        notesType = "1"
        imgExternal.image =  #imageLiteral(resourceName: "ExternalSelected")
        imgInternal.image = #imageLiteral(resourceName: "Internal")
    }
    
    @IBAction func SelectInternalNotes(_ sender: Any) {
        notesType = "0"
        imgExternal.image =  #imageLiteral(resourceName: "External")
        imgInternal.image = #imageLiteral(resourceName: "InternalSelected")
    }
    
    @IBAction func SelectAssignTo(_ sender: Any) {
        self.view.endEditing(true)
        if !self.DropDownView.isDescendant(of: self.viewAll){
            if self.DropDownUserList.count > 0 {
                DropDownSelection = "SelectAssignTo"
                let frame = CGRect(x: lblAssignTo.frame.origin.x, y: scroll.frame.origin.y+lblAssignTo.frame.origin.y+lblAssignTo.frame.height+20, width: lblAssignTo.frame.width+5, height: 400)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Demo",List: self.DropDownUserList)
                self.viewAll.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }else{
            self.DropDownView.removeFromSuperview()
        }
    }

    @IBAction func AddCC(_ sender: Any) {
        viewAddCC.isHidden = false
         lblWronEmail.text = ""
        lblWronLine.backgroundColor = .blue

    }
    @IBAction func SubmitAddCC(_ sender: Any) {
        print(GlobalMethods().isValidEmail(testStr: txtEmail.text!))
        if GlobalMethods().isValidEmail(testStr: txtEmail.text!){
            let parameter = "&call_id=".appending(DashboardData[0].CD_Id).appending("&cc_address=").appending(txtEmail.text!) as String
            
            DispatchQueue.main.async {
                AllMethods().AddCCList(with: parameter , API: LoginApi.Web_AddCC as String, completion: {(Response) in
                    self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
                    self.getCC()
                    self.view.endEditing(true)
                    self.viewAddCC.isHidden = true
                })
            }
//         call_id
//        cc_address
            lblWronEmail.text = ""
            lblWronLine.backgroundColor = .blue
        }else{
            lblWronEmail.text = "Please enter valid address"
            lblWronLine.backgroundColor = .red

        }
    }

    @IBAction func CancelCC(_ sender: Any) {
        viewAddCC.isHidden = true
        txtEmail.text = ""
        lblWronEmail.text = ""
        lblWronLine.backgroundColor = .blue
        self.view.endEditing(true)

    }
   
    @IBAction func RemoveCC(_ sender: Any) {
        let btn = sender
        print(CCList[(btn as AnyObject).tag].CC_Id)
        
        let parameter = "&cc_id=".appending(CCList[(btn as AnyObject).tag].CC_Id)
        //        print("Parameter = :\(parameter)")
      //  let APICC = LoginApi.Web_RemoveCC as String
        
        DispatchQueue.main.async {
            AllMethods().RemoveCCList(with: parameter , API: LoginApi.Web_RemoveCC as String, completion: {(Response) in
                self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
                self.getCC()
            })
//            AllMethods().RemoveCCList(with: parameter, API: APICC, completion: {(ListData) in
//                self.CCList = [GetCC]()
//                self.CCList = ListData
//                print(self.CCList)
//                self.collectionCC.reloadData()
//                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.manageView), userInfo: nil, repeats: false)
//            })
        }
    }
    
    @IBAction func UploadFiles(_ sender: Any) {
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
        print(info)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print("Something went wrong")
            print(image.description)

//            imgUserProfile.image = image
//            imgUserProfile.layer.masksToBounds = true
//            imgUserProfile.layer.cornerRadius = imgUserProfile.frame.size.height/2;
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
   //     imgUserProfile.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("picker cancel.")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func ApplyMacros(_ sender: Any) {
      self.popupView(list: self.DropDownMacroList,titleName: "Apply Macros")
        self.view.endEditing(true)
        if !self.DropDownView.isDescendant(of: self.view){
            if self.DropDownMacroList.count > 0 {
                
                DropDownSelection = "Macro"
                let frame = CGRect(x: 15 , y: 50, width: self.viewMacro.frame.size.width-30, height: self.viewMacro.frame.size.height-50)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Macro",List: self.DropDownMacroList)
                self.viewMacro.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }else{
            self.DropDownView.removeFromSuperview()
        }
        self.view.addSubview(viewDemo)
    }
    func clickMe(sender:UIButton!)
    {
        viewDemo.removeFromSuperview()
    }
    
    @IBAction func PostNotes(_ sender: Any) {
       // if notesType = "Internal"
        if !txtNotes.text.trimmingCharacters(in: .whitespaces).isEmpty {
            self.Notes(noteType: notesType, noteDescription: txtNotes.text)
        }else{
            self.ShowAlertMessage(title: "", message: "Please write text ", buttonText: "OK")
        }
    }
    
    @IBAction func FileList(_ sender: Any) {
        let btn = sender
        var cmd1 = GetNote()
        cmd1 = self.HistoryList[(btn as AnyObject).tag]
        self.FileList = [DropDownListData]()
        
        print("Print List file \(cmd1.Notes_Files)")
        for  i in 0..<cmd1.Notes_Files.count{
            var cmd = DropDownListData()
            cmd.Drp_Id = "000"
            cmd.Drp_StateId =  cmd1.Notes_Files[i] as! String
            let theFileName = (cmd1.Notes_Files[i] as! NSString).lastPathComponent

            cmd.Drp_Name = theFileName//cmd1.Notes_Files[i] as! String
            self.FileList.append(cmd)
        }
        
        self.popupView(list: self.FileList, titleName: "File List")
        
        self.view.endEditing(true)
        if !self.DropDownView.isDescendant(of: self.view){
            if self.FileList.count > 0 {
                
                DropDownSelection = "FileList"
                let frame = CGRect(x: 0 , y: 50, width: self.viewMacro.frame.size.width, height: self.viewMacro.frame.size.height-50)
                dropdown.delegate = self
                dropdown.removeFromSuperview()
                DropDownView = dropdown.animationController(frame: frame,whereTo : "Macro",List: self.FileList)
                self.viewMacro.addSubview(DropDownView)
                dropdown.delegate = self
            }
        }else{
            self.DropDownView.removeFromSuperview()
        }
        self.view.addSubview(viewDemo)
    }
    
    // MARK: - Dropdown Delagete

    func SelectedValue(time:NSInteger){
        if DropDownSelection == "Macro"{
            print(self.DropDownMacroList[time].Drp_StateId)
         //  let FullName = ("<font face='Helvetica'color='#000' size='4.5'><b>").appending(self.DropDownMacroList[time].Drp_Name)
            let attrStr = try! NSAttributedString(
                data: self.DropDownMacroList[time].Drp_StateId.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ],
                documentAttributes: nil)
            txtNotes.attributedText = attrStr
            
            self.lblMacroTitle.removeFromSuperview()
            self.btnMacroTitle.removeFromSuperview()
            viewDemo.removeFromSuperview()
            dropdown.removeFromSuperview()
        }else if DropDownSelection == "SelectAssignTo"{
            lblAssignTo.text = DropDownUserList[time].Drp_Name
            if time != 0{
                let parameter = "&call_id=".appending(DashboardData[0].CD_Id).appending("&cd_user_id=").appending(DropDownUserList[time].Drp_Id ) as String
            
                DispatchQueue.main.async {
                    AllMethods().ChangeAssneeTo(with: parameter , API: LoginApi.Web_ChangeAssignee as String, completion: {(Response) in
                        self.ShowAlertMessage(title: "", message: Response as String, buttonText: "OK")
                     })
                }
            }
            dropdown.removeFromSuperview()

        }else if DropDownSelection == "FileList"{
            
            print(self.FileList[time].Drp_StateId)
           // self.download(url: self.FileList[time].Drp_StateId)
            self.lblMacroTitle.removeFromSuperview()
            self.btnMacroTitle.removeFromSuperview()
            viewDemo.removeFromSuperview()
            dropdown.removeFromSuperview()
        }
//        if DropDownUserList[time].Drp_Name == "Assign To"{
//        }else{
//        }
    }
    
//    func download(url : String){
//        var request = NSURLRequest(url: NSURL(string: "http://www.sa.is/media/1039/example.pdf") as! URL)
//        let session = AFHTTPSessionManager()
//        var progress: Progress?
//        var downloadTask = session.downloadTaskWithRequest(request, progress: &progress, destination: {(file, responce) in self.pathUrl},
//                                                           completionHandler:
//            {
//                response, localfile, error in
//                print("response \(response)")
//        })
//        downloadTask.resume()
//    }
    
    // MARK: - Local Methods
    func printData()  {
        lblFrom.text = DashboardData[0].CD_From
        lblPhoneNumber.text = DashboardData[0].CD_Phone_number
        lblProvider.text = DashboardData[0].PRV_Name
        lblReasonForCall.text = DashboardData[0].CD_Reason_For_Call
        lblAssignTo.text = DashboardData[0].Responsible_Person
    }
    
    func popupView(list : [DropDownListData],titleName : String) {
        var listCount : CGFloat = CGFloat()
           listCount = CGFloat(list.count)
        listCount = (listCount*44)+64
        var Y : CGFloat = CGFloat()
            Y = 15
        var H : CGFloat = CGFloat()
            H = self.view.frame.size.height-94
        let FullScreen = self.view.frame.size.height-30-64
        
        if FullScreen.isLess(than:CGFloat(listCount)){
            Y = 15
            H = self.view.frame.size.height-94
        }else{
            Y = ((self.view.frame.size.height-64)/2)-listCount/2
            H = listCount//self.view.frame.size.height-94
        }
        
        self.viewDemo.frame = CGRect(x: 0 , y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height)
        let viewTransferance = UIView(frame: CGRect(x: 0 , y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        viewTransferance.backgroundColor = UIColor().hexStringToUIColor(hex: "000000")
        viewTransferance.alpha = 0.4
        viewDemo.addSubview(viewTransferance)
        
        self.viewMacro.frame = CGRect(x: 15 , y: Y, width: self.view.frame.size.width-30, height: H)
         self.viewMacro.backgroundColor = UIColor().hexStringToUIColor(hex: "FFFFFF")
        viewDemo.addSubview(self.viewMacro)
        
        self.lblMacroTitle.frame = CGRect(x: 20, y: 15, width: self.view.frame.size.width-20, height: 21)
        lblMacroTitle.text = titleName
        viewMacro.addSubview(self.lblMacroTitle)
        
        self.btnMacroTitle.frame = CGRect(x: 20, y: 15, width: self.view.frame.size.width-20, height: 45)
        btnMacroTitle.addTarget(self, action:#selector(clickMe), for:.touchUpInside)
        viewMacro.addSubview(self.btnMacroTitle)
        
        let lblLine = UILabel(frame: CGRect(x: 0, y: 45, width: self.view.frame.size.width-30, height: 1))
        lblLine.backgroundColor = UIColor().hexStringToUIColor(hex: "F7F7F7")
        viewMacro.addSubview(lblLine)
        
    }
    func manageView()  {
        
        if Status == "Dashboard" {
//            self.UITableView_Auto_Height()
            if CCList.count != 0{
                viewCCPrint.isHidden = false
                btnAssignTo.isHidden = false
                var frameCC : CGRect = self.collectionCC.frame;
                frameCC.size.height = self.collectionCC.contentSize.height
                self.collectionCC.frame = frameCC
                
//                self.collectionView.contentSize.heigh
                
                frameCC = viewCCPrint.frame;
                frameCC.origin.y = viewCC.frame.origin.y+viewCC.frame.size.height
                frameCC.size.height = self.collectionCC.frame.size.height+16
                
                viewCCPrint.frame = frameCC
                
                frameCC = ViewButton.frame;
                frameCC.origin.y = viewCCPrint.frame.origin.y+viewCCPrint.frame.size.height+15
                ViewButton.frame = frameCC
                
                frameCC = viewNotes.frame;
                frameCC.origin.y = ViewButton.frame.origin.y+ViewButton.frame.size.height
                viewNotes.frame = frameCC
                
                self.Table.layoutIfNeeded()

                var frame: CGRect = self.Table.frame;
                frame.size.height = self.Table.contentSize.height;
                self.Table.frame = frame;
                
                self.Table.layoutIfNeeded()
                var frame1: CGRect = self.Table.frame;
                frame1.size.height = self.Table.contentSize.height;
                self.Table.frame = frame1;
                
                frameCC = viewHistory.frame;
                frameCC.origin.y = viewNotes.frame.origin.y+viewNotes.frame.size.height
                frameCC.size.height = 20+Table.frame.size.height
                viewHistory.frame = frameCC
                
                frameCC = viewAll.frame
                frameCC.size.height = viewHistory.frame.origin.y+viewHistory.frame.size.height+20
                viewAll.frame = frameCC
            }else{
                viewCCPrint.isHidden = true
                   self.Table.layoutIfNeeded()
                
                var frame: CGRect = self.Table.frame;
                frame.size.height = self.Table.contentSize.height;
                self.Table.frame = frame;
                
                self.Table.layoutIfNeeded()
                var frame1: CGRect = self.Table.frame;
                frame1.size.height = self.Table.contentSize.height;
                self.Table.frame = frame1;
                
                print(self.Table.contentSize.height)
                print(self.Table.frame.size.height)

                var Frame = viewHistory.frame
                //  Frame.origin.y = viewCC.frame.origin.y+viewCC.frame.size.height+20
                Frame.size.height = 20+Table.frame.size.height
                viewHistory.frame = Frame
            
                Frame = viewAll.frame
                Frame.size.height = viewHistory.frame.origin.y+viewHistory.frame.size.height+20
                viewAll.frame = Frame
            }
            self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.viewAll.frame.size.height-50)

        }else{
            self.UITableView_Auto_Height()
            ViewButton.isHidden = true
            viewNotes.isHidden = true
            btnAssignTo.isHidden = true
            if CCList.count != 0{
                
                viewCCPrint.isHidden = false
                btnAssignTo.isHidden = true
                var frameCC : CGRect = self.collectionCC.frame;
                frameCC.size.height = self.collectionCC.contentSize.height
                self.collectionCC.frame = frameCC
                
                //                self.collectionView.contentSize.heigh
                
                frameCC = viewCCPrint.frame;
                frameCC.origin.y = viewCC.frame.origin.y+viewCC.frame.size.height
                frameCC.size.height = self.collectionCC.frame.size.height+16
                
                viewCCPrint.frame = frameCC
                
//                frameCC = ViewButton.frame;
//                frameCC.origin.y = viewCCPrint.frame.origin.y+viewCCPrint.frame.size.height
//                ViewButton.frame = frameCC
//                
//                frameCC = viewNotes.frame;
//                frameCC.origin.y = ViewButton.frame.origin.y+ViewButton.frame.size.height
//                viewNotes.frame = frameCC
                
                self.Table.layoutIfNeeded()
                
                var frame: CGRect = self.Table.frame;
                frame.size.height = self.Table.contentSize.height;
                self.Table.frame = frame;
                
                self.Table.layoutIfNeeded()
                var frame1: CGRect = self.Table.frame;
                frame1.size.height = self.Table.contentSize.height;
                self.Table.frame = frame1;
                
                frameCC = viewHistory.frame;
                frameCC.origin.y = viewCCPrint.frame.origin.y+viewCCPrint.frame.size.height+15//viewNotes.frame.origin.y+viewNotes.frame.size.height
                frameCC.size.height = 20+Table.frame.size.height
                viewHistory.frame = frameCC
                
                frameCC = viewAll.frame
                frameCC.size.height = viewHistory.frame.origin.y+viewHistory.frame.size.height+20
                viewAll.frame = frameCC
                
                ///
                
//                viewCCPrint.isHidden = true
//                var frameCC : CGRect = viewCCPrint.frame;
//                frameCC.origin.y = viewCC.frame.origin.x+viewCC.frame.size.height
//                viewCCPrint.frame = frameCC
//                
////                frameCC = ViewButton.frame;
////                frameCC.origin.y = viewCCPrint.frame.origin.x+viewCCPrint.frame.size.height
////                ViewButton.frame = frameCC
////                
////                frameCC = viewNotes.frame;
////                frameCC.origin.y = ViewButton.frame.origin.x+ViewButton.frame.size.height
////                viewNotes.frame = frameCC
//                
//                self.Table.layoutIfNeeded()
//                var frame: CGRect = self.Table.frame;
//                frame.size.height = self.Table.contentSize.height;
//                self.Table.frame = frame;
//                
//                self.Table.layoutIfNeeded()
//                var frame1: CGRect = self.Table.frame;
//                frame1.size.height = self.Table.contentSize.height-200;
//                self.Table.frame = frame1;
//                
//                    print(self.Table.contentSize.height)
//                print(self.Table.frame.size.height)
//                frameCC = viewHistory.frame;
//                frameCC.origin.y = viewCCPrint.frame.origin.x+viewCCPrint.frame.size.height+20
//                frameCC.size.height = 20+Table.frame.size.height
//                viewHistory.frame = frameCC
//                
//                frameCC = viewAll.frame
//                frameCC.size.height = viewHistory.frame.origin.y+viewHistory.frame.size.height+20
//                viewAll.frame = frameCC
                
            }else{
                
                var Frame = viewHistory.frame
                Frame.origin.y = viewCC.frame.origin.y+viewCC.frame.size.height+20
                Frame.size.height = 20+Table.frame.size.height
                viewHistory.frame = Frame
            
                Frame = viewAll.frame
                Frame.size.height = viewHistory.frame.origin.y+viewHistory.frame.size.height+20
                viewAll.frame = Frame
            
                
            }
            
            self.scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.viewAll.frame.size.height-50)
        }
//        viewHistory
    }
    
    func GetUserList()  {
        var parameter = NSString()
        parameter = ""
        self.DropDownUserList = [DropDownListData]()

        parameter = parameter.appending("&provider_id=") as NSString
        parameter = parameter.appending(DashboardData[0].CD_Provider_Id as String) as NSString
        print("User list \(parameter)")
        AllMethods().assignTo(with: parameter as String, completion: { (ResponsiblePerson) in
            self.UserList = [ResponsiblePersonListData]()
            self.UserList = ResponsiblePerson
            NSLog("Count := %d", ResponsiblePerson.count)
            DispatchQueue.main.async {
                self.DropDownUserList = [DropDownListData]()
                for  i in 0..<self.UserList.count{
                   print("demo \(self.UserList[i].RP_Name as String)")
                    var cmd = DropDownListData()
                    cmd.Drp_Id = self.UserList[i].RP_Id as String
                    cmd.Drp_Name = self.UserList[i].RP_Name as String
                    self.DropDownUserList.append(cmd)
                }
            }
        })
    }

    func getMacro()  {
        
        AllMethods().MacroListData(with: "", API: "", completion: { (MacroDataList) in
            self.MacroList = [Macro]()
            self.MacroList = MacroDataList
            print("Get Macro")
            self.DropDownMacroList = [DropDownListData]()
            DispatchQueue.main.async {
                for  i in 0..<self.MacroList.count{
                    var cmd = DropDownListData()
                    cmd.Drp_Id = self.MacroList[i].MAC_Id as String
                    cmd.Drp_Name = self.MacroList[i].MAC_Name as String
                    cmd.Drp_StateId = self.MacroList[i].MAC_Description as String
                    self.DropDownMacroList.append(cmd)
                }
            }
//            print(self.MacroList)
        })
    }
    
    func getHistory() {
        let parameter = "&call_id=".appending(DashboardData[0].CD_Id)
        print("Parameter = :\(parameter)")
        DispatchQueue.main.async {
            
            AllMethods().NotesDetail(with: parameter, API: "", completion: {(HistoryListData) in
                self.HistoryList = [GetNote]()
                self.HistoryList = HistoryListData
                print("Hestory count \(self.HistoryList.count)")
                if self.HistoryList.count == 0 {
                    self.viewHistory.isHidden = true
                }else{
                    self.viewHistory.isHidden = false
                }
                self.Table.reloadData()
                 self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.manageView), userInfo: nil, repeats: false)
            })
        }
    }
    
    func getCC(){
        self.view.endEditing(true)

        let parameter = "&call_id=".appending(DashboardData[0].CD_Id)
        //        print("Parameter = :\(parameter)")
        let APICC = LoginApi.Web_GetCCList as String
        
        DispatchQueue.main.async {
            AllMethods().GetCCListData(with: parameter, API: APICC, completion: {(ListData) in
                self.CCList = [GetCC]()
                self.CCList = ListData
                print(self.CCList)
                self.collectionCC.reloadData()   
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.manageView), userInfo: nil, repeats: false)
            })
            
        }

    }
    
    func UITableView_Auto_Height()
    {
        Table.reloadData()
//        if(self.Table.contentSize.height < self.Table.frame.height){
            var frame: CGRect = self.Table.frame;
            frame.size.height = self.Table.contentSize.height;
            self.Table.frame = frame;
//        }
//        override func viewDidAppear(animated: Bool) {
//            UITableView_Auto_Height();
//        }
    }
    
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        txtNotes.inputAccessoryView = keyboardToolbar
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
   
    // MARK: - Move to Dashboard (Close message fiyer)

    override func didMove(toParentViewController parent: UIViewController?) {
        super.didMove(toParentViewController: parent)
        if parent == nil{
            DispatchQueue.main.async {
                self.Notes(noteType: "4", noteDescription: "Closed an Message.")
            }
        }
    }
}

extension ViewNotes : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return  self.HistoryList.count
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let printData = self.HistoryList[indexPath.row]
        var cell = CustomCell()
        if printData.NT_Type == "0" || printData.NT_Type == "1"{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CustomCell
           cell.imgClock.isHidden = true
            cell.btnSelect.isHidden = true
            if printData.NT_Type == "0"{
                cell.imgIcone.image = #imageLiteral(resourceName: "iconInternal")
            }
            
            if printData.NT_Type == "1"{
            cell.imgIcone.image = #imageLiteral(resourceName: "iconExternal")
            }
            
            let FullName = ("<font face='Helvetica'color='#000' size='4.5'><b>").appending(printData.Added_By)
            
            let attrStr = try! NSAttributedString(
                data: FullName.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ],
                documentAttributes: nil)
            
            cell.lblUserName.attributedText = attrStr
            cell.lblDate.text = printData.NT_Added_Date
            cell.lblDate.textColor = UIColor().dateColor()
            cell.lblDescription.text = printData.NT_Desc
            cell.lblDescription.textColor = UIColor().dateColor()
            
            if printData.Notes_Files.count>0 {
                cell.imgClock.isHidden = false
                cell.btnSelect.isHidden = false
                cell.btnSelect.tag = indexPath.row
                
//                print("Print files \(printData.Notes_Files)")
            }
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
            if printData.NT_Type == "3"{
                cell.imgIcone.image = #imageLiteral(resourceName: "iconOpen")
            }
            if printData.NT_Type == "4"{
                cell.imgIcone.image = #imageLiteral(resourceName: "iconClose")
            }
            if printData.NT_Type == "5"{
                cell.imgIcone.image = #imageLiteral(resourceName: "iconChangeStatus")
            }
            if printData.NT_Type == "6"{
                cell.imgIcone.image = #imageLiteral(resourceName: "iconAssignTo")
            }
            
            let FullName = ("<font face='Helvetica'color='#000' size='4.5'><b>").appending(printData.Added_By).appending("</b> ").appending(printData.NT_Desc)
            
            let attrStr = try! NSAttributedString(
                data: FullName.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType ],
                documentAttributes: nil)
            cell.lblUserName.attributedText = attrStr
            cell.lblDate.text = printData.NT_Added_Date
            cell.lblDate.textColor = UIColor().dateColor()
            
        }
//        cell.lblAbbrivation.text = "fdfjsdfs ghds dsfghjdsg dfsghdfs hjghds dsbh dsbdfjsgdhs gdshf gdshf dgshfnds fhndsg hdsg dshgdsd fndsgfds hfdsg fhdgshf dsgfdkls fjds fsdg jdsgf s"
        return cell
    }
}

extension ViewNotes : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.CCList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.lbltitle.text = CCList[indexPath.row].CC_Address
        cell.btnCancel.tag = indexPath.row
        // cell.myLabel.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let originalString: String = CCList[indexPath.row].CC_Address
        let myString: NSString = originalString as NSString
        let size: CGSize = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
        
        var width = size.width+36
        
        if (size.width+36)>69{
            width = size.width+36
        }else{
            width = 70
        }
        return CGSize(width: width , height: 36);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       
        return CGSize(width: 5, height: 5);
        
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
    
}

extension ViewNotes : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}
extension ViewNotes : UITextViewDelegate{
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.txtNotes.text == ""{
            self.txtNotes.text = "Write notes"
            self.txtNotes.textColor = UIColor.lightGray
        }
        //        lbl.backgroundColor = .groupTableViewBackground
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if  txtNotes.textColor == UIColor.lightGray {
            
            txtNotes.text = nil
            txtNotes.textColor = UIColor.black
        }
        //        lbl.backgroundColor = .orange
        
    }
    
}

