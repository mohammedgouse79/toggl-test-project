//
//  DateFormatter.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import Foundation
func formatDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy - h:mm a"
    return dateFormatter.string(from: date)
}
