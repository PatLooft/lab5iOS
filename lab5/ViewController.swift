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
    @IBOutlet weak var currentTurn: UILabel!;
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    //pressed the new game button
    @IBAction func newGameStarted(sender: UIButton){
        //re-enable buttons since game started
        print("MAde it into the function");
        holdBtn.isEnabled = true;
        rollBtn.isEnabled = true;
        p1.setIsTurn(turns: true);
        p2.setIsTurn(turns: false);
        
    }
    
    //roll button pressed
    @IBAction func rollBtnPressed(sender: UIButton){
        //logic flow: press button, receive roll, check to see if that makes user win, add score
        if(p1.getIsTurn()){
            let roll = p1.diceRoll();
            diceLabel.text = "\(roll)";
            if(roll == 1){//if 1 is rolled player must change turns
                print("Changing player turns");
                changeTurnTxt(p1: p1, p2: p2);
                //p1.changeTurns(opponent: p2);
                //call function to change turns
            }
            if(p1.incrementScore(recentRoll: roll)){
                //print winner message
                diceLabel.text = "PLAYER ONE WINS";
            }
            //update progress view
            p1ProgView.progress = (Float(p1.getScore())/100.00);
            
        }
        else if(p2.getIsTurn()){
            let roll = p2.diceRoll();
            diceLabel.text = "\(roll)";
            if(roll == 1){//if 1 is rolled player must change turns
                print("Changing player turns");
                changeTurnTxt(p1: p1, p2: p2);
                //p2.changeTurns(opponent: p1);
                //call function to change turns
            }
            if(p2.incrementScore(recentRoll: roll)){
                //print winner message
                diceLabel.text = "PLAYER ONE WINS";
            }
            p2ProgView.progress = (Float(p2.getScore())/100.00);
            
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print");
        }
    }
    
    //hold button pressed
    @IBAction func holdBtnPressed(sender: UIButton){
        if(p1.getIsTurn()){//p1's turn and chooses to hold
            changeTurnTxt(p1: p1, p2: p2);
            //p1.changeTurns(opponent: p2);
        }
        else if(p2.getIsTurn()){//p2's turn and chooses to hold
            changeTurnTxt(p1: p1, p2: p2);
            //p2.changeTurns(opponent: p1);
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print")
        }
    }
    
    func changeTurnTxt(p1: Player, p2: Player){
        if(p1.getIsTurn()){
            p1.changeTurns(opponent: p2);
            currentTurn.text = "Player 2's turn"
        }
        else if(p2.getIsTurn()){
            p2.changeTurns(opponent: p1);
            currentTurn.text = "Player 1's turn"
        }
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

