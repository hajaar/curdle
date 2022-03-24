//
//  EncodeDecodeGuesses.swift
//  curdle
//
//  Created by Kartik Narayanan on 24/03/22.
//

import Foundation

struct EncodeDecodeGuesses {
    private var guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
    init(guessWords: [GuessWord]) {
        self.guessWords = guessWords
    }
    
    
    func encodeWordString() -> (String, String) {
        var s1 = ""
        var s2 = ""
        guessWords.forEach { l in
            s1.append(l.gText)
            for i in 0...K.maxLengthOfWord - 1{
                s2.append(contentsOf: String(encodeMatchType(m: l.gMatch[i])))
            }
        }
        let maxLength = K.maxLengthOfWord * K.maxNumberOfAttempts
        for _ in 0...maxLength - 1 {
            
            if s1.count < maxLength {
                s1.append(" ")
            }
        }
        print("\(s1) \(s2)")
        return (s1, s2)
    }
    
    mutating func decodeWordString(s1: String, s2: String) {
        for i in 0...K.maxNumberOfAttempts - 1 {
            for j in 0...K.maxLengthOfWord - 1{
                guessWords[i].gText.append(s1[j + i * 5])
                guessWords[i].gMatch[j] = decodeMatchType(c: s2[j + i * 5])
            }
        }
        print(guessWords)
    }
    
    private func encodeMatchType(m: matchType) -> Int {
        switch m {
        case .notyet:
            return 0
        case .no:
            return 1
        case .imperfect:
            return 2
        case .perfect:
            return 3
        }
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
