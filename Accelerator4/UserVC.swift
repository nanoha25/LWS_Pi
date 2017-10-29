//
//  UserVC.swift
//  Accelerator4
//
//  Created by Leo Lee on 28/10/17.
//  Copyright © 2017 Leo Lee. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class UserVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate
{
    
    @IBOutlet weak var userImagePicker: UIImageView!
    @IBOutlet weak var completeSignInBtn: UIButton!
    @IBOutlet weak var userNamefiled:UITextField!
    @IBOutlet weak var phoneNofiled:UITextField!
    @IBOutlet weak var addressNofiled:UITextField!
    @IBOutlet weak var weightfiled:UITextField!
    @IBOutlet weak var heightfiled:UITextField!
    @IBOutlet weak var usernameOfferHelpfield:UITextField!
    var userUid: String!
    var emailField:String!
    var passwordField:String!
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var username: String!
    var phoneNo: String!
    var address: String!
    var weight: String!
    var height: String!
    var usernameOfferHelp: String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate=self
        imagePicker.allowsEditing=true
        userNamefiled.clearsOnBeginEditing = true
        phoneNofiled.clearsOnBeginEditing = true
        addressNofiled.clearsOnBeginEditing = true
        weightfiled.clearsOnBeginEditing = true
        heightfiled.clearsOnBeginEditing = true
        usernameOfferHelpfield.clearsOnBeginEditing = true
        userNamefiled.delegate = self
        userNamefiled.tag = 0 //Increment accordingly
        phoneNofiled.delegate = self
        phoneNofiled.tag = 0 //Increment accordingly
        addressNofiled.delegate = self
        addressNofiled.tag = 0 //Increment accordingly
        weightfiled.delegate = self
        weightfiled.tag = 0 //Increment accordingly
        heightfiled.delegate = self
        heightfiled.tag = 0 //Increment accordingly
        usernameOfferHelpfield.delegate = self
        usernameOfferHelpfield.tag = 0 //Increment accordingly
        self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
    }
    @IBAction func chooseImage(_sender:Any)
    {
        
        let actionSheet = UIAlertController(title:"Photo Source", message:"Choose one photo",preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title:"Camera",style:.default,handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(self.imagePicker,animated: true,completion: nil)
            }
            else
            {
                print("Camera not available")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title:"Photo Library",style:.default,handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
            {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.present(self.imagePicker,animated: true,completion: nil)
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            }
            else
            {
                print("Photo library is not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title:"Cancel",style:.cancel,handler: nil))
        self.present(actionSheet,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerEditedImage] as?
            UIImage
        {
            userImagePicker.image = image
            imageSelected = true
        }
        else
        {
            print("The image is not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    @IBAction func completeSignin(_sender: Any)
    {
        
        
        let myAlert_UserName = UIAlertController(title:"Empty UserName", message:"Input UserName plz", preferredStyle: .alert)
        if self.userNamefiled.text!.isEmpty || self.userNamefiled.text! == "Username"
        {
            
            myAlert_UserName.addAction(UIAlertAction(title:"Getback",style: .default, handler:nil))
            
            self.present(myAlert_UserName,animated: true,completion: nil)
        }
        else if self.phoneNofiled.text!.isEmpty || self.phoneNofiled.text! == "phone nubmer"
        {
            let myAlert_StudentID = UIAlertController(title:"Empty phoneNO", message:"Input PhoneNo plz", preferredStyle: .alert)
            
            myAlert_StudentID.addAction(UIAlertAction(title:"Getback",style: .default, handler:nil))
            
            self.present(myAlert_StudentID,animated: true,completion: nil)
        }
        else if   self.userImagePicker.image == nil || self.imageSelected == false
        {
            let myAlert_UserImage = UIAlertController(title:"Empty UserImage", message:"Upload UserImage plz", preferredStyle: .alert)
            myAlert_UserImage.addAction(UIAlertAction(title:"Getback",style: .default, handler:nil))
            
            self.present(myAlert_UserImage,animated: true,completion: nil)
        }
        else
        {
            
            Auth.auth().createUser(withEmail:emailField,password:passwordField,
                                   completion:
                {(user,error)
                    in
                    if error != nil
                    {
                        print("can't create user\(String(describing: error))")
                    }
                    else
                    {
                        self.userUid=user?.uid
                        print("The user is created with eamil and password")
                        
                    }
            })
            
            self.username = self.userNamefiled.text
            self.phoneNo = self.phoneNofiled.text
            self.address = self.addressNofiled.text
            self.weight = self.weightfiled.text
            self.height = self.heightfiled.text
            self.usernameOfferHelp = self.usernameOfferHelpfield.text
            
            self.completeSignInBtn.isEnabled = true
            
            
            //        guard let img = userImagePicker.image, imageSelected == true
            //        else
            //        {
            //            print("imamge must be selected")
            //            return
            //
            
            let img = self.userImagePicker.image
            
            if let imgData = UIImageJPEGRepresentation(img!, 0.3)
            {
                let imgUid = NSUUID().uuidString
                let metadata = StorageMetadata()
                metadata.contentType = "img/jpeg"
                Storage.storage().reference().child(imgUid).putData(imgData,metadata:
                    metadata)
                {(metadata, error) in
                    if error != nil
                    {
                        print("image is not uploaded")
                        let nsError = error as! NSError
                        print(nsError.localizedDescription)
                        
                    }
                    else
                    {
                        print("Uploaded!")
                        let downloadURL = metadata?.downloadURL()?.absoluteString
                        if let url = downloadURL
                        {
                            self.setUpUser(img: url,username: self.username,phoneNO:self.phoneNo,
                                address:self.address,weight:self.weight,height:self.height,userNameOfferHelp: self.usernameOfferHelp)
                        }
                        
                    }
                }
            }
        }
        Auth.auth().signIn(withEmail: emailField,password:passwordField,completion:
            { (user,error) in
                if error == nil
                {
                    if let user = user
                    {
                        self.userUid = user.uid
                    }
                }
        })
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainboard")
        self.present(vc!, animated: true, completion: nil)
        
    }

    func keychain()
    {
        KeychainWrapper.standard.set(userUid, forKey:"uid")
    }
    
    
    func setUpUser(img:String,username:String,phoneNO:String,address:String,weight:String,height:String,userNameOfferHelp
        :String)
    {
        let userData =
            [
                "Username": username,
                "PhoneNo": phoneNO,
                "Adress":address,
                "Weight":weight,
                "Height":height,
                "UsernameOfferHelp":userNameOfferHelp,
                "Fall":"False",
                "UserImage":img
        ]
        keychain()
        let setLocation =  Database.database().reference().child("users").child(userUid)
        setLocation.setValue(userData)
    }
    
    
    
    @IBAction func selectedImagePicker(_sender: Any)
    {
        present(imagePicker,animated: true, completion: nil)
    }
    @IBAction func cancel(_sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
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
