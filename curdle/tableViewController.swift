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
    
    var gameSession = GameSession()
    var game = Game()
    var tmpText: String = ""
    var msgText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputText.becomeFirstResponder()
        inputText.delegate = self
        inputText.returnKeyType = .done
        
        guessesTableView.delegate = self
        guessesTableView.dataSource = self
        
        print(game.chosenWord)
        
    }
    
    @IBAction func inputTextEditing(_ sender: UITextField) {
        if !game.isGameOver {
            tmpText = inputText.text ?? ""
            guessesTableView.reloadData()
        }
    }
    
}

extension tableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !game.isGameOver {
            msgText = game.checkGuess(guess: textField.text!)
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
        return K.maxNumberOfAttempts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! guessTableViewCell
        let largeTitle = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40), scale: .large)
        
        let imageArray = [cell.imageView1!, cell.imageView2!, cell.imageView3!, cell.imageView4!, cell.imageView5!]
        var tmpString: String = ""
        var isGuessDone = true
        let tmpTextLength = tmpText.count
        
        if (Int(indexPath.row) != game.numberOfAttempts) || game.isGameWon {

            tmpString = game.guessWords[indexPath.row].gText
            isGuessDone = true
        } else {
            tmpString = tmpText
            isGuessDone =  false
        }
        
        
     
        for _ in 0..<(K.maxLengthOfWord - tmpString.count) {
            tmpString += " "
        }
        
        
        
        var i = 0
        tmpString.forEach { c in
            
            if (!isGuessDone) {
                if (i == tmpTextLength - 1) {
                    UIView.transition(with: imageArray[i],
                                      duration: 0.50,
                                      options: .transitionFlipFromTop,
                                      animations: { imageArray[i].image = UIImage(systemName: String(c) + ".square.fill", withConfiguration: largeTitle) },
                                      completion: nil)
                } else {
                    imageArray[i].image = UIImage(systemName: String(c) + ".square.fill", withConfiguration: largeTitle)
                }
            } else {

                imageArray[i].image = UIImage(systemName: String(c) + ".square.fill", withConfiguration: largeTitle)
                imageArray[i].tintColor = game.guessWords[indexPath.row].gColor[i]


                
            }
            
            i += 1
        }
        
        
        
        
        
        
        
        return cell
        
        
    }
        // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                            section: Int) -> String? {
        return "CURDLE " + msgText
    }
    

}


