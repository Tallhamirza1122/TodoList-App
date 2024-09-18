//
//  ToDoListitem+CoreDataProperties.swift
//  CoreDatas
//
//  Created by Talha's Macbook on 17/09/2024.
//
//

import Foundation
import CoreData


extension ToDoListitem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListitem> {
        return NSFetchRequest<ToDoListitem>(entityName: "ToDoListitem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdat: Date?

}

extension ToDoListitem : Identifiable {

}
