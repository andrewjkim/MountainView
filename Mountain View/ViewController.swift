//
//  ViewController.swift
//  Mountain View
//
//  Created by Andrew Kim on 10/7/16.
//  Copyright © 2016 Andrew Kim. All rights reserved.
//

import UIKit
import HealthKit

var MTN_HEIGHT = 8848
//let healthKitManager = HealthKitManager.sharedInstance

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func Click(_ sender: UIButton) {
        percentage.text = "100%"
    }
    @IBOutlet weak var percentage: UILabel!
}

