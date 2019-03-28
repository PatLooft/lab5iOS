//
//  Player.swift
//  lab5
//
//  Created by Patrick Looft on 3/28/19.
//  Copyright © 2019 Patrick Looft. All rights reserved.
//

import Foundation

let SCORE_TO_WIN = 100;

class Player{
    private var score: Int;
    private var name: String;
    private var isTurn: Bool; //set to true when it is the players turn
    
    init(){
        self.score = 0;
        self.name = "Player";
        self.isTurn = false;
    }
    
    init(name: String){
        self.score = 0;
        self.name = name;
        self.isTurn = false;
    }
    
    //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
    //HELPER METHODS//
    //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
    func diceRoll() -> Int{
        let roll = Int.random(in: 0 ... 10);
        return roll;
    }
    
    //simulates the player rolling the dice for their turn
    func turn(){
        var hold: Bool;
        hold = false;
        var roll = 0;
        while roll != 1 && !hold{
            roll = diceRoll();
            print("You rolled \(roll)");
            switch roll {
            case 1:
                print("Turn is over");
                hold = true;
            default:
                print("Hold or continue? Score is \(self.score)")
                // TODO: change logic so that it uses the UI not cmd line
                // reroute the label input here to see if they want to continue or not
                if(self.score < SCORE_TO_WIN){
                    self.score += roll;
                }
                else if(hold){
                    print("You've ended your turn with \(self.score) points.")
                }
                else{
                    print("Congratulations! \(self.name) has won with \(self.score) points!!");
                    hold = true;
                }
            }
        }//end of loop
    }//end of func
    
    
    func getScore() -> Int{
        return self.score;
    }
    
    func getName() -> String{
        return self.name;
    }
    
    func getIsTurn() -> Bool{
        return self.isTurn;
    }
    
    func setIsTurn(turns: Bool){
        self.isTurn = turns;
    }
    
    func incrementScore(recentRoll: Int) -> Bool{//returns true if user wins game
        if(self.score + recentRoll >= 100){
            return true;//indicates winner
        }
        else{
            self.score += recentRoll;
            return false;
        }
    }
    
    func setName(nom: String){
        self.name = nom;
    }
    
}
