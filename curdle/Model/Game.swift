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
    var colorOfKeys: [matchType]

    
    
    init() {
        chosenWord = Dictionary.vocalbulary.randomElement()!
        print(chosenWord)
        guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
        colorOfKeys = [matchType](repeating: .notyet, count: 26)
        isGameWon = false
        isGameOver = false
        numberOfAttempts = 0
        wordDetails = [WordDetails](repeating: WordDetails(),  count: K.maxLengthOfWord)
        animateOnce = [Bool](repeating: true, count: K.maxNumberOfAttempts)
        isValidGuess = false
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
            let a = encodeWordString()
            guessWords = [GuessWord](repeating: GuessWord(), count: K.maxNumberOfAttempts)
            decodeWordString(s1: a.0, s2: a.1)
            return "Woohoo!. You win."
        }
        if !ableToGuess(guess) {
            isGameOver = true
            return "Sorry. All out of guesses"
        }
        return "You guessed " + guess
    }
    
    func doesWordExistInVocabulary(_ guess: String) -> Bool {
        return ((Dictionary.vocalbulary.contains(guess) ? true : false) || (Dictionary.extraVocalbulary.contains(guess) ? true : false))
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
    
    func encodeMatchType(m: matchType) -> Int {
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
    
    func decodeMatchType(c: Character) -> matchType {
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
    
    


struct WordDetails {
    var letter: String = ""
    var letterImage: UIImage {
        UIImage(systemName: (letter + K.letterTile), withConfiguration: K.largeTitle) ?? UIImage(systemName: K.defaultTile, withConfiguration: K.largeTitle)!
    }
    var letterDuration: Double = 0.1
    var letterMatch: matchType = .notyet
    var letterColor: UIColor {
        Colors.matchColor(matchtype: letterMatch)
    }
    var letterAnimation: UIView.AnimationOptions = .transitionCurlDown
    var letterAnimateOnce: Bool = true
}

struct GuessWord {
    var gText: String
    var gMatch: [matchType]
    
    init() {
        gText = ""
        gMatch = [matchType](repeating: .notyet, count: K.maxNumberOfAttempts)
    }
}

