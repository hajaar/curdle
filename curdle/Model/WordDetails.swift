//
//  WordDetails.swift
//  curdle
//
//  Created by Kartik Narayanan on 24/03/22.
//

import Foundation
import UIKit

struct WordDetails {
    var letter: String = ""
    var letterImage: UIImage {
        UIImage(systemName: (letter + K.letterTile), withConfiguration: K.largeTitle) ?? UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!
    }
    var letterDuration: Double = 0.1
    var letterMatch: matchType = .notyet
    var letterColor: UIColor {
        Colors.matchColor(matchtype: letterMatch)
    }
    var letterAnimation: UIView.AnimationOptions = .transitionCurlDown
    var letterAnimateOnce: Bool = true
}
