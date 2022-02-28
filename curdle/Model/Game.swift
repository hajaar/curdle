//
//  Game.swift
//  curdle
//
//  Created by Kartik Narayanan on 28/02/22.
//

import Foundation
import UIKit


struct Game {
    let chosenWord = K.vocalbulary.randomElement()
    var guesses = [String](repeating: "", count: K.maxLengthOfWord * K.maxNumberOfAttempts)
    var guessesColors = [UIColor](repeating: K.notMatchColor, count: K.maxLengthOfWord * K.maxNumberOfAttempts)
    var isGameWon: Bool = false
    var chosenChars = [String]()
    var numberOfAttempts = 0
    
    init() {
        chosenWord!.forEach { c in
            chosenChars.append(String(c))
        }
    }
    
    
    mutating func checkGuess(guess: String) -> String {
        if !doesWordExistInVocabulary(guess) {
            return guess + " is not in my vocabulary"
        }
        if isWordDuplicated(guess) {
            return "You have already guessed " + guess
        }
        if !ableToAddGuessToList(guess) {
            return "Sorry. All out of guesses"
        }
        if isGuessCorrect(guess){
            return "Woohoo!. You win."
        }
        return "You guessed " + guess
    }
    
    func doesWordExistInVocabulary(_ guess: String) -> Bool {
        if K.vocalbulary.contains(guess) {
            return true
        } else {
            return false
        }
    }
    
    func isWordDuplicated(_ guess: String) -> Bool {
        if guesses.contains(guess) {
            return true
        } else {
            return false
        }
    }
    
    mutating func ableToAddGuessToList(_ guess: String) -> Bool {
        if numberOfAttempts < K.maxNumberOfAttempts {
            numberOfAttempts += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func isGuessCorrect(_ guess: String) -> Bool {
        if guess == chosenWord {
            isGameWon =  true
            return true
        } else {
            for i in (0...(K.maxLengthOfWord - 1)) {
                if chosenWord!.contains(guess[i...i]) {
                    if chosenWord![i...i] == guess[i...i] {
                        // write code to mark the color as green
                    } else {
                        // mark color as yellow
                    }
                }
            }
            
            
            
            
            
            
        }
        
        
        
        
        return false
    }
}



