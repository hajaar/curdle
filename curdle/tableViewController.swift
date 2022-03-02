    //
    //  tableViewController.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 02/03/22.
    //

import UIKit

class tableViewController: UIViewController {
    
    
    @IBOutlet weak var messagesLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var guessesTableView: UITableView!
    
    
    var game = Game()
    var tmpText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.becomeFirstResponder()
        inputText.delegate = self
        inputText.returnKeyType = .done
        
        guessesTableView.delegate = self
        guessesTableView.dataSource = self
        
        print(game.chosenWord!)
        
    }
    
    @IBAction func inputTextEditing(_ sender: UITextField) {
        tmpText = inputText.text ?? ""
        guessesTableView.reloadData()
    }
    
}

extension tableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !game.isGameWon {
            messagesLabel.text = game.checkGuess(guess: textField.text!)
            textField.text = ""
            tmpText = ""
        }
        guessesTableView.reloadData()
        return true
    }
}

extension tableViewController: UITableViewDelegate {
    
}

extension tableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return game.guessWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! guessTableViewCell
        
        var tmpString: String = ""
        var isGuessDone = true
        var tmpTextLength = tmpText.count
        
        if (Int(indexPath.row) != game.numberOfAttempts) {
            tmpString = game.guessWords[indexPath.row]
            isGuessDone = true
        } else {
            tmpString = tmpText
            isGuessDone =  false
        }
        
        
        let tmpLength = K.maxLengthOfWord - tmpString.count
        for _ in 0..<tmpLength {
            tmpString += " "
        }
        
        let largeTitle = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let imageArray = [cell.imageView1!, cell.imageView2!, cell.imageView3!, cell.imageView4!, cell.imageView5!]
        
        var i = 0
        if isGuessDone {
            i = 0
            tmpString.forEach { c in
                imageArray[i].image = UIImage(systemName: String(c) + ".square.fill", withConfiguration: largeTitle)
                i += 1
            }
        } else {
            i = 0
            tmpString.forEach { c in
                
                
                
                if (i == tmpTextLength - 1) {
                    UIView.transition(with: imageArray[i],
                                      duration: 0.75,
                                      options: .transitionCrossDissolve,
                                      animations: { imageArray[i].image = UIImage(systemName: String(c) + ".square.fill", withConfiguration: largeTitle) },
                                      completion: nil)
                } else {
                    imageArray[i].image = UIImage(systemName: String(c) + ".square.fill", withConfiguration: largeTitle)
                }
                i += 1
            }
        }
        
        
        
        
        
        
        
        return cell
        
        
    }
    
    
}
