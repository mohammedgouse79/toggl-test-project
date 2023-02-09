//
//  NewActivityView.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

struct NewActivityView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Binding var isShowing: Bool
    @State var note: String = ""
    @FocusState var focus: Bool?
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 16) {
                TextField("Start New Activity", text: $note)
                    .padding()
                    .foregroundColor(.pink)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .focused($focus, equals: true)
                    .onAppear {
                        focus = true
                    }
                Button {
                    DataController.shared.createActivity(note: note, viewContext: viewContext)
                    note = ""
                    isShowing = false
                } label: {
                    Spacer()
                    Text("Start")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                }
                    .disabled(note.isEmpty)
                    .padding()
                    .foregroundColor(.white)
                    .background(note.isEmpty ? Color.blue : Color.pink)
                    .cornerRadius(10)
            }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.65), radius: 12)
                .frame(maxWidth: 640)
        }//: VStack
        .padding()
    }
}
