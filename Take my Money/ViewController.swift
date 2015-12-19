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
            calculateTip(0.20)
            
        } else {
        
            totalLabel.text = "$0.00"
            tipLabel.text = "$0.00"
        }
        
       // self.mainInputView.center.x -= 250
        
//        UIView.animateWithDuration(1.0) {<#T##() -> Void#>in
//            
//            self.mainInputView.center.x += 250
//        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (defaults.boolForKey("splitBill")) {
            splitBillView.hidden = false
            
        } else {
            splitBillView.hidden = true
            
        }
        
        
        billField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    
    }

    @IBAction func NumPeopleChanged(sender: AnyObject) {
        calculateTip(tipPercentage)
        
        
    }
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.1, 0.15, 0.20]
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip(tipPercentage)
        
    }
    
    func calculateTip(tipPercentage: Double) {
        
        
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

