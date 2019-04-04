//
//  ViewController.swift
//  lab5
//
//  Created by Patrick Looft on 3/28/19.
//  Copyright © 2019 Patrick Looft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //labels
    @IBOutlet weak var player1Score: UILabel!;
    @IBOutlet weak var player1Name: UILabel!;
    @IBOutlet weak var player2Score: UILabel!;
    @IBOutlet weak var player2Name: UILabel!;
    @IBOutlet weak var diceLabel: UILabel!;
    @IBOutlet weak var currentPlayer: UILabel!;
    
    //buttons
    @IBOutlet weak var holdBtn: UIButton!;
    @IBOutlet weak var rollBtn: UIButton!;
    @IBOutlet weak var newGameBtn: UIButton!;
    @IBOutlet weak var p1ProgView: UIProgressView!;
    @IBOutlet weak var p2ProgView: UIProgressView!;
    
    
    //Players:
    var p1 = Player(name: "Player 1");
    var p2 = Player(name: "Player 2");
    var turnScore = 0;                                  //used to keep track of points in current turn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //greys out buttons upon app entry
        holdBtn.isEnabled = false;
        rollBtn.isEnabled = false;
        //sets default view so almost nothing is shown
        diceLabel.text = "";
        p1ProgView.progress = 0;
        p2ProgView.progress = 0;
        //rounding those corners awwww yeah
        newGameBtn.layer.cornerRadius = 5;
        holdBtn.layer.cornerRadius = 5;
        rollBtn.layer.cornerRadius = 5;
    }

    //pressed the new game button
    @IBAction func newGameStarted(sender: UIButton){
        //re-enable buttons since game started
        rollBtn.isEnabled = true;
        //condition for seeing if games beginning
        if( (p1.getScore() == 0 &&  p2.getScore() == 0) || (p1.getScore() == 100 || p2.getScore() == 100)) {
            newGameBtn.setTitle("New Game", for: .normal);
            resetForNewGame();
            //logic to see who starts
            if(p1.getstartedLastGame()){                        //player 1 started last game
                p2.setstartedLastGame(status: true);            // so player 2 starts
                p1.setstartedLastGame(status: false);
                p2.setIsTurn(turns: true);
                p1.setIsTurn(turns: false);
                currentPlayer.text = "Player 2 - tap to begin";
            }
            else if(p2.getstartedLastGame()){                   //player 2 started last game
                p1.setstartedLastGame(status: true);            //so player 1 starts
                p2.setstartedLastGame(status: false);
                p1.setIsTurn(turns: true);
                p2.setIsTurn(turns: false);
                currentPlayer.text = "Player 1 - tap to begin";
            }
            else{                                               //default in case first two ifs aren't met
                print("In the else")
                p1.setstartedLastGame(status: true);
                p2.setstartedLastGame(status: false);
                p1.setIsTurn(turns: true);
                p2.setIsTurn(turns: false);
                currentPlayer.text = "Player 1 - tap to begin";
            }
        }
        //I was getting some weird alignment issues after the first game is played
        diceLabel.textAlignment = .center;
        newGameBtn.setTitle("Tap to continue", for: .normal);
        newGameBtn.isEnabled = false;
    }
    
    //roll button pressed
    @IBAction func rollBtnPressed(sender: UIButton){
        holdBtn.isEnabled = true;
        //logic flow: press button, receive roll, check to see if that makes user win, add score
        if(p1.getIsTurn()){
            let roll = p1.diceRoll();
            diceLabel.text = "\(roll)";
            turnScore = turnScore + roll;
            currentPlayer.text = "\(p1.getName()) - score this turn: \(turnScore)";
            if(roll == 1){//if 1 is rolled player must change turns
                holdBtn.isEnabled = false;
                rollBtn.isEnabled = false;
                newGameBtn.isEnabled = true;        //tap to change turns
                print("Changing player turns");
                turnScore = 0;
                changeTurnTxt(p1: p1, p2: p2);
                turnScore = 0;
            }
            else if(p1.incrementScore(recentRoll: roll)){//player 1 wins
                //print winner message
                diceLabel.text = "PLAYER ONE WINS";
                diceLabel.sizeToFit();
                p1.setstartedLastGame(status: true);
                p2.setstartedLastGame(status: false);
                holdBtn.isEnabled = false;
                rollBtn.isEnabled = false;
                newGameBtn.isEnabled = true;
                newGameBtn.setTitle("Play again?", for: .normal);
                p2.reset();
                p1.reset();
                
            }
            //update progress view
            p1ProgView.progress = (Float(p1.getScore())/100.00);
            player1Score.text = "\(p1.getScore())";
            
        }
        else if(p2.getIsTurn()){
            let roll = p2.diceRoll();
            diceLabel.text = "\(roll)";
            turnScore = turnScore + roll;
            currentPlayer.text = "\(p2.getName()) - score this turn: \(turnScore)";
            if(roll == 1){//if 1 is rolled player must change turns
                holdBtn.isEnabled = false;
                rollBtn.isEnabled = false;
                newGameBtn.isEnabled = true;
                print("Changing player turns");
                changeTurnTxt(p1: p1, p2: p2);
                turnScore = 0;
            }
            else if(p2.incrementScore(recentRoll: roll)){               //player 2 wins
                //print winner message
                diceLabel.text = "PLAYER TWO WINS";
                diceLabel.sizeToFit();//stretched outside of box before
                p2.setstartedLastGame(status: true);
                p1.setstartedLastGame(status: false);
                holdBtn.isEnabled = false;
                rollBtn.isEnabled = false;
                newGameBtn.isEnabled = true;
                newGameBtn.setTitle("Play again?", for: .normal);
                p2.reset();
                p1.reset();
            }
            else{//if 2-6 is rolled and they did not win
                p2ProgView.progress = (Float(p2.getScore())/100.00);
                player2Score.text = "\(p2.getScore())";
            }
        }
    }
    
    //hold button pressed
    @IBAction func holdBtnPressed(sender: UIButton){
        holdBtn.isEnabled = false;
        rollBtn.isEnabled = false;
        newGameBtn.isEnabled = true;
        if(p1.getIsTurn()){//p1's turn and chooses to hold
            changeTurnTxt(p1: p1, p2: p2);
            print("Changing player turns");
        }
        else if(p2.getIsTurn()){//p2's turn and chooses to hold
            print("Changing player turns");
            changeTurnTxt(p1: p1, p2: p2);
        }
    }
    
    //function used to swap whos turn it is and display the text stating so
    func changeTurnTxt(p1: Player, p2: Player){
        if(p1.getIsTurn()){
            p1.changeTurns(opponent: p2);
            currentPlayer.text = "Player 2's turn"
        }
        else if(p2.getIsTurn()){
            p2.changeTurns(opponent: p1);
            currentPlayer.text = "Player 1's turn"
        }
    }
    
    //reset variables so its on a clean launch
    func resetForNewGame(){
        p1ProgView.progress = 0;
        p2ProgView.progress = 0;
        player1Score.text = "0";
        player2Score.text = "0";
        diceLabel.text = "";
        diceLabel.textAlignment = .center;
        p1ProgView.progress = 0;
        p2ProgView.progress = 0;
        player1Score.text = "0";
        player2Score.text = "0";
        diceLabel.text = "";
        turnScore = 0;
    }
    

}


//LEFT OFF ON THIS IN LAB ON THURS. WAS WORKING ON THE BUTTON FUNCTIONS. SPECIFICALLY ROLL TO CHECK IF USER
//WON THE GAME. THIS IS WITHIN THE INCREMENT SCORE METHOD.

/*for checking whos turn it is
 if(p1.getIsTurn()){

 }
 else if(p2.getIsTurn()){
 
 }
 else{
    print("This case should never happen, it should always be someones turn. This shouldnt print")
 }
 */

