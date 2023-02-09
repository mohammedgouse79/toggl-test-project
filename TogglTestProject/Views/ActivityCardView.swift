//
//  ActivityCardView.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

struct ActivityCardView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var activity: Activity
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                Text("\(activity.note!)").font(.system(.headline, design: .rounded, weight: .semibold)).multilineTextAlignment(.leading)
                Spacer()
                if activity.isRunning {
                    Text(activity.startDate!.addingTimeInterval(-activity.totalTime), style: .timer).font(.system(.subheadline, design: .rounded))
                } else {
                    Text("\(FormatTime(timeInSeconds: activity.totalTime))").font(.system(.subheadline, design: .rounded))
                }
            }
            
            HStack {
                Subtitle(text: formatDate(date: activity.startDate!))
                Spacer()
                Button {
                    withAnimation {
                        if activity.isRunning {
                            DataController.shared.pauseActivity(activity: activity, viewContext: viewContext)
                        } else {
                            DataController.shared.resumeActivity(activity: activity, viewContext: viewContext)
                        }
                    }
                } label: {
                    if activity.isRunning {
                        Image(systemName: "pause.fill").font(.system(.title2, design: .rounded))
                    } else {
                        Image(systemName: "play.fill").font(.system(.title2, design: .rounded))
                    }
                }
            }
        }
        .padding()
        .foregroundColor(.black)
        .background(Color(#colorLiteral(red: 225/255, green: 240/255, blue: 245/255, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
