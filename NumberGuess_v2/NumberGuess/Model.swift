//
//  Model.swift
//  Test-Final
//
//  Created by Dominik Auinger on 06.12.21.
//

class Model {
    
    var randomNum = 0
    var guessCount = 0
    let lowest = 1
    let highest = 99
    
    func reset() {
        randomNum = .random(in: lowest...highest)
        guessCount = 0
    }
    
    func eveluate(_ guess: String!) -> Int! {
        return (Int(guess)! - randomNum).signum()
    }
    
    func isValidGuess(_ guess: String!) -> Bool! {
        let x = Int(guess ?? "") ?? -1
        return x >= lowest && x <= highest
    }
    
}
