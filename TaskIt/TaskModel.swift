//
//  TaskModel.swift
//  TaskIt
//
//  Created by Janan Rajaratnam on 5/27/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import Foundation
import CoreData

class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subTask: String
    @NSManaged var task: String

}
