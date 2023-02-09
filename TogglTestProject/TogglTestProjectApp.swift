//
//  TogglTestProjectApp.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

@main
struct TogglTestProjectApp: App {
    let pc = DataController.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, pc.viewContext)
        }
    }
}
