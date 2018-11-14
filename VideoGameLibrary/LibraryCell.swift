//
//  LibraryCell.swift
//  VideoGameLibrary
//
//  Created by Caleb Ogles on 11/1/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit

class LibraryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var availabilityView: UIView!
    
    func setup(game: Game) {
        //Sets up the labels in the cell to display what the user enters
        titleLabel.text = game.title
        genreLabel.text = game.genre.rawValue
        ratingLabel.text = game.rating.symbol
        
        switch game.availability {
            //checks to see if the game is available and acts accordingly depending on which is true
        case .checkedIn:
            dueDateLabel.isHidden = true
            availabilityView.backgroundColor = .green
            
        case .checkedOut(let date):
            dueDateLabel.isHidden = false
            availabilityView.backgroundColor = .red
            
            //Sets up date to look a certain way when the due date is shown (DateFormatter)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dueDateLabel.text = dateFormatter.string(from: date)
        }
        
    }
    
}
