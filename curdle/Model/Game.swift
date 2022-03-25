    //
    //  Game.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 28/02/22.
    //



import Foundation
import UIKit



struct Game {
    var chosenWord: String = Dictionary.vocalbulary.randomElement()!
    var guessWords: [GuessWord] = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
    var isGameWon: Bool = false
    var isGameOver: Bool = false
    var numberOfAttempts: Int = 0
    var wordDetails: [WordDetails] = [WordDetails](repeating: WordDetails(),  count: K.maxLengthOfWord)
    var animateOnce: [Bool] = [Bool](repeating: true, count: K.maxNumberOfAttempts)
    var isValidGuess: Bool = false
    var colorOfKeys: [matchType] = [matchType](repeating: .notyet, count: 26)

    

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
    
    private func doesWordExistInVocabulary(_ guess: String) -> Bool {
        return ((Dictionary.vocalbulary.contains(guess) ? true : false) || (Dictionary.extraVocalbulary.contains(guess) ? true : false))
    }
    
    private func isWordDuplicated(_ guess: String) -> Bool {
        return guessWords.filter({$0.gText == (guess)}).isEmpty ? false : true
    }
    
    private mutating func addGuessToList(_ guess: String) {
        guessWords[numberOfAttempts].gText = guess
        isValidGuess = true
    }
    
    private func ableToGuess(_ guess: String) -> Bool {
        return (numberOfAttempts < K.maxNumberOfAttempts ? true : false)
    }
    
    private mutating func findMatchingLetters(_ guess: String) {
        for i in (0...(K.maxLengthOfWord - 1)) {
            let tmpLetter = guess[i]
            let alphabetPosition = K.getAlphabetPosition(s: String(tmpLetter))
            // print(alphabetPosition)
            let alphabetMatch = colorOfKeys[alphabetPosition]
            
            if chosenWord.contains(guess[i]) {
                guessWords[numberOfAttempts].gMatch[i] = chosenWord[i] == guess[i] ? .perfect : .imperfect

                let newMatch = guessWords[numberOfAttempts].gMatch[i]
                switch alphabetMatch {
                case .perfect:
                    colorOfKeys[alphabetPosition] = .perfect
                case .imperfect:
                    if newMatch == .perfect {
                        colorOfKeys[alphabetPosition] = newMatch
                    }
                case .no:
                    if newMatch == .perfect || newMatch == .imperfect{
                        colorOfKeys[alphabetPosition] = newMatch
                    }
                case .notyet:
                    colorOfKeys[alphabetPosition] = newMatch
                }
            } else {

                if alphabetMatch != .perfect && alphabetMatch != .imperfect{
                    colorOfKeys[alphabetPosition] = .no
                    guessWords[numberOfAttempts].gMatch[i] = .no
                }
            }
     /*       print(" numberOfAttempts \(numberOfAttempts)")
            print("gText \(guessWords[numberOfAttempts].gText)")
            print("i \(i)")
            print("tmpLetter \(tmpLetter)")
            print("gColor[i] \(guessWords[numberOfAttempts].gColor[i])") */
        }
    }
    
    private mutating func isGuessCorrect(_ guess: String) -> Bool {
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
                wordDetails[i].letter = String(tmpString[i])
             //   print(wordDetails[i].letter)
            } else {
                if (i == tmpTextLength - 1) {
                    wordDetails[i].letterAnimation = .transitionFlipFromTop
                    wordDetails[i].letterDuration = 0.5
                } else {
                    wordDetails[i].letterDuration = 0.0
                }
            }
            wordDetails[i].letter = String(tmpString[i])
            wordDetails[i].letterMatch = guessWords[row].gMatch[i]
       //     print(wordDetails[i].letterMatch)
        }

    }
    
    
    
}
    
struct GuessWord {
    var gText: String = ""
    var gMatch: [matchType] = [matchType](repeating: .notyet, count: K.maxLengthOfWord)
    var gMatchCombined: String {
        return gMatch.reduce(""){ $0 + encodeMatchType(m: $1) }
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
        print("\(gText) \(gMatch) \(m) \(s)")
        return String(s)
    }
}

