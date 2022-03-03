    //
    //  Game.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 28/02/22.
    //

import Foundation
import UIKit


struct Game {
    var chosenWord: String
    var guessWords: [GuessWord]
    var isGameWon: Bool
    var isGameOver: Bool
    var numberOfAttempts: Int
    
    init() {
        chosenWord = K.vocalbulary.randomElement()!
        guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
        isGameWon = false
        isGameOver = false
        numberOfAttempts = 0
    }
    
    
    mutating func checkGuess(guess: String) -> String {
        
        if !doesWordExistInVocabulary(guess) {
            return guess + " is not in my vocabulary"
        }
        if isWordDuplicated(guess) {
            return "You have already guessed " + guess
        }
        addGuessToList(guess)
        findMatchingLetters(guess)
        if isGuessCorrect(guess){
            return "Woohoo!. You win."
        }
        numberOfAttempts += 1
        if !ableToGuess(guess) {
            isGameOver = true
            return "Sorry. All out of guesses"
        }
        return "You guessed " + guess
    }
    
    func doesWordExistInVocabulary(_ guess: String) -> Bool {
        return (K.vocalbulary.contains(guess) ? true : false)
    }
    
    func isWordDuplicated(_ guess: String) -> Bool {
        for i in 0..<K.maxNumberOfAttempts {
            if guessWords[i].gText == guess {
                return true
            }
        }
        return false
    }
    
    mutating func addGuessToList(_ guess: String) {
        guessWords[numberOfAttempts].gText = guess
    }
    
    func ableToGuess(_ guess: String) -> Bool {
        return (numberOfAttempts < K.maxNumberOfAttempts ? true : false)
    }
    
    mutating func findMatchingLetters(_ guess: String) {
        for i in (0...(K.maxLengthOfWord - 1)) {
            if chosenWord.contains(guess[guess.index(guess.startIndex, offsetBy: i)]) {
                if chosenWord[chosenWord.index(guess.startIndex, offsetBy: i)] == guess[guess.index(guess.startIndex, offsetBy: i)] {
                    guessWords[numberOfAttempts].gColor[i] = K.perfectMatchColor
                } else {
                    guessWords[numberOfAttempts].gColor[i] = K.imperfectMatchColor
                }
                
            }
        }
    }
    
    mutating func isGuessCorrect(_ guess: String) -> Bool {
        if guess == chosenWord {
            isGameWon =  true
            isGameOver = true
            return true
        }
        return false
    }
    
}



struct GuessWord {
    var gText: String
    var gColor: [UIColor]
    
    init() {
        gText = ""
        gColor = [UIColor](repeating: K.notMatchColor, count: K.maxNumberOfAttempts)
    }
}
