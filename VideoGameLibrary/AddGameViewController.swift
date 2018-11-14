//
//  AddGameViewController.swift
//  VideoGameLibrary
//
//  Created by Caleb Ogles on 10/30/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit

class AddGameViewController: UIViewController {
    
    let library = Library.sharedInstance
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ratingSegmentedControl: UISegmentedControl!
    @IBOutlet weak var genrePickerView: UIPickerView!
    
    @IBAction func saveTapped(_ sender: Any) {
        trySavingGame()
        performSegue(withIdentifier: "unwindToLibraryScreen", sender: self)
    }
    
    let segments: [(title: String, rating: Game.Rating)] =
        [("K", .kids),
         ("E", .everyone),
         ("E 10+", .tenPlus),
         ("T", .teen),
         ("M", .mature),
         ("AO", .adultsOnly)]
    
    let genres: [(title: String, genre: Game.Genre)] =
        [("Action", .action),
         ("Action Adventure", .actionAdventure),
         ("Role Playing", .rolePlaying),
         ("Simulation", .simulation),
         ("Strategy", .strategy),
         ("Sports", .sports),
         ("MMO", .mmo)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        genrePickerView.dataSource = self
        genrePickerView.delegate = self
        
        ratingSegmentedControl.removeAllSegments()
        
        for (index, segment) in segments.enumerated() {
            ratingSegmentedControl.insertSegment(withTitle: segment.title, at: index, animated: false)
            
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))

    }
    

}
    
    //Function for saving a game that saves every option like the title, description, rating, and genre which then adds the new game to the array that stores them
    func trySavingGame() {
        
        //title
        guard let title = titleTextField.text else { return }
        
        //description
        guard let description = descriptionTextView.text else { return }
        
        //rating
        let rating = segments[ratingSegmentedControl.selectedSegmentIndex].rating
        
        //genre
        let genre = genres[genrePickerView.selectedRow(inComponent: genres.count)].genre
        
        library.games.append(Game(title: title, description: description, rating: rating, genre: genre))
        
    }
    

}

//Extension for the picker view that selects the genre for the game, sets up the titles for each option and makes them selectable
extension AddGameViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row].title
    }
}
