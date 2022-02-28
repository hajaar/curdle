//
//  ViewController.swift
//  curdle
//
//  Created by Kartik Narayanan on 28/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label12: UILabel!
    @IBOutlet weak var label13: UILabel!
    @IBOutlet weak var label14: UILabel!
    @IBOutlet weak var label15: UILabel!
    @IBOutlet weak var label21: UILabel!
    @IBOutlet weak var label22: UILabel!
    @IBOutlet weak var label23: UILabel!
    @IBOutlet weak var label24: UILabel!
    @IBOutlet weak var label25: UILabel!
    @IBOutlet weak var label31: UILabel!
    @IBOutlet weak var label32: UILabel!
    @IBOutlet weak var label33: UILabel!
    @IBOutlet weak var label34: UILabel!
    @IBOutlet weak var label35: UILabel!
    @IBOutlet weak var label41: UILabel!
    @IBOutlet weak var label42: UILabel!
    @IBOutlet weak var label43: UILabel!
    @IBOutlet weak var label44: UILabel!
    @IBOutlet weak var label45: UILabel!
    @IBOutlet weak var label51: UILabel!
    @IBOutlet weak var label52: UILabel!
    @IBOutlet weak var label53: UILabel!
    @IBOutlet weak var label54: UILabel!
    @IBOutlet weak var label55: UILabel!
    @IBOutlet weak var label61: UILabel!
    @IBOutlet weak var label62: UILabel!
    @IBOutlet weak var label63: UILabel!
    @IBOutlet weak var label64: UILabel!
    @IBOutlet weak var label65: UILabel!
    /* Have to replace these dumb labels with a collection view later*/
    
    
    
    
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var messagesLabel: UILabel!
    
    
    var game = Game()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
        inputText.returnKeyType = .done
        print(game.chosenWord!)
        
    }
    
    func updateLabels() {
        label11.text = game.guesses[0]
        label12.text = game.guesses[1]
        label13.text = game.guesses[2]
        label14.text = game.guesses[3]
        label15.text = game.guesses[4]
        label21.text = game.guesses[5]
        label22.text = game.guesses[6]
        label23.text = game.guesses[7]
        label24.text = game.guesses[8]
        label25.text = game.guesses[9]
        label31.text = game.guesses[10]
        label32.text = game.guesses[11]
        label33.text = game.guesses[12]
        label34.text = game.guesses[13]
        label35.text = game.guesses[14]
        label41.text = game.guesses[15]
        label42.text = game.guesses[16]
        label43.text = game.guesses[17]
        label44.text = game.guesses[18]
        label45.text = game.guesses[19]
        label51.text = game.guesses[20]
        label52.text = game.guesses[21]
        label53.text = game.guesses[22]
        label54.text = game.guesses[23]
        label55.text = game.guesses[24]
        label61.text = game.guesses[25]
        label62.text = game.guesses[26]
        label63.text = game.guesses[27]
        label64.text = game.guesses[28]
        label65.text = game.guesses[29]
    }
    func updateColors() {
        label11.backgroundColor = game.guessesColors[0]
        label12.backgroundColor = game.guessesColors[1]
        label13.backgroundColor = game.guessesColors[2]
        label14.backgroundColor = game.guessesColors[3]
        label15.backgroundColor = game.guessesColors[4]
        label21.backgroundColor = game.guessesColors[5]
        label22.backgroundColor = game.guessesColors[6]
        label23.backgroundColor = game.guessesColors[7]
        label24.backgroundColor = game.guessesColors[8]
        label25.backgroundColor = game.guessesColors[9]
        label31.backgroundColor = game.guessesColors[10]
        label32.backgroundColor = game.guessesColors[11]
        label33.backgroundColor = game.guessesColors[12]
        label34.backgroundColor = game.guessesColors[13]
        label35.backgroundColor = game.guessesColors[14]
        label41.backgroundColor = game.guessesColors[15]
        label42.backgroundColor = game.guessesColors[16]
        label43.backgroundColor = game.guessesColors[17]
        label44.backgroundColor = game.guessesColors[18]
        label45.backgroundColor = game.guessesColors[19]
        label51.backgroundColor = game.guessesColors[20]
        label52.backgroundColor = game.guessesColors[21]
        label53.backgroundColor = game.guessesColors[22]
        label54.backgroundColor = game.guessesColors[23]
        label55.backgroundColor = game.guessesColors[24]
        label61.backgroundColor = game.guessesColors[25]
        label62.backgroundColor = game.guessesColors[26]
        label63.backgroundColor = game.guessesColors[27]
        label64.backgroundColor = game.guessesColors[28]
        label65.backgroundColor = game.guessesColors[29]
    }
    
}





extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !game.isGameWon {
            messagesLabel.text = game.checkGuess(guess: textField.text!)
            //print(game.chosenWord!)
            //print(game.guesses)
            // print(game.guessesColors)
            updateLabels()
            updateColors()
            textField.text = ""
        }
        return true
    }
}


