//
//  ViewController.swift
//  Accelerator
//
//  Created by Leo Lee on 16/10/17.
//  Copyright © 2017 Leo Lee. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error)in
            
            if let myData = data
            {
                if myData.acceleration.x > 1
                {
                    print("do someting ")
                }
            }
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
//    override func viewDidAppear(_ animated: Bool) {
//        motionManager.accelerometerUpdateInterval = 0.2
//        motionManager.startAccelerometerUpdates(to: OperationQueue.current!){(data,error)in
//        
//        if let myData = data
//        {
//              if myData.acceleration.x > 5
//              {
//                print("do someting ")
//               }
//        }
//        
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

