//
//  ViewController.swift
//  TaskIt
//
//  Created by Janan Rajaratnam on 5/26/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate
{

 
    
    @IBOutlet weak var tableView: UITableView!
    
    //the managed object context
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    //Fetched Results Controller
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    
//    var taskArray:[Dictionary <String,String> ] = [] //An array of dictionaries
    
//    var taskArray:[TaskModel] = []
    
//    var baseArray:[[TaskModel]] = []
    
    
    
    
    
    //viewDidLoad before the addition of core data
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        let date1 = Date.from(year: 2015, month: 05, day: 29)
//        let date2 = Date.from(year: 2015, month: 05, day: 27)
//        let date3 = Date.from(year: 2015, month: 06, day: 14)
//        
//        
//        let task1 = TaskModel(task: "Study Tamil", subTask: "Verses", date: date1, completed:false)
//        let task2 = TaskModel(task: "Eat Dinner", subTask: "Burgers", date: date2,completed:false )
//        let task3 = TaskModel(task: "Gym", subTask: "Leg day", date: date3, completed:false)
//        
//        
////        let task1:Dictionary <String,String>   = ["task":"Study Tamil" , "subtask":"Verses" , "date":"01/10/2014"]
////        
////        let task2:Dictionary<String, String> = ["task": "Eat Dinner", "subtask": "Burgers", "date": "01/14/2014"]
////        let task3:Dictionary<String, String> = ["task": "Gym", "subtask": "Leg day", "date": "01/14/2014"]
////        
////        println(task1["task"]!)
////        println(task1["subtask"]!)
////        
////        println(task2["task"]!)
////        println(task2["subtask"]!)
//        
//        
//        //Add the dictionaries into the array
//        
//       let taskArray = [task1, task2, task3]
//        
//       var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]  //HAS ONE TASKMODEL IN THE ARRAY
//        
//        baseArray = [taskArray , completedArray]
//        
////        self.tableView.reloadData()
//    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.fetchedResultsController = self.getFetchResultsController()
        
        self.fetchedResultsController.delegate = self
        self.fetchedResultsController.performFetch(nil)
        
        
        //This prompts the UITableView to show the footer (which will have zero size) in place of the empty 'cells'.
        tableView.tableFooterView = UIView()
    
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        
//        //Mark: - Embedded Function
//        func sortByDate(taskOne:TaskModel , taskTwo:TaskModel) -> Bool
//        {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }//end of embedded function
//
//        self.taskArray = self.taskArray.sorted(sortByDate)
//        
        
        //the above lines of code including the embedded function and sorting in the task array can also be done using closures as follows
        
//        self.baseArray[0] = self.baseArray[0].sorted({ (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        })
//       THE ABOVE CODE IS REDUNDANT SINCE taskFetchRequest() does the sorting
        
        
//        self.tableView.reloadData()  ----->   controllerDidChangeContent() takes care of it when any changes have taken place
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "showTaskDetail"
        {
            
//            
//            if segue.destinationViewController is TaskDetailViewController {
//                let taskDetailViewController = segue.destinationViewController as TaskDetailViewController
//                taskDetailViewController.detailTaskModel = taskArray[tableView.indexPathForSelectedRow()!.row]
//            }
            
            
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            
//            detailVC.detailTaskModel = baseArray[indexPath!.section][indexPath!.row]
            
            detailVC.detailTaskModel = self.fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            
//            detailVC.mainVC = self
            
        }
        
        else if segue.identifier == "showTaskAdd"
        {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
//            addTaskVC.mainVC = self
            
            
        }
        
        
        
    }

    
    //MARK: - UITableViewDataSource methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
//        return self.baseArray[section].count
        
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
//        return self.baseArray.count
        
        return self.fetchedResultsController.sections!.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
//       println(indexPath.row)
       
//        let taskDict:Dictionary = taskArray[indexPath.row]
        
//        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        
        let thisTask = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
//        
//        cell.taskLabel.text = taskDict["task"]
//        cell.descriptionLabel.text = taskDict["subtask"]
//        cell.dateLabel.text = taskDict["date"]
        
        
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)

        return cell
        
    }

    //MARK: - UITableViewDelegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        println(indexPath.row)
        self.performSegueWithIdentifier("showTaskDetail", sender: self)
        
        
    }
    
    //Adds the height of the seperator for sections
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        
        return 25
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        //If there is only one section left (Either "To do" or "Completed")
        if fetchedResultsController.sections?.count == 1
        {
            let fetchedObjects = fetchedResultsController.fetchedObjects!
            
            let testTask:TaskModel = fetchedObjects[0] as TaskModel
            
            if testTask.completed == true
            {
                return "Completed"
            }
            else
            {
                return "To do"
            }
            
        }
        else
        {
            if section == 0
            {
                return "To do"
            }
            else
            {
                return "Completed"
            }
            
        }
        
        
        
        
    }
    
    //The below tableView commitEditingStyle coding creates a weird bug in functionality
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
//    {
//    
////        let thisTask:TaskModel = baseArray[indexPath.section][indexPath.row]
//        
//         let thisTask:TaskModel = self.fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
//        
//        
//        if indexPath.section == 0
//        {
////            var newTask:TaskModel = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
////            
////            //remove the task from the todo array and...
//////            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
////            
////            //add to the completed array
////            self.baseArray[1].append(newTask)
//            
//            thisTask.completed = true
//            
//            
//
//        }
//        else
//        {
////            var newTask:TaskModel = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
////            
////            //remove the task from the todo array and...
//////            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
////            
////            //add to the completed array
////            self.baseArray[0].append(newTask)
//            
//            
//            thisTask.completed = false
//            
//        }
//    (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
//    
//    //        self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
//    //        self.tableView.reloadData()
//    
//    
//    
//    
//    }



    
        
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        
        //Switch completed status whenever the delete button is pressed
        if thisTask.completed == true
        {
            thisTask.completed = false
        } else
        {
            thisTask.completed = true
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    
    
    
    
    // MARK: - IBAction Methods
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem)
    {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }

    
    //MARK: - Helper methods
    
    func taskFetchRequest() -> NSFetchRequest
    {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        
        fetchRequest.sortDescriptors = [completedDescriptor , sortDescriptor]
        
        return fetchRequest
    }
    
    
    func getFetchResultsController() -> NSFetchedResultsController
    {
         self.fetchedResultsController = NSFetchedResultsController(fetchRequest: self.taskFetchRequest(), managedObjectContext: self.managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        
        
        return self.fetchedResultsController
        
        
    }
    
    //MARK: - NSFetchedResultsController Delegate Methods
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        self.tableView.reloadData()
    }
    
    
   
    
    

}

