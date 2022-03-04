//
//  GuessWord.swift
//  curdle
//
//  Created by Kartik Narayanan on 04/03/22.
//

import Foundation
import UIKit

struct GuessWord {
    var gText: String
    var gColor: [UIColor]
    
    init() {
        gText = ""
        gColor = [UIColor](repeating: K.notMatchColor, count: K.maxNumberOfAttempts)
    }
}
