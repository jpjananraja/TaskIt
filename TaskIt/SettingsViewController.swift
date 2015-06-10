//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Janan Rajaratnam on 6/9/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//
//Second commit

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var capitalizeTableView: UITableView!
    
    
    @IBOutlet weak var completeNewToDoTableView: UITableView!
    
    
    
    @IBOutlet weak var versionLabel: UILabel!
    
    
    
    //constant
    let kVersionNumber = "1.0"
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        
        self.completeNewToDoTableView.delegate = self
        self.completeNewToDoTableView.dataSource = self
        self.completeNewToDoTableView.scrollEnabled = false
        
        
        self.title = "Settings"
        
        self.versionLabel.text = kVersionNumber
        
        //Initialize the button
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
        
        //Add the button to left side of the navigation bar
        self.navigationItem.leftBarButtonItem = doneButton
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Functionality for the button
    
    func doneBarButtonItemPressed(barButtonItem: UIBarButtonItem)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK:- UITableViewDataSource methods
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if tableView == self.capitalizeTableView
        {
            var capitalizeCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
            
            if indexPath.row == 0
            {
                capitalizeCell.textLabel?.text = "No do not Capitalize"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false
                {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    
                }
                else
                {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else
            {
                
                capitalizeCell.textLabel?.text = "Yes Capitalize"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true
                {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    
                }
                else
                {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            return capitalizeCell
            
        }
        else
        {
            var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewToDoCell") as UITableViewCell
            
            if indexPath.row == 0
            {
                cell.textLabel?.text = "Do not complete Task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) == false
                {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                    
                }
            }
            else
            {
                cell.textLabel?.text = "Complete Task"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) == true
                {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                    
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            return cell
        }
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 30
        
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
            if tableView == self.capitalizeTableView
            {
                return "Capitalize new Task?"
            }
            else
            {
                return "Complete new Task?"
            }
        
    }
    
    
    
    //MARK:- UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if tableView == self.capitalizeTableView
        {
            if indexPath.row == 0
            {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            }
            else
            {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        }
        else
        {
            if indexPath.row == 0
            {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewToDoKey)
            }
            else
            {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewToDoKey)
            }
        }
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        tableView.reloadData()
        
    }
    
}
