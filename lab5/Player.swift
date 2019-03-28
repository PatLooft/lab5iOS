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
    var score: Int;
    var name: String;
    
    init(){
        self.score = 0;
        self.name = "";
    }
    
    init(name: String){
        self.score = 0;
        self.name = name;
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
}
