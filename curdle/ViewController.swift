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
        inputText.autocorrectionType = .no

    }


    
}

public extension String {
    subscript(value: Int) -> Character {
        self[index(at: value)]
    }
}

public extension String {
    subscript(value: NSRange) -> Substring {
        self[value.lowerBound..<value.upperBound]
    }
}

public extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        self[..<index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        self[...index(at: value.upperBound)]
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        self[index(at: value.lowerBound)...]
    }
}

private extension String {
    func index(at offset: Int) -> String.Index {
        index(startIndex, offsetBy: offset)
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let t: String = textField.text {
            textField.text = String(t.prefix(K.maxLengthOfWord))
        }
        let guess = textField.text!
        messagesLabel.text = game.checkGuess(guess: guess)
 //       print(game.guesses)
        textField.text = ""
        return true
    }
}


