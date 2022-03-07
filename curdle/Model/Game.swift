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
    var wordDetails: [WordDetails]
    
    init() {
        chosenWord = K.vocalbulary.randomElement()!
        print(chosenWord)
        guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
        isGameWon = false
        isGameOver = false
        numberOfAttempts = 0
        wordDetails = [WordDetails](repeating: WordDetails(letterImage: UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!, letterDuration: 0.0, letterColor: K.notMatchColor), count: K.maxLengthOfWord)
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
        numberOfAttempts += 1
        if isGuessCorrect(guess){
            return "Woohoo!. You win."
        }
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
    
    
    mutating func getWordDetails(row: Int, typeText: String) {
        var tmpString: String = ""
        var isGuessDone = true
        let tmpTextLength = typeText.count
        
        
        
        if (row != numberOfAttempts) || isGameWon {
            
            tmpString = guessWords[row].gText
            isGuessDone = true
        } else {
            tmpString = typeText
            isGuessDone =  false
        }
        
        for _ in 0..<(K.maxLengthOfWord - tmpString.count) {
            tmpString += " "
        }
        
        for i in 0...K.maxLengthOfWord - 1 {
            wordDetails[i].letterDuration = ((!isGuessDone) && (i == tmpTextLength - 1)) ? 0.5 : 0.0
            wordDetails[i].letterImage = UIImage(systemName: (String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: i)]) + K.letterTile), withConfiguration: K.largeTitle) ?? UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!
            wordDetails[i].letterColor = guessWords[row].gColor[i]
            print(String(i))
        }
    }
}

struct WordDetails {
    var letterImage: UIImage
    var letterDuration: Double
    var letterColor: UIColor
    
}


