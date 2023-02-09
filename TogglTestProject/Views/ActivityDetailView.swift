//
//  ActivityDetailView.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activity: Activity
    @State var newNote: String = ""
    @FocusState private var focus: Bool?
    
    var body: some View {
        VStack(spacing: 40) {
            // MARK: NavBar
            HStack {
                ActionButton(icon: "chevron.backward", showAlert: false, action: {
                    dismiss()
                })
                
                Spacer()
                Text("Activity")
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                Spacer()
                
                ActionButton(icon: "trash", showAlert: true, action: {
                    DataController.shared.deleteActivity(activity: activity, viewContext: viewContext)
                    dismiss()
                })
            } // NavBar
            
            Spacer()
            
            VStack {
                TextField("Add a Note", text: $newNote)
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.clear)
                    .onAppear {
                        newNote = activity.note ?? ""
                    }
                    .focused($focus, equals: true)
                    .onSubmit {
                        DataController.shared.editNote(activity: activity, note: newNote, viewContext: viewContext)
                        focus = nil
                    }
            }
            
            // MARK: Timer
            VStack (spacing: 10) {
                Subtitle(text: "Total Time")
                
                if activity.isRunning {
                    Text(activity.startDate!.addingTimeInterval(-activity.totalTime), style: .timer)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                } else {
                    Text("\(FormatTime(timeInSeconds: activity.totalTime))")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                }
            }
            
            // MARK: Play/Pause Button
            pauseplaybutton
            
            Spacer()
            Spacer()
        } // VStack
        .toolbar(.hidden)
        .padding()
        .background(Color(#colorLiteral(red: 220/255, green: 240/255, blue: 255/255, alpha: 1)))
        .onTapGesture {
            focus = nil
        }
    }
    
    @ViewBuilder var pauseplaybutton: some View {
        
        if activity.isRunning {
            Button {
                DataController.shared.pauseActivity(activity: activity, viewContext: viewContext)
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "pause.fill").font(.system(size: 40, weight: .bold, design: .rounded))
                    Subtitle(text: "Pause")
                }.foregroundColor(.black)
            }
        } else {
            Button {
                DataController.shared.resumeActivity(activity: activity, viewContext: viewContext)
            } label: {
                VStack(spacing: 10) {
                    Image(systemName: "play.fill").font(.system(size: 40, weight: .bold, design: .rounded))
                    Subtitle(text: "Resume")
                }.foregroundColor(.black)
            }
            
        }
    }
}

struct ActionButton: View {
    @State private var showDeleteConfirmation = false
    var icon: String
    var showAlert: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 200/255, green: 230/255, blue: 235/255, alpha: 1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button {
                if showAlert {
                    self.showDeleteConfirmation = true
                } else {
                    action()
                }
            } label: {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(title: Text("Delete"), message: Text("Are You Sure To Delete This Activity?"), primaryButton: .destructive(Text("Delete"), action: {
                    action()
                }), secondaryButton: .cancel())
            }
        }
        .frame(width: 50, height: 50)
        .padding(15)
    }
}
