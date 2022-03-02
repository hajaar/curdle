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
        
        var tmpString = game.guessWords[indexPath.row]
        if (tmpString != "") {
            cell.imageView1.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 0)]) + ".square.fill")
            cell.imageView2.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 1)]) + ".square.fill")
            cell.imageView3.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 2)]) + ".square.fill")
            cell.imageView4.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 3)]) + ".square.fill")
            cell.imageView5.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 4)]) + ".square.fill")

        }
        
        if (Int(indexPath.row) == game.numberOfAttempts) {
            tmpString = tmpText

            let tmpLength = K.maxLengthOfWord - tmpString.count
            for _ in 0..<tmpLength + 1 {
                tmpString += " "
            }


            if (tmpString != "") {
                cell.imageView1.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 0)]) + ".square.fill")
                cell.imageView2.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 1)]) + ".square.fill")
                cell.imageView3.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 2)]) + ".square.fill")
                cell.imageView4.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 3)]) + ".square.fill")
                cell.imageView5.image = UIImage(systemName: String(tmpString[tmpString.index(tmpString.startIndex, offsetBy: 4)]) + ".square.fill")
                
            }
            
        }
        
        
        return cell
        
        
    }
    
    
}
