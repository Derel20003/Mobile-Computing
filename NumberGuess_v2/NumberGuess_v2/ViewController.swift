import UIKit

class ViewController: UIViewController {

    var model = Model()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var RockView: UIImageView!
    @IBOutlet weak var guessButton: UIButton!
    
    // Button pressed
    @IBAction func onTouchUpInside(_ sender: UIButton) {
        guess()
    }
    
    // Textfield entered
    @IBAction func textFieldEnterAction(_ sender: Any) {
        if guessButton.isEnabled {
            guess()
        }
    }
    
    // Textfield input changed
    @IBAction func textFieldChanged(_ sender: Any) {
        guessButton.isEnabled = model.validateGuess(textField.text)
    }
    
    // Load function
    override func viewDidLoad() {
        RockView.isHidden = true
        super.viewDidLoad()
        model.reset()
    }
    
    // Guess function
    func guess() {
        label.text = model.checkGuess(Int(textField.text!)!)
        if (model.guessCount == 0) {
            RockView.isHidden = false
            self.view.backgroundColor = .green
        } else if (model.guessCount == 1) {
            RockView.isHidden = true
            self.view.backgroundColor = .red
        }
    }

}

