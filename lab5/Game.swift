//
//  Game.swift
//  lab5
//
//  Created by Patrick Looft on 4/1/19.
//  Copyright © 2019 Patrick Looft. All rights reserved.
//

import Foundation


class Game{
    
    var players: [Player] = [];
    var score: Int = 0;
    var roll : Int = 0;
    
    init(){
        
        
    }
    
    func addPlayer(name: String){
        self.players.append(Player(name: name));
    }
    
    //random number 1 to 6
    /*func diceRoll() -> Int{
        let roll = Int.random(in: 1 ... 6);
        if(roll == 1){
            //change player turn
            //make function to change players turn
        }
        else{
            //add to players total
        }
        
        return roll;
    }*/
    
 }
