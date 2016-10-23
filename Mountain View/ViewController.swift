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
var METERS = 3.6576
let healthStore: HKHealthStore? = {
    if HKHealthStore.isHealthDataAvailable() {
        return HKHealthStore()
    } else {
        return nil
    }
}()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func completion(flightsClimbed: Double) {
        let apprheight = Int(flightsClimbed * METERS)
        let pctge = (apprheight / MTN_HEIGHT) * 100
        percentage.text = String(pctge) + "%"
    }
    @IBOutlet weak var percentage: UILabel!

    @IBAction func Click(_ sender: UIButton) {
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)
        let date = NSDate()
        let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let newDate = cal.startOfDay(for: date as Date)
        
        let predicate = HKQuery.predicateForSamples(withStart: newDate, end: NSDate() as Date, options: .strictStartDate)
        let interval: NSDateComponents = NSDateComponents()
        interval.day = 1
        
        let query = HKStatisticsCollectionQuery(quantityType: type!, quantitySamplePredicate: predicate, options: [.cumulativeSum], anchorDate: newDate as Date, intervalComponents: interval as DateComponents)
        
        query.initialResultsHandler = { query, results, error in
            if error != nil {
                //  Something went Wrong
                return
            }
            if let myResults = results{
                myResults.enumerateStatistics(from: NSDate.distantPast as Date, to: NSDate.distantFuture as Date) {
                    statistics, stop in
                    
                    if let quantity = statistics.sumQuantity() {
                        
                        let flights = quantity.doubleValue(for: HKUnit.count())
                        
                        self.completion(flightsClimbed: flights)
                        
                    }
                }
            }
        }
        healthStore?.execute(query)
    }
}

