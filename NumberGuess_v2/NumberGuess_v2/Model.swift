class Model {
    var randomNumber = 0
    var guessCount = 0
    var lowerNum = 1
    var upperNum = 100
    
    // resets game
    func reset() {
        randomNumber = .random(in: 1..<100);
        guessCount = 0;
    }
    
    // main-guess function, guesses number
    func checkGuess(_ guess: Int) -> String {
        let messageText: String
        guessCount += 1
        if guess > upperNum || lowerNum < 1 {
            messageText = "Invalid guess"
            guessCount -= 1
        } else {
            if guess == randomNumber {
                messageText = "You guessed the number in \(guessCount) guesses"
                reset()
            } else if guess > randomNumber {
                messageText = "\(guess) is bigger than the number"
            } else {
                messageText = "\(guess) is smaller than the number"
            }
        }
        return messageText
    }
    
    // does nothing, never used
    func evaluate(guess: Int) -> Int! {
        return (guess - randomNumber).signum()
    }
    
    // checks if input is valid
    func validateGuess(_ string : String?) -> Bool{
        let guess = Int(string ?? "") ?? 0
        return guess > 0 && guess <= 100
    }
}
