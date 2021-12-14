//
//  ViewController.swift
//  Test-Final
//
//  Created by Dominik Auinger on 06.12.21.
//

import UIKit

class ViewController: UIViewController {
    
    var model: Model = Model()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.isHidden = true
        model.reset()
        super.viewDidLoad()
    }

    @IBAction func guessButtonOnTouchUpInside(_ sender: Any) {
        if let guess = textField.text {
            self.view.backgroundColor = .white
            if model.guessCount == 0 {
                imageView.isHidden = true
            }
            var returnMessage: String
            model.guessCount += 1
            switch model.eveluate(guess) {
            case 0:
                returnMessage = "You guessed correctly in \(model.guessCount) tries."
                self.view.backgroundColor = .green
                imageView.isHidden = false
            case 1:
                returnMessage = "\(guess) is bigger than the number."
            default:
                returnMessage = "\(guess) is smaller than the number."
            }
            numberLabel.text = returnMessage
        } else {
            self.view.backgroundColor = .red
        }
    }
    
    @IBAction func textFieldOnEditingChanged(_ sender: Any) {
        guessButton.isEnabled = model.isValidGuess(textField.text)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "guessShowSegue" {
            if model.eveluate(textField.text ?? "") != 0 {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resVC = segue.destination as? HistoryViewController
        resVC?.model = model
    }

}

