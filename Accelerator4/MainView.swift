//
//  MainView.swift
//  Accelerator4
//
//  Created by Leo Lee on 28/10/17.
//  Copyright © 2017 Leo Lee. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import AudioToolbox
import CoreMotion

class MainView: UIViewController {
    @IBOutlet weak var notificationField: UILabel!
     var Offerhelpname_pub:String!
   
    var notification:String!
    var motionManager = CMMotionManager()
    var motionManager_Gyro = CMMotionManager()
    @IBOutlet weak var CancelResult: UIButton!
    @IBOutlet weak var CancelMonitorResult: UIButton!
    @IBOutlet weak var x: UILabel!
    @IBOutlet weak var y: UILabel!
    @IBOutlet weak var z: UILabel!
    @IBOutlet weak var threshold: UILabel!
    @IBOutlet weak var alarm: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationField.text = self.notification
        self.CancelResult.isHidden = true
        self.CancelMonitorResult.isHidden = true
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager_Gyro.gyroUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error)in
            
            if let myData = data
            {
                self.x.text = String(myData.acceleration.x)
                self.y.text = String(myData.acceleration.y)
                self.z.text = String(myData.acceleration.z)
                let x1:Double = Double(myData.acceleration.x)
                let y1:Double = Double(myData.acceleration.y)
                let z1:Double = Double(myData.acceleration.z)
                let  threshold_rate:Double = sqrt(pow(x1,2)+pow(y1,2)+pow(z1,2))
                let  angle:Double = atan(sqrt(pow(y1, 2)+pow(z1, 2))/(x1)*180.0/Double.pi)
                self.threshold.text = String(threshold_rate)
                if threshold_rate > 2.5
                {
                    print("Alarm!!!!!! \(threshold_rate)and angle is \(angle)!")
                    self.alarm.text = "Fall detected"
                    self.CancelResult.isHidden = false
                    let userUid = Auth.auth().currentUser?.uid
                    let setLocation =  Database.database().reference().child("users").child(userUid!).child("Fall")
                    setLocation.setValue("True")
                }
                
            }
        }
        //        motionManager_Gyro.startGyroUpdates(to: OperationQueue.current!){(data,error)in
        //
        //            if let myData_gyro = data
        //            {
        //                self.xG.text = String(myData_gyro.rotationRate.x)
        //                self.yG.text = String(myData_gyro.rotationRate.y)
        //                self.zG.text = String(myData_gyro.rotationRate.z)
        //
        //
        //            }
        //
        //        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cancelResult(sender: AnyObject?){
        self.CancelResult.isHidden = true
        self.alarm.text = nil
        let userUid = Auth.auth().currentUser?.uid
        let setLocation =  Database.database().reference().child("users").child(userUid!).child("Fall")
        setLocation.setValue("False")
       
    }
    @IBAction func MonitorBegin(sender: AnyObject?){
        let ref = Database.database().reference().child("users")
        let userUid = Auth.auth().currentUser?.uid
        var Offerhelpname:String!
        self.CancelMonitorResult.isHidden = false
        ref.child(userUid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
            //print(snapshot.hasChild("username"))
            print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb")
            if snapshot.exists()
            {
                
                print("user exist")
                
                    let dict = snapshot.value as! [String: String] // the value is a dict
                      Offerhelpname = dict["UsernameOfferHelp"]
                self.Offerhelpname_pub = Offerhelpname
                print("Offer help to \(Offerhelpname!)")
                 print("the offerhelp public is \(self.Offerhelpname_pub)")
                print("the name of offfhelpname \(Offerhelpname)")
                if Offerhelpname != nil
                {
                    let ref = Database.database().reference().child("users")
                    
                    //            refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
                    //                let postDict = snapshot.value as? [String : AnyObject] ?? [:]
                    //                // ...
                    //            })
                    print("the position before query")
                    ref.queryOrdered(byChild:"Username").queryEqual(toValue: Offerhelpname).observe(DataEventType.value, with: { (snapshot) in
                        
                        print(snapshot)
                        //print(snapshot.hasChild("username"))
                        print("get snapshot of the UsernameOfferHelp")
                        if snapshot.exists()
                        {
                            var fall:String!
                            print("UsernameOfferHelp exist")
                            for child in (snapshot.children)
                            {
                                let snap = child as! DataSnapshot
                                let dict = snap.value as! [String: String] // the value is a dict
                                
                                fall = dict["Fall"]
                            }
//                            let  myAlert_succ = UIAlertController(title:"If the elder fall", message: fall, preferredStyle:.alert)
//
//                            self.present(myAlert_succ,animated: true,completion: nil)
                            if  fall! == "True"
                            {
                                // alarm
                                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                                
                                print("The elder falls")
                                self.notification = "The elder fell!!!"
                                self.notificationField.text = self.notification
                                self.CancelMonitorResult.isHidden = false
                                
//                                self.counter = 0
//                                self.timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: Selector(("vibratePhone")), userInfo: nil, repeats: true)
//                                self.vibratePhone()
                                
                            }
                            else
                            {
                                print("The elder is well")
                            }
                        }
                        else
                        {
                            
                            print("snapshot of fall not exist!")
                        }
                    }
                    )
                    
                }
                else
                {
                    self.notification = "The usrname offer help to doesn't exist"
                    print("*********************\(self.notification)")
                    print("the offerhelp public is \(self.Offerhelpname_pub)")
                }
            }
            else
            {
                print("error when getting the username of offerHelpTo")
            }
        })
        
        
    }
//    func vibratePhone() {
//        self.counter+=1
//        switch self.counter {
//        case 1, 2:
//            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
//        default:
//            self.timer?.invalidate()
//        }
//    }
    
  
    @IBAction func cancelMonitorResult(sender: AnyObject?){
        self.CancelMonitorResult.isHidden = true
        self.notificationField.text = nil
    
        // caneal monitor event
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


