//
//  DataController.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import Foundation
import CoreData

struct DataController {
    let persistentContainer: NSPersistentContainer
    static let shared: DataController = DataController()
    
    private init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ActivityModel")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores { _, err in
            if err != nil {
                fatalError("Unable to Load")
            }
        }
    }
    
    static var preview: DataController = {
        let result = DataController(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for index in 1..<10 {
            let activity = Activity(context: viewContext)
            activity.isRunning = false
            activity.id = UUID()
            activity.startDate = Date()
            activity.endDate = Date()
            activity.note = "Activity \(index)"
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
        return result
    }()
    
    func save (viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
            print("Data Saved!")
        } catch {
            print("There was an Error in Saving the Data")
            print(error.localizedDescription)
        }
    }
    
    func createActivity(note: String, viewContext: NSManagedObjectContext) {
        let activity = Activity(context: viewContext)
        activity.id = UUID()
        activity.note = note
        activity.startDate = Date()
        activity.endDate = nil
        activity.isRunning = true

        save(viewContext: viewContext)
    }
    
    func deleteActivity(activity: Activity, viewContext: NSManagedObjectContext) {
        viewContext.delete(activity)
        save(viewContext: viewContext)
    }
    
    func pauseActivity(activity: Activity, viewContext: NSManagedObjectContext) {
        activity.endDate = Date()
        
        activity.totalTime += activity.endDate!.timeIntervalSince1970 - activity.startDate!.timeIntervalSince1970
        
        activity.isRunning = false
        save(viewContext: viewContext)
    }
    
    func resumeActivity(activity: Activity, viewContext: NSManagedObjectContext) {
        activity.isRunning = true
        activity.startDate = Date()
        activity.endDate = nil
        
        save(viewContext: viewContext)
    }
    
    func editNote(activity: Activity, note: String, viewContext: NSManagedObjectContext) {
        activity.note = note
        
        save(viewContext: viewContext)
    }
}
