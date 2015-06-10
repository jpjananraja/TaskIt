//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Janan Rajaratnam on 5/27/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit
import CoreData


class AddTaskViewController: UIViewController
{

//    var mainVC:ViewController!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subTaskTextField: UITextField!
    @IBOutlet weak var duedatePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    // MARK: - IBAction Methods
    
    @IBAction func cancelButtonTapped(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    

    @IBAction func addTaskButtonTapped(sender: UIButton)
    {
        //before core data addition
//        var task:TaskModel = TaskModel(task: taskTextField.text, subTask: subTaskTextField.text, date: duedatePicker.date, completed:false)
//        
//       self.mainVC?.baseArray[0].append(task) //Use the ViewController's property taskArray
    
        
        
        //For core data addition
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
       let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        //Capitalize the string and save it if the key for capitalization is set to true
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true
        {
            task.task = self.taskTextField.text.capitalizedString
        }
        else
        {
            task.task = self.taskTextField.text
        }
        
        
        task.subTask = self.subTaskTextField.text
        task.date = self.duedatePicker.date
        
        //if the user chose all new to do tasks are completed are true then do the following or..
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) == true
        {
            task.completed = true
        }
        else
        {
            task.completed = false
        }
        

        

//        task.task = self.taskTextField.text
//        task.subTask = self.subTaskTextField.text
//        task.date = self.duedatePicker.date
//        task.completed = false
        
        
        
        appDelegate.saveContext()
        //any changes made to the entity after the appDelegate.saveContext() will not be saved
        
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        
        
        for res in results
        {
            println(res)
        }
        
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
}
