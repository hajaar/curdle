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
    
    @IBAction func startNewGame(_ sender: UIButton) {
        gameSession.startNewGame()
        isNewGame = true
        guessesTableView.reloadData()

    }
    var gameSession = GameSession()
    var isNewGame: Bool = true
    var tmpText: String = ""
    var msgText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSession.startNewGame()
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        inputText.becomeFirstResponder()
        inputText.delegate = self
        inputText.returnKeyType = .done
        
        guessesTableView.delegate = self
        guessesTableView.dataSource = self
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .down:
                gameSession.startNewGame()
                isNewGame = true
            default:
                break
            }
        }
    }
    
    @IBAction func inputTextEditing(_ sender: UITextField) {
        if !gameSession.game.isGameOver {
            tmpText = inputText.text ?? ""
            isNewGame = false
            guessesTableView.reloadData()
        }
    }
    
}

extension tableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !gameSession.game.isGameOver {
            msgText = gameSession.game.checkGuess(guess: textField.text!)
            gameSession.getGameAttributes()
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
        
        if isNewGame {
            for i in 0..<K.maxLengthOfWord {
            imageArray[i].image = UIImage(systemName: "questionmark.app", withConfiguration: largeTitle)
                imageArray[i].tintColor = K.notMatchColor
            }
        } else {
            
        
        
        if (Int(indexPath.row) != gameSession.game.numberOfAttempts) || gameSession.game.isGameWon {

            tmpString = gameSession.game.guessWords[indexPath.row].gText
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
                imageArray[i].tintColor = gameSession.game.guessWords[indexPath.row].gColor[i]
         
            }
            
            i += 1
        }
        }
        return cell
   
    }
        // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                            section: Int) -> String? {
        return "CURDLE " + msgText
    }
    

}


