//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Janan Rajaratnam on 5/26/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    var detailTaskModel:TaskModel!
//    var mainVC:ViewController!
    
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextfield: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println(self.detailTaskModel.task)
        
        self.taskTextField.text = self.detailTaskModel.task
        self.subtaskTextfield.text = self.detailTaskModel.subTask
        self.dueDatePicker.date = self.detailTaskModel.date
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    // MARK: - IBAction Methods

    @IBAction func cancelButtonTapped(sender: UIBarButtonItem)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem)
    {
        
       
//        var task:TaskModel = TaskModel(task: taskTextField.text, subTask: subtaskTextfield.text, date: dueDatePicker.date, completed:false)
//        
//        //The code below modifies the changes to the task selected from main view
//        self.mainVC.baseArray[0][self.mainVC.tableView.indexPathForSelectedRow()!.row] = task
        
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        self.detailTaskModel.task = self.taskTextField.text
       self.detailTaskModel.subTask = self.subtaskTextfield.text
        self.detailTaskModel.date = self.dueDatePicker.date
        self.detailTaskModel.completed = self.detailTaskModel.completed
        
        appDelegate.saveContext()
      
        
        //The code below adds a new task instead of updating the requireded selected task
//        self.mainVC.taskArray.append(task)
        
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    

}
