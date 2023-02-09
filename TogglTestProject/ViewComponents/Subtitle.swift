//
//  SubtitleText.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import SwiftUI

struct Subtitle: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(Color(#colorLiteral(red: 145/255, green: 145/255, blue: 145/255, alpha: 1)))
            .font(.caption)
    }
}
