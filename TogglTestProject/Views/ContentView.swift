//
//  ContentView.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var showNewEntry: Bool = false
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Activity.entity(), sortDescriptors: [NSSortDescriptor(key: "startDate", ascending: false)]) var activities: FetchedResults<Activity>
    
    var totalCount: Int {
        return activities.count
    }
    
    var inProgressCount: Int {
        return activities.filter{$0.isRunning}.count
    }
    
    var totalTime: String {
        return FormatTime(timeInSeconds: activities.map { $0.totalTime }.reduce(0, +))
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    // MARK: Header
                    Text("Toggl Test Project")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // MARK: Info Card
                    InfoCard(inProgressCount: inProgressCount, totalCount: totalCount, totalTime: totalTime)
                    
                    // MARK: Activity List
                    Text("All Activity")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    ForEach(activities) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            ActivityCardView(activity: activity)
                        }
                    }
                } // ScrollView
                .padding(.horizontal)
                
                // MARK: Create-Activity Button
                HStack(alignment: .center) {
                    Button {
                        withAnimation {
                            showNewEntry = true
                        }
                    } label: {
                        Text("Start New Activity").font(.system(size: 20, weight: .semibold, design: .rounded))
                        Image(systemName: "play.fill").font(.system(size: 20, weight: .semibold, design: .rounded))
                    }
                    .padding()
                    .foregroundColor(.black)
                    .background(Color(#colorLiteral(red: 170/255, green: 180/255, blue: 240/255, alpha: 1)))
                    .clipShape(Capsule())
                } // Create Activity Button
                .padding()
                
                if(showNewEntry) {
                    BlankView().onTapGesture {
                        showNewEntry = false
                    }
                    NewActivityView(isShowing: $showNewEntry)
                }
                
            } // ZStack
        } // NavigationView
        .toolbar(.hidden)
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, DataController.preview.persistentContainer.viewContext)
    }
}
