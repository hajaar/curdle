//
//  Game.swift
//  curdle
//
//  Created by Kartik Narayanan on 28/02/22.
//

import Foundation


struct Game {
    let chosenWord = K.vocalbulary.randomElement()
    var guesses = [String]()
    var isGameWon: Bool = false
    
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
        if guesses.count < 5 {
            guesses.append(guess)
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
            return false
        }
    }
}
