//
//  ViewController.swift
//  Labacess
//
//  Created by Leo Lee on 16/8/17.
//  Copyright © 2017 Leo Lee. All rights reserved.
//
import Foundation
import UIKit
import Firebase
import SwiftKeychainWrapper

class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailField:UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userUid: String!
    var studentID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        emailField.tag = 0 //Increment accordingly
        passwordField.delegate = self
        passwordField.tag = 0 //Increment accordingly
        emailField.clearsOnBeginEditing = true
        passwordField.clearsOnBeginEditing = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ =     KeychainWrapper.standard.string(forKey: "uid")
        {
            //goToMainVC()
        }
        
    }
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        let textFieldText: NSString = (textField.text ?? "") as NSString
    //        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
    //        //callMyMethod(txtAfterUpdate)
    //
    //        return true
    //    }
    //
    //    func textFieldShouldClear(_ textField: UITextField) -> Bool {
    //
    //        return true
    //    }
    
    
    
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
    
    func goToCreateUserVC()
    {
        performSegue(withIdentifier:"SignUp",sender:nil)
    }
    
    func goToMainVC()
    {
        performSegue(withIdentifier: "mainboard", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "SignUp"
        {
            if let destination = segue.destination as? UserVC
            {
                if userUid != nil
                {
                    destination.userUid = userUid
                }
                if emailField.text != nil
                {
                    destination.emailField = emailField.text
                }
                if passwordField.text != nil
                {
                    destination.passwordField = passwordField.text
                }
            }
            
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    func isValidPassword(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let passwrodRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwrodRegEx)
        return passwordTest.evaluate(with: testStr)
    }
    
    
    @IBAction func signInTapped(_ sender:Any){
        let email = emailField.text!
        let password = passwordField.text!
        if isValidEmail(testStr: email)
        {
            Auth.auth().signIn(withEmail: email,password:password,completion:
                { (user,error) in
                    if error == nil
                    {
                        if let user = user
                        {
                            
                            
                            self.userUid = user.uid
                            //self.studentID = user.studentId
                            self.goToMainVC()
                            
                        }
                    }
                    else
                    {
                        
                        
                        if self.isValidPassword(testStr: password)
                        {
                            
                            Auth.auth().fetchProviders(forEmail: email, completion: { (stringArray, error) in
                                if error != nil {
                                    print(error!)
                                } else {
                                    if stringArray == nil {
                                        print("No password. No active account")
                                        self.goToCreateUserVC()
                                        
                                    } else {
                                        print("There is an active account")
                                        let Alert_passwrod_not_match = UIAlertController(title:"Wrong Password", message:"Input right email plz", preferredStyle: .alert)
                                        
                                        Alert_passwrod_not_match.addAction(UIAlertAction(title:"Getback",style: .default, handler:nil))
                                        
                                        self.present(Alert_passwrod_not_match,animated: true,completion: nil)
                                    }
                                }
                            })
                            
                        }
                        else
                            
                        {
                            
                            
                            let Alert_passwrod = UIAlertController(title:"Invalid Password", message:"Input valid password with at least 6 characters with more than one alphabet", preferredStyle: .alert)
                            
                            Alert_passwrod.addAction(UIAlertAction(title:"Getback",style: .default, handler:nil))
                            
                            self.present(Alert_passwrod,animated: true,completion: nil)
                        }
                        
                    }
                    
            }
            )
        }
        else
        {
            print("the email typed is not valid")
            let Alert_Email = UIAlertController(title:"Invalid Email", message:"Input valid email plz", preferredStyle: .alert)
            
            Alert_Email.addAction(UIAlertAction(title:"Getback",style: .default, handler:nil))
            
            self.present(Alert_Email,animated: true,completion: nil)
        }
    }
    
}
