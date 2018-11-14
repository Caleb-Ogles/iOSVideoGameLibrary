//
//  Library.swift
//  VideoGameLibrary
//
//  Created by Caleb Ogles on 10/29/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import Foundation

class Library {
    //Creates the array that will be used to hold the games that are stored
    //Singleton!
    static let sharedInstance = Library()
    
    var games = [Game]()
    
}
