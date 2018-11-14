//
//  LibraryViewController.swift
//  VideoGameLibrary
//
//  Created by Caleb Ogles on 10/29/18.
//  Copyright © 2018 Caleb Ogles. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class LibraryViewController: UIViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let library = Library.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
    }
    
    //functions for checking in and checking out games
    func checkOut(indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        game.availability = .checkedOut(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! LibraryCell).setup(game: game)
    }
    
    func checkIn(indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        game.availability = .checkedIn
        (tableView.cellForRow(at: indexPath) as! LibraryCell).setup(game: game)
    }
    
    @IBAction func unwindToLibraryScreen(segue: UIStoryboardSegue){}
    
}

//Extension that sets up the format for the table view and how many cells to create when a certain amount of games are added to the library
extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! LibraryCell
        
        let game = library.games[indexPath.row]
        cell.setup(game: game)
        
        return cell
        
    }
    //Delete function so when the user slides to the left on the cell the option to delete a cell appears and when selected, removes the game
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let game = library.games[indexPath.row]
        
        //Displays the check in and check out options to select and depending on which is selected the view changes color to indicate such
        switch game.availability {
        case .checkedIn:
            
            let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
                self.checkIn(indexPath: indexPath)
            }
            return [deleteAction, checkInAction]
            
        case .checkedOut:
            
            let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
                self.checkOut(indexPath: indexPath)
            }
            return [deleteAction, checkOutAction]
        }
        
    }
    
}

//An extension of the LibraryViewController class that displays a message when there are no games stored in the library and prompts to add some by pressing a button
extension LibraryViewController {
    func title(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "There are no games"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25.0), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "Tap Add Game to add a game to your library."
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView?) -> UIColor? {
        return UIColor.white
    }
}

