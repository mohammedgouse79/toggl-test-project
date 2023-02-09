//
//  DataControllerTests.swift
//  TogglTestProjectTests
//
//  Created by Nihal on 09/02/23.
//

import XCTest
import CoreData

@testable import TogglTestProject

final class DataControllerTests: XCTestCase {
    
    var sut: DataController!
    var viewContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        sut = DataController.shared
        viewContext = sut.persistentContainer.viewContext
        deleteAllActivities()
    }
    
    override func tearDown() {
        sut = nil
        viewContext = nil
        super.tearDown()
    }
    
    private func deleteAllActivities() {
        let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func testCreateActivity() {
        let note = "Test Activity"
        sut.createActivity(note: note, viewContext: viewContext)
        
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        request.predicate = NSPredicate(format: "note == %@", note)
        let results = try? viewContext.fetch(request)
        
        XCTAssertNotNil(results)
        XCTAssertEqual(results?.count, 1)
        XCTAssertEqual(results?.first?.note, note)
    }
    
    func testPauseActivity() {
        let activity = Activity(context: viewContext)
        activity.id = UUID()
        activity.note = "Test Activity"
        activity.startDate = Date()
        activity.endDate = nil
        activity.isRunning = true
        try? viewContext.save()
        
        sut.pauseActivity(activity: activity, viewContext: viewContext)
        XCTAssertNotNil(activity.endDate)
        XCTAssertFalse(activity.isRunning)
    }
    
    func testResumeActivity() {
        let activity = Activity(context: viewContext)
        activity.id = UUID()
        activity.note = "Test Activity"
        activity.startDate = Date()
        activity.endDate = Date()
        activity.isRunning = false
        try? viewContext.save()
        
        sut.resumeActivity(activity: activity, viewContext: viewContext)
        XCTAssertTrue(activity.isRunning)
        XCTAssertNil(activity.endDate)
        XCTAssertTrue(activity.isRunning)
    }
    
    func testEditNote() {
        let activity = Activity(context: viewContext)
        activity.id = UUID()
        activity.note = "Test Activity"
        activity.startDate = Date()
        activity.endDate = nil
        activity.isRunning = true
        try? viewContext.save()
        
        let newNote = "Updated Test Activity"
        sut.editNote(activity: activity, note: newNote, viewContext: viewContext)
        XCTAssertEqual(activity.note, newNote)
    }
    
    func testDeleteActivity() {
        let activity = Activity(context: viewContext)
        activity.id = UUID()
        activity.note = "Test Activity"
        activity.startDate = Date()
        activity.endDate = nil
        activity.isRunning = true
        try? viewContext.save()
        
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        request.predicate = NSPredicate(format: "note == %@", "Test Activity")
        let results = try? viewContext.fetch(request)
        
        XCTAssertNotNil(results)
        XCTAssertEqual(results?.count, 1)
        
        sut.deleteActivity(activity: activity, viewContext: viewContext)
        let updatedResults = try? viewContext.fetch(request)
        
        XCTAssertNotNil(updatedResults)
        XCTAssertEqual(updatedResults?.count, 0)
    }
}
