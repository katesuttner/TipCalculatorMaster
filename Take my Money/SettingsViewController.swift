//
//  SettingsViewController.swift
//  Take my Money
//
//  Created by Kate Suttner on 12/13/15.
//  Copyright © 2015 CodePath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var billSwitch: UISwitch!
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
//    var splitViewEnabled = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //splitViewEnabled = userDefaults.boolForKey("splitView")
        billSwitch.on = userDefaults.boolForKey("splitBill")
        
    }
    
    @IBAction func splitBillOn(sender: UISwitch) {
        
        if(sender.on) {
            userDefaults.setBool(true, forKey: "splitBill")
            
        } else {
            userDefaults.setBool(false, forKey: "splitBill")
            
        }
        userDefaults.synchronize()
        
    }
    

}
