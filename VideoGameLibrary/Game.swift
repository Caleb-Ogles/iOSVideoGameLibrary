//
//  Game.swift
//  VideoGameLibrary
//
//  Created by Caleb Ogles on 10/29/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import Foundation

class Game {
    //Game class that holds and initializes all the componenets to register a game into the library
    var title: String
    var description: String
    var rating: Rating
    var genre: Genre
    var availability: Availability
    
    enum Genre: String {
        case action = "Action"
        case actionAdventure = "Action Adventure"
        case rolePlaying = "Role Playing"
        case simulation = "Simulation"
        case strategy = "Strategy"
        case sports = "Sports"
        case mmo = "MMO"
        
    }
    
    enum Rating: String {
        case kids = "Kids"
        case everyone = "Everyone"
        case tenPlus = "Everyone 10+"
        case teen = "Teen"
        case mature = "Mature"
        case adultsOnly = "Adults Only"
        
        var symbol: String {
            switch self {
            case .kids: return "K"
            case .everyone: return "E"
            case .tenPlus: return "E 10+"
            case .teen: return "T"
            case .mature: return "M"
            case .adultsOnly: return "AO"
            }
        }
    }
    
    enum Availability {
        case checkedIn
        case checkedOut(dueDate: Date)
    }
    
    init(title: String, description: String, rating: Rating, genre: Genre) {
        self.title = title
        self.description = description
        self.rating = rating
        self.genre = genre
        self.availability = .checkedIn
    }
    
    
}
