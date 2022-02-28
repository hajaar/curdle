//
//  ViewController.swift
//  curdle
//
//  Created by Kartik Narayanan on 28/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chosenWord: UILabel!
    @IBOutlet weak var newGame: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startGame(_ sender: UIButton) {
        chosenWord.text = K.vocalbulary.randomElement()
    }
    
}

