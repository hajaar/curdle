//
//  EncodeDecodeGuesses.swift
//  curdle
//
//  Created by Kartik Narayanan on 24/03/22.
//

import Foundation
import UIKit

struct EncodeDecodeGuesses {
    private var guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
    var historyWords: [HistoryWord] = [HistoryWord](repeating: HistoryWord(), count: K.maxNumberOfAttempts * K.maxNumberOfAttempts)
    

    mutating func setGuessWords(guessWords: [GuessWord]) {
        self.guessWords = guessWords
    }
    
    func encodeWordString() -> (String, String) {
        var s1 = ""
        var s2 = ""
        s1 = guessWords.reduce(""){ $0 + $1.gText}
        s1.append(String(repeating: " ", count: K.maxLengthOfWord * K.maxNumberOfAttempts - s1.count))
        s2 = guessWords.reduce(""){ $0 + $1.gMatch.reduce(""){ $0 + encodeMatchType(m: $1) }}
  //      print("\(s1) \(s2)")
        return (s1, s2)
    }
    
    mutating func decodeWordString(s1: String, s2: String) {
        for i in 0...K.maxNumberOfAttempts * K.maxLengthOfWord - 1 {

                historyWords[i].letter = String((s1[i]))
                historyWords[i].letterMatch = decodeMatchType(c: s2[i])
         //   print("s2 \(s2[i]) letterMatch \(historyWords[i].letterMatch)")

        }
     //   print("historywords letter \(historyWords)")
    }
    
    private func encodeMatchType(m: matchType) -> String {
        let s: Int
        switch m {
        case .notyet:
            s = 0
        case .no:
            s = 1
        case .imperfect:
            s = 2
        case .perfect:
            s = 3
        }
        return String(s)
    }
    
    private func decodeMatchType(c: Character) -> matchType {
        switch Int(String(c)) {
        case 0:
            return .notyet
        case 1:
            return .no
        case 2:
            return .imperfect
        case 3:
            return .perfect
        default:
            return .notyet
        }
    }
    

}

struct HistoryWord {
    var letter = ""
    var letterImage: UIImage {
            (UIImage(systemName: (letter + K.letterTile), withConfiguration: K.largeTitle) ?? UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!)
        }
        
    
    var letterMatch: matchType = .notyet
    var letterColor: UIColor {
        Colors.matchColor(matchtype: letterMatch)
    }

}
