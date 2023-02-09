//
//  InforCard.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

struct InfoCard: View {
    var inProgressCount: Int
    var totalCount: Int
    var totalTime: String
    
    var body: some View {
        VStack {
            HStack {
                innerCard(text: "In Progress", data: String(inProgressCount))
                innerCard(text: "Total Activities", data: String(totalCount))
                if UIDevice.current.userInterfaceIdiom != .phone {
                    innerCard(text: "Total Time", data: totalTime)
                }
            }
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                HStack {
                    innerCard(text: "Total Time", data: totalTime)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(#colorLiteral(red: 35/255, green: 40/255, blue: 50/255, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct innerCard: View {
    var text: String
    var data: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Subtitle(text: text)
            Text(data).font(.title)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .padding()
        .background(Color(#colorLiteral(red: 50/255, green: 55/255, blue: 65/255, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
