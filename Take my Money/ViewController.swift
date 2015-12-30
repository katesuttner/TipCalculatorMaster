//
//  ViewController.swift
//  Take my Money
//
//  Created by Kate Suttner on 11/28/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var splitBillView: UIView!
    @IBOutlet weak var personNumberStepper: UIStepper!
    @IBOutlet weak var numPeopleLabel: UILabel!
    @IBOutlet weak var amountPerPersonLabel: UILabel!
    @IBOutlet weak var mainInputView: UIView!
    @IBOutlet weak var SmileyFaceHouse: UIImageView!
    @IBOutlet weak var OhNoFaceHouse: UIImageView!
    @IBOutlet weak var RollingFaceHouse: UIImageView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var tipPercentage: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let now = NSDate.timeIntervalSinceReferenceDate()
        let tenMins = 600.0
        
        
        if( ( now - defaults.doubleForKey("previous_billtime")) < tenMins )
        {
            billField.text = String(defaults.doubleForKey("previous_billamount"))
            tipControl.selectedSegmentIndex = defaults.integerForKey("selected_index")
            calculateTip()
            
        } else {
        
            totalLabel.text = "$0.00"
            tipLabel.text = "$0.00"
        }
        
       // self.mainInputView.center.x -= 250
        
//        UIView.animateWithDuration(1.0) {<#T##() -> Void#>in
//            
//            self.mainInputView.center.x += 250
//        }
        
        billField.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (defaults.boolForKey("splitBill")) {
            splitBillView.hidden = false
            billField.endEditing(true)
            
        } else {
            splitBillView.hidden = true
            billField.becomeFirstResponder()
        }
        
        let image1 : UIImage = UIImage (named: "SmileyTeethFace.gif")!
        var data1:NSData = try! AnimatedGIFImageSerialization.animatedGIFDataWithImage(image1, duration:0, loopCount:0)
        SmileyFaceHouse.image = UIImage(data:data1)
        
        let image2 : UIImage = UIImage (named: "OhNoFace.gif")!
        var data2:NSData = try! AnimatedGIFImageSerialization.animatedGIFDataWithImage(image2, duration:0, loopCount:0)
        OhNoFaceHouse.image = UIImage(data:data2)
        
        let image3 : UIImage = UIImage (named: "RollingFaceSmiley.gif")!
        var data3:NSData = try! AnimatedGIFImageSerialization.animatedGIFDataWithImage(image3, duration:0, loopCount:0)
        RollingFaceHouse.image = UIImage(data:data3)
        
        
        tipControl.selectedSegmentIndex = defaults.integerForKey("selected_index")
        
        calculateTip()
        
        
        
        
    }
    
    override func viewWillDisappear (animated: Bool) {
        super.viewWillAppear(animated)
        //defaults.setBool(false, forKey: "splitBill")
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    
    }

    @IBAction func NumPeopleChanged(sender: AnyObject) {
        calculateTip()
        
        
    }
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.1, 0.15, 0.20]
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip()
        
    }
    
    func calculateTip() {
        
        let tipPercentages = [0.1, 0.15, 0.20]
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        defaults.setDouble(billAmount, forKey: "previous_billamount")
        defaults.setDouble(NSDate.timeIntervalSinceReferenceDate(), forKey: "previous_billtime")
        
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let numPeople = personNumberStepper.value
        numPeopleLabel.text = String("\(Int(numPeople)) people")
        
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)
        totalLabel.text = currencyFormatter.stringFromNumber(total)
        let multiplePersonBillAmount = total / numPeople
        amountPerPersonLabel.text = currencyFormatter.stringFromNumber(multiplePersonBillAmount)
        
        
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
        
    }
    
}

