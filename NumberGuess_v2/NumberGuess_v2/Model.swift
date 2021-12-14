class Model {
    var randomNumber = 0
    var guessCount = 0
    var lowerBound = 1
    var upperBound = 99
    var guesses: [Int] = []
    
    func reset() {
        randomNumber = .random(in: lowerBound...upperBound);
        guessCount = 0
        guesses = []
    }
    
    func evaluate (string: String!) -> Int! {
        return evaluate(Int(string)!)
        
    }
    
    func evaluate (_ guess: Int) -> Int! {
        return (guess - randomNumber).signum()
    }
    
    func isValidGuess (_ string: String?) -> Bool {
        let x: Int = Int(string ?? "") ?? -1
        return x >= lowerBound && x <= upperBound
    }

}
