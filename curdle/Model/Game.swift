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
    var guesses = [Guess](repeating: Guess(gText: "", gColor: K.notMatchColor), count: K.maxLetters)
    var guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
    var isGameWon: Bool = false
    var numberOfAttempts = 0
    var letterPosition = 0
    

    
    mutating func checkGuess(guess: String) -> String {
        if !doesWordExistInVocabulary(guess) {
            return guess + " is not in my vocabulary"
        }
        if isWordDuplicated(guess) {
            return "You have already guessed " + guess
        }
        if !ableToGuess(guess) {
            return "Sorry. All out of guesses"
        }
        findMatchingLetters(guess)
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
        for i in 0..<K.maxNumberOfAttempts {
            if guessWords[i].gText == guess {
                return true
            }
        }
        return false
    }
    
    
    mutating func ableToGuess(_ guess: String) -> Bool {
        if numberOfAttempts < K.maxNumberOfAttempts {
            guessWords[numberOfAttempts].gText = guess
            numberOfAttempts += 1
            
            return true
        } else {
            return false
        }
    }
    
    mutating func findMatchingLetters(_ guess: String) {
        for i in (0...(K.maxLengthOfWord - 1)) {
            guesses[letterPosition].gText = String(guess[guess.index(guess.startIndex, offsetBy: i)])
            if chosenWord!.contains(guess[guess.index(guess.startIndex, offsetBy: i)]) {
                if chosenWord![chosenWord!.index(guess.startIndex, offsetBy: i)] == guess[guess.index(guess.startIndex, offsetBy: i)] {
                    guesses[letterPosition].gColor = K.perfectMatchColor
                } else {
                    guesses[letterPosition].gColor = K.imperfectMatchColor
                }
                
            }
            letterPosition += 1
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

struct Guess {
    var gText: String
    var gColor: UIColor
}

struct GuessWord {
    var gText: String
    var gColor: [UIColor]
    
    init() {
        gText = ""
        gColor = [UIColor]()
        for _ in 0..<K.maxNumberOfAttempts {
            gColor.append(K.notMatchColor)
        }
    }
}
