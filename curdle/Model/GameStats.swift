//
//  GameStats.swift
//  curdle
//
//  Created by Kartik Narayanan on 04/03/22.
//

import Foundation

struct GameStats {
    var gamesPlayed = 0
    var winPercent = 0.0
    var currentStreak = 0
    var maxStreak = 0
    var attemptDistribution = [Int](repeating: 0, count: K.maxNumberOfAttempts)
}
