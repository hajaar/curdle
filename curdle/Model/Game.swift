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
    var animateOnce: [Bool]
    var isValidGuess: Bool
    var colorOfKeys: [UIColor]
    var alphabetSequence: String
    
    init() {
        chosenWord = K.vocalbulary.randomElement()!
        print(chosenWord)
        guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
        colorOfKeys = [UIColor](repeating: K.unMatchColor, count: 26)
        isGameWon = false
        isGameOver = false
        numberOfAttempts = 0
        wordDetails = [WordDetails](repeating: WordDetails(letterImage: K.defaultTileImage, letterDuration: 0.1, letterColor: K.unMatchColor, letterAnimation: .transitionCurlDown, letterAnimateOnce: true),  count: K.maxLengthOfWord)
        animateOnce = [Bool](repeating: true, count: K.maxNumberOfAttempts)
        isValidGuess = false
        alphabetSequence = "abcdefghijklmnopqrstuvwxyz"
    }
    
    mutating func checkGuess(guess: String) -> String {
        isValidGuess = false
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
        return ((K.vocalbulary.contains(guess) ? true : false) || (K.extraVocalbulary.contains(guess) ? true : false))
    }
    
    func isWordDuplicated(_ guess: String) -> Bool {
        return guessWords.filter({$0.gText == (guess)}).isEmpty ? false : true
    }
    
    mutating func addGuessToList(_ guess: String) {
        guessWords[numberOfAttempts].gText = guess
        isValidGuess = true
    }
    
    func ableToGuess(_ guess: String) -> Bool {
        return (numberOfAttempts < K.maxNumberOfAttempts ? true : false)
    }
    
    mutating func findMatchingLetters(_ guess: String) {
        for i in (0...(K.maxLengthOfWord - 1)) {
            let tmpLetter = guess[guess.index(guess.startIndex, offsetBy: i)]
            let alphabetPosition = K.getAlphabetPosition(s: String(tmpLetter))
            print(alphabetPosition)
            let alphabetColor = colorOfKeys[alphabetPosition]
            
            if chosenWord.contains(tmpLetter) {
                guessWords[numberOfAttempts].gColor[i] = chosenWord[chosenWord.index(guess.startIndex, offsetBy: i)] == tmpLetter ? K.perfectMatchColor : K.imperfectMatchColor
                    let newColor = guessWords[numberOfAttempts].gColor[i]
                switch alphabetColor {
                case K.perfectMatchColor:
                    return
                case K.imperfectMatchColor:
                    if newColor == K.perfectMatchColor {
                        colorOfKeys[alphabetPosition] = newColor
                    }
                case K.notMatchColor:
                    if newColor == K.perfectMatchColor || newColor == K.imperfectMatchColor{
                        colorOfKeys[alphabetPosition] = newColor
                    }
                case K.unMatchColor:
                    colorOfKeys[alphabetPosition] = newColor
                default:
                    colorOfKeys[alphabetPosition] = K.unMatchColor
                }
            } else {
                colorOfKeys[alphabetPosition] = K.notMatchColor
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
        
  //      print("getWordDetails \(typeText)")
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
            
            if (isGuessDone) {
                if (row == numberOfAttempts - 1) && animateOnce[numberOfAttempts - 1] {
                    wordDetails[i].letterAnimation = .transitionCurlDown
                    wordDetails[i].letterDuration = 0.5
                    if i == K.maxLengthOfWord - 1 {
                        animateOnce[numberOfAttempts - 1] = false
                    }
                } else {
                    wordDetails[i].letterDuration = 0.0
                }
            } else {
                if (i == tmpTextLength - 1) {
                    wordDetails[i].letterAnimation = .transitionFlipFromTop
                    wordDetails[i].letterDuration = 0.5
                } else {
                    wordDetails[i].letterDuration = 0.0
                }
            }
            wordDetails[i].letterImage = UIImage(systemName: (String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: i)]) + K.letterTile), withConfiguration: K.largeTitle) ?? UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!
            wordDetails[i].letterColor = guessWords[row].gColor[i]
        }

    }
}

struct WordDetails {
    var letterImage: UIImage
    var letterDuration: Double
    var letterColor: UIColor
    var letterAnimation: UIView.AnimationOptions
    var letterAnimateOnce: Bool
}

struct GuessWord {
    var gText: String
    var gColor: [UIColor]
    
    init() {
        gText = ""
        gColor = [UIColor](repeating: K.notMatchColor, count: K.maxNumberOfAttempts)
    }
}

