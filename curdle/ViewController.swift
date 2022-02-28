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
        label11.text = game.guesses[0].gText
        label12.text = game.guesses[1].gText
        label13.text = game.guesses[2].gText
        label14.text = game.guesses[3].gText
        label15.text = game.guesses[4].gText
        label21.text = game.guesses[5].gText
        label22.text = game.guesses[6].gText
        label23.text = game.guesses[7].gText
        label24.text = game.guesses[8].gText
        label25.text = game.guesses[9].gText
        label31.text = game.guesses[10].gText
        label32.text = game.guesses[11].gText
        label33.text = game.guesses[12].gText
        label34.text = game.guesses[13].gText
        label35.text = game.guesses[14].gText
        label41.text = game.guesses[15].gText
        label42.text = game.guesses[16].gText
        label43.text = game.guesses[17].gText
        label44.text = game.guesses[18].gText
        label45.text = game.guesses[19].gText
        label51.text = game.guesses[20].gText
        label52.text = game.guesses[21].gText
        label53.text = game.guesses[22].gText
        label54.text = game.guesses[23].gText
        label55.text = game.guesses[24].gText
        label61.text = game.guesses[25].gText
        label62.text = game.guesses[26].gText
        label63.text = game.guesses[27].gText
        label64.text = game.guesses[28].gText
        label65.text = game.guesses[29].gText
        label11.backgroundColor = game.guesses[0].gColor
        label12.backgroundColor = game.guesses[1].gColor
        label13.backgroundColor = game.guesses[2].gColor
        label14.backgroundColor = game.guesses[3].gColor
        label15.backgroundColor = game.guesses[4].gColor
        label21.backgroundColor = game.guesses[5].gColor
        label22.backgroundColor = game.guesses[6].gColor
        label23.backgroundColor = game.guesses[7].gColor
        label24.backgroundColor = game.guesses[8].gColor
        label25.backgroundColor = game.guesses[9].gColor
        label31.backgroundColor = game.guesses[10].gColor
        label32.backgroundColor = game.guesses[11].gColor
        label33.backgroundColor = game.guesses[12].gColor
        label34.backgroundColor = game.guesses[13].gColor
        label35.backgroundColor = game.guesses[14].gColor
        label41.backgroundColor = game.guesses[15].gColor
        label42.backgroundColor = game.guesses[16].gColor
        label43.backgroundColor = game.guesses[17].gColor
        label44.backgroundColor = game.guesses[18].gColor
        label45.backgroundColor = game.guesses[19].gColor
        label51.backgroundColor = game.guesses[20].gColor
        label52.backgroundColor = game.guesses[21].gColor
        label53.backgroundColor = game.guesses[22].gColor
        label54.backgroundColor = game.guesses[23].gColor
        label55.backgroundColor = game.guesses[24].gColor
        label61.backgroundColor = game.guesses[25].gColor
        label62.backgroundColor = game.guesses[26].gColor
        label63.backgroundColor = game.guesses[27].gColor
        label64.backgroundColor = game.guesses[28].gColor
        label65.backgroundColor = game.guesses[29].gColor
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
            textField.text = ""
        }
        return true
    }
}


