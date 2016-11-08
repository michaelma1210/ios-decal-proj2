//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var hangmanImage: UIImageView!
    @IBOutlet var word: UILabel!
    @IBOutlet var guessLetter: UITextField!
    
    @IBOutlet var alreadyGuessedList: UILabel!
    
    var wordArray = [Character]()
    
    var correctGuessesList = ""
    var incorrectGuessesToDisplay = ""
    var gameIsOver = false
    var numIncorrectGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gameIsOver = false
        correctGuessesList = ""
        incorrectGuessesToDisplay = ""
        numIncorrectGuesses = 0
        guessLetter.text = ""
        alreadyGuessedList.text = incorrectGuessesToDisplay
        
        hangmanImage.image = UIImage(named: "hangman1.gif")

        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        var string = ""
        wordArray = Array(phrase!.characters)
        
        for character in wordArray {
            if character == " " {
                string += " "
                word.text =  string
            } else {
                string += "_ "
                word.text = string
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateGuess(_ sender: AnyObject) {
        
        let guess = guessLetter.text
        
        if gameIsOver == false {
            
            if (guess?.characters.count)! ==  1 {

                var guessIsCorrect = false
            
                for char in wordArray {

                    if guess?.lowercased() == String(char).lowercased() {
                        correctGuessesList.append(guess!.lowercased())
                        guessIsCorrect = true
                    
                    }
                }
            
                if guessIsCorrect == false {
                    incorrectGuessesToDisplay.append(guess! as String)

                    //incorrect guess
                    numIncorrectGuesses += 1
                
                    if numIncorrectGuesses == 1 {
                        hangmanImage.image = UIImage(named: "hangman2.gif")
                    } else if numIncorrectGuesses == 2 {
                        hangmanImage.image = UIImage(named: "hangman3.gif")
                    } else if numIncorrectGuesses == 3 {
                        hangmanImage.image = UIImage(named: "hangman4.gif")
                    } else if numIncorrectGuesses == 4 {
                        hangmanImage.image = UIImage(named: "hangman5.gif")
                    } else if numIncorrectGuesses == 5 {
                        hangmanImage.image = UIImage(named: "hangman6.gif")
                    } else if numIncorrectGuesses == 6 {
                        hangmanImage.image = UIImage(named: "hangman7.gif")
                        //you lost the game.
                        let alertController = UIAlertController(title: "Game Over", message: "You Lose!", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                        alertController.addAction(defaultAction)
                        present(alertController, animated: true, completion: nil)
                        
                        gameIsOver = true
                    }

                
                }
            
            }
            var wordToDisplay = ""
            var allAreFilled = true

            for char in wordArray {
                if correctGuessesList.contains(String(char).lowercased()) {
                    wordToDisplay.append(char)
                } else if char == " " {
                    wordToDisplay.append(" ")
                } else {
                    wordToDisplay.append("_ ")
                    allAreFilled = false
                }
            }
            word.text = wordToDisplay
            if allAreFilled == true {
                //you win the game!
                let alertController = UIAlertController(title: "Success", message: "You Win!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
                
                gameIsOver = true
                
                
            }

            
        }
        
        guessLetter.text = ""
        alreadyGuessedList.text = incorrectGuessesToDisplay

        
    }
    
    @IBAction func callStartOver(_ sender: AnyObject) {
        viewDidLoad()
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
