//
//  GameStats.swift
//  curdle
//
//  Created by Kartik Narayanan on 04/03/22.
//

import Foundation
import RealmSwift


class CurdleGameStatsDataModel: Object {
    @objc dynamic var chosenWord = ""
    @objc dynamic var isGameWon = true
    @objc dynamic var noOfAttempts = 0
}
