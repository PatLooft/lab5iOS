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
    private var wonLastGame: Bool;
    
    init(){
        self.score = 0;
        self.name = "Player";
        self.isTurn = false;
        self.wonLastGame = false;
    }
    
    init(name: String){
        self.score = 0;
        self.name = name;
        self.isTurn = false;
        self.wonLastGame = false;
    }
    
    //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
    //HELPER METHODS//
    //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
    func diceRoll() -> Int{
        let roll = Int.random(in: 1 ... 6);
        return roll;
    }
    
    //simulates the player rolling the dice for their turn
    func turn(){
        var roll = 0;
        while roll != 1 && self.getIsTurn(){
            roll = diceRoll();
            print("You rolled \(roll)");
            switch roll {
            case 1:                                         //turn over because of 1
                print("Turn is over");
                self.setIsTurn(turns: false);
            default:
                if(self.incrementScore(recentRoll: roll)){//won game if true
                    self.setWonLastGame(turns: true);
                    print("Congratulations! \(self.name) has won with \(self.score) points!!");
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
    
    func getWonLastGame() -> Bool{
        return self.wonLastGame;
    }
    
    func setWonLastGame(turns: Bool){
        self.wonLastGame = turns;
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
    
    /*func swapTurns(player: Player){
        if(self.getIsTurn()){
            self.setIsTurn(turns: false);
            player.setIsTurn(turns: true);
        }
        else if(player.getIsTurn()){
            player.setIsTurn(turns: false);
            self.setIsTurn(turns: true);
        }
        else{
            print("This case should never happen, it should always be someones turn. This shouldnt print")
        }
    }*/
    
}
