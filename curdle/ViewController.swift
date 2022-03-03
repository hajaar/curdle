//
//  ViewController.swift
//  curdle
//
//  Created by Kartik Narayanan on 28/02/22.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var messagesLabel: UILabel!
    
    private let itemsPerRow: CGFloat = 5
    var game = Game()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputText.delegate = self
        inputText.returnKeyType = .done
        collectionView.dataSource = self
        collectionView.delegate = self

        print(game.chosenWord!)
        
    }
    

    
    
}





extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputText.becomeFirstResponder()
        if !game.isGameWon {
            messagesLabel.text = game.checkGuess(guess: textField.text!)
            self.collectionView.reloadData()
            textField.text = ""
        }
        return true
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.guessWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: indexPath) as! WordCell
        let largeTitle = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        //cell.wordImage.image = UIImage(systemName: String(game.guesses[indexPath.row].gText + ".square.fill"), withConfiguration: largeTitle)
//        cell.wordImage.tintColor = game.guesses[indexPath.row].gColor
//        UIView.transition(with: cell.wordImage,
//                          duration: 0.75,
//                          options: .transitionCrossDissolve,
//                          animations: { cell.wordImage.image = UIImage(systemName: String(self.game.guesses[indexPath.row].gText + ".square.fill"), withConfiguration: largeTitle) },
//                          completion: nil)
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = K.sectionInsets.left * CGFloat(K.maxLengthOfWord + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(K.maxLengthOfWord)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return K.sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return K.sectionInsets.left
    }
}
