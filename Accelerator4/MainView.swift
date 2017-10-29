//
//  MainView.swift
//  Accelerator4
//
//  Created by Leo Lee on 28/10/17.
//  Copyright © 2017 Leo Lee. All rights reserved.
//

import Foundation
import UIKit

import CoreMotion

class MainView: UIViewController {
    var motionManager = CMMotionManager()
    var motionManager_Gyro = CMMotionManager()
    @IBOutlet weak var CancelResult: UIButton!
    @IBOutlet weak var x: UILabel!
    @IBOutlet weak var y: UILabel!
    @IBOutlet weak var z: UILabel!
    @IBOutlet weak var threshold: UILabel!
    @IBOutlet weak var alarm: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CancelResult.isHidden = true
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
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


