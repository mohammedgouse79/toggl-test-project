//
//  FormatTime.swift
//  TogglTestProject
//
//  Created by Nihal on 09/02/23.
//

import Foundation

func FormatTime(timeInSeconds: Double) -> String {
    let hours = Int(timeInSeconds / 3600)
    let minutes = Int((timeInSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
    let seconds = Int(timeInSeconds.truncatingRemainder(dividingBy: 60))
    
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}
