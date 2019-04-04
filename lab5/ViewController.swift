//
//  ViewController.swift
//  lab5
//
//  Created by Patrick Looft on 3/28/19.
//  Copyright © 2019 Patrick Looft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //top of screen
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
    var p1 = Player();
    var p2 = Player();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //greys out buttons upon app entry
        holdBtn.isEnabled = false;
        rollBtn.isEnabled = false;
        diceLabel.text = "";
        p1ProgView.progress = 0;
        p2ProgView.progress = 0;
        p1.setIsTurn(turns: true);
        p2.setIsTurn(turns: false);
        // Do any additional setup after loading the view, typically from a nib.
    }

    //pressed the new game button
    @IBAction func newGameStarted(sender: UIButton){
        //re-enable buttons since game started
        resetView();
        holdBtn.isEnabled = true;
        rollBtn.isEnabled = true;
        if(p1.getWonLastGame()){
            p1.setIsTurn(turns: true);
            p2.setIsTurn(turns: false);
            currentPlayer.text = "Player 1's turn";
        }
        else if(p2.getWonLastGame()){
            p2.setIsTurn(turns: true);
            p1.setIsTurn(turns: false);
            currentPlayer.text = "Player 2's turn";
        }
        else{
            p1.setIsTurn(turns: true);
            p2.setIsTurn(turns: false);
            currentPlayer.text = "Player 1's turn";
        }
    }
    
    //roll button pressed
    @IBAction func rollBtnPressed(sender: UIButton){
        //logic flow: press button, receive roll, check to see if that makes user win, add score
        if(p1.getIsTurn()){                             //player 1's turn
            let roll = p1.diceRoll();
            diceLabel.text = "\(roll)";
            if(roll == 1){
                //p1.swapTurns(player: p2);
                swapTurns(p1: p1, p2: p2);
                return;
            }
            else if(p1.incrementScore(recentRoll: roll)){
                //print winner message
                currentPlayer.text = "PLAYER ONE WINS";
                p1.setWonLastGame(turns: true);
            }
            //update progress view
            p1ProgView.progress = (Float(p1.getScore())/100.00);
            player1Score.text = "\(p1.getScore())";
        }
        else if(p2.getIsTurn()){                        //player 2's turn
            let roll = p2.diceRoll();
            if(roll == 1){
                //p2.swapTurns(player: p1);
                swapTurns(p1: p1, p2: p2);
                return;
            }
            diceLabel.text = "\(roll)";
            if(p2.incrementScore(recentRoll: roll)){
                //print winner message
                currentPlayer.text = "PLAYER TWO WINS";
                p2.setWonLastGame(turns: true);
            }
            p2ProgView.progress = (Float(p2.getScore())/100.00);
            player2Score.text = "\(p2.getScore())";
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print");
        }
    }

    
    //hold button pressed
    @IBAction func holdBtnPressed(sender: UIButton){
        if(p1.getIsTurn()){//p1's turn and chooses to hold
            //p2.swapTurns(player: p1);
            swapTurns(p1: p1, p2: p2);
        }
        else if(p2.getIsTurn()){//p2's turn and chooses to hold
            //p1.swapTurns(player: p2);
            swapTurns(p1: p1, p2: p2);
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print")
        }
    }
    
    func swapTurns(p1: Player, p2: Player){
        if(p1.getIsTurn()){
            p1.setIsTurn(turns: false);
            p2.setIsTurn(turns: true);
            currentPlayer.text = "Player 2's turn.";
            print("just ran the statement");
        }
        else if(p2.getIsTurn()){
            p2.setIsTurn(turns: false);
            p1.setIsTurn(turns: true);
            currentPlayer.text = "Player 1's turn.";
            print("just ran the statement");
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print")
        }
    }
    
    func resetView(){
        player1Score.text = "0";
        player2Score.text = "0";
        p1ProgView.progress = 0;
        p2ProgView.progress = 0;
        
    }
    /*
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
 @IBOutlet weak var p2ProgView: UIProgressView!;*/
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
