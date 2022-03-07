    //
    //  tableViewController.swift
    //  curdle
    //
    //  Created by Kartik Narayanan on 02/03/22.
    //

import UIKit


class tableViewController: UIViewController {
    
    
    
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
        
        
        inputText.becomeFirstResponder()
        inputText.delegate = self
        inputText.returnKeyType = .done
        
        guessesTableView.delegate = self
        guessesTableView.dataSource = self
    }
    

    
    @IBAction func inputTextEditing(_ sender: UITextField) {
        if !gameSession.game.isGameOver {
            tmpText = inputText.text ?? ""
            isNewGame = false
            guessesTableView.reloadData()
        }
        if gameSession.game.isGameOver {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    @IBAction func shareImage(_ sender: UIButton) {
        
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: guessesTableView.bounds.width, height: guessesTableView.bounds.height),
            false,
            2
        )
        
        guessesTableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
            //  UIImageWriteToSavedPhotosAlbum(screenshot, self, #selector(imageWasSaved), nil)
        
        let messageStr = gameSession.getGameStatsForLabel()
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [screenshot, messageStr], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! resultsViewController
            destinationVC.resultGameStats = gameSession.gameStats
        }
    }
    
}

extension tableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !gameSession.game.isGameOver {
            msgText = gameSession.game.checkGuess(guess: textField.text!)
            gameSession.setGameAttributes()
            textField.text = ""
            tmpText = ""
        }
        guessesTableView.reloadData()
        if gameSession.game.isGameOver {
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
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
        
        let imageArray = [cell.imageView1!, cell.imageView2!, cell.imageView3!, cell.imageView4!, cell.imageView5!]
        
        gameSession.game.getWordDetails(row: indexPath.row, typeText: tmpText)
        
        for i in 0...K.maxLengthOfWord - 1 {
            UIView.transition(with: imageArray[i],
                              duration: gameSession.game.wordDetails[i].letterDuration,
                              options: .transitionFlipFromTop,
                              animations: { imageArray[i].image = self.gameSession.game.wordDetails[i].letterImage },
                              completion: nil)
            imageArray[i].tintColor = gameSession.game.wordDetails[i].letterColor
            
        }
        
        
        return cell
        
    }
        // Create a standard header that includes the returned text.
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect.init(x: 10, y: 5, width: headerView.frame.width/2 - 10, height: headerView.frame.height-10)
        nameLabel.font = .systemFont(ofSize: 20)
        nameLabel.textColor = K.notMatchColor
        let gamesPlayedLabel = UILabel()
        gamesPlayedLabel.frame = CGRect.init(x: 10 + headerView.frame.width / 2, y: 5, width: headerView.frame.width / 2 - 20, height: headerView.frame.height-10)
        gamesPlayedLabel.font = .systemFont(ofSize: 20)
        gamesPlayedLabel.textAlignment = .right
        gamesPlayedLabel.textColor = K.perfectMatchColor
        
        
        headerView.addSubview(nameLabel)
        headerView.addSubview(gamesPlayedLabel)
        
        nameLabel.text = K.appName
        gamesPlayedLabel.text = gameSession.getGameStatsForLabel()
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}


