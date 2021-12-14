import UIKit

class ViewController: UIViewController {

    var model = Model()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func onTouchUpInside(_ sender: UIButton) {
        if let guess = textField.text {
            self.view.backgroundColor = .white
            var messageText: String!
            
            model.guessCount += 1
            model.guesses.append(Int(guess)!)
            
            switch (model.evaluate(string: guess)) {
            case 0:
                messageText = "You guessed the number in \(model.guessCount) guesses"
                //model.reset() - now in shouldPerformSegue
            case 1:
                messageText = "\(guess) is bigger than the number"
            default:
                messageText = "\(guess) is smaller than the number"
            }
            
            label.text = messageText
            
            if (model.guessCount == 0) {
                imageView.isHidden = false
            } else if (model.guessCount == 1) {
                imageView.isHidden = true
            }
        } else {
            self.view.backgroundColor = .red
        }
    }
    
    @IBAction func onEditingDidChange(_ sender: UITextField) {
        button.isEnabled = model.isValidGuess(sender.text)
    }
    
    override func viewDidLoad() {
        imageView.isHidden = true
        super.viewDidLoad()
        model.reset()
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "guessShowSegue" {
            if model.evaluate(string: textField.text ?? "") != 0 {
                return false;
            } else {
                // model.reset()
            }
        }
        return true;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

