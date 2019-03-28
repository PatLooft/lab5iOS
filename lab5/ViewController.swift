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
    
    //buttons
    @IBOutlet weak var holdBtn: UIButton!;
    @IBOutlet weak var rollBtn: UIButton!;
    @IBOutlet weak var newGameBtn: UIButton!;
    
    //Players:
    var p1 = Player();
    var p2 = Player();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //greys out buttons upon app entry
        holdBtn.isEnabled = false;
        rollBtn.isEnabled = false;
        diceLabel.text = "";
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func newGameStarted(sender: UIButton){
        //re-enable buttons since game started
        holdBtn.isEnabled = true;
        rollBtn.isEnabled = true;
        
        //create two player objects
        
    }
    
    @IBAction func rollBtnPressed(sender: UIButton){
        //logic flow: press button, receive roll, check to see if that makes user win, add score
        if(p1.getIsTurn()){
            let roll = p1.diceRoll();
            diceLabel.text = "\(roll)";
            if(p1.incrementScore(recentRoll: roll)){
                //print winner message
                diceLabel.text = "PLAYER ONE WINS";
            }
        }
        else if(p2.getIsTurn()){
            let roll = p2.diceRoll();
            diceLabel.text = "\(roll)";
            if(p2.incrementScore(recentRoll: roll)){
                //print winner message
                diceLabel.text = "PLAYER ONE WINS";
            }
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print");
        }
    }
    
    @IBAction func holdBtnPressed(sender: UIButton){
        if(p1.getIsTurn()){//p1's turn and chooses to hold
            p2.setIsTurn(turns: true);
            p1.setIsTurn(turns: false);
        }
        else if(p2.getIsTurn()){//p2's turn and chooses to hold
            p1.setIsTurn(turns: true);
            p2.setIsTurn(turns: false);
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print")
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
