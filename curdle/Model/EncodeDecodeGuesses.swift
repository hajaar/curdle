//
//  EncodeDecodeGuesses.swift
//  curdle
//
//  Created by Kartik Narayanan on 24/03/22.
//

import Foundation
import UIKit

struct EncodeDecodeGuesses {
    var historyGuesses: [(UIImage, UIColor)] = []
    

    func encodeWordString(guessWords: [GuessWord]) -> (String, String) {
        var s1 = guessWords.reduce(""){ $0 + $1.gText}
        s1.append(String(repeating: " ", count: K.maxLengthOfWord * K.maxNumberOfAttempts - s1.count))
        let s2 = guessWords.reduce(""){ $0 + $1.gMatch.reduce(""){ $0 + K.getMatchValue(key: $1) }}
  //      print("\(s1) \(s2)")
        return (s1, s2)
    }
    
    mutating func decodeWordString(s1: String, s2: String) {
        historyGuesses = []
        for i in 0...K.maxNumberOfAttempts * K.maxLengthOfWord - 1 {
            historyGuesses.append((UIImage(systemName: (String((s1[i])) + K.letterTile), withConfiguration: K.largeTitle) ?? UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!,Colors.matchColor(matchtype: K.getMatchKey(value: s2[i]))))


        }
     //   print("historywords letter \(historyWords)")
    }

}

