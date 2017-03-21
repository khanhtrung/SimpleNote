//
//  NoteListViewController.swift
//  SimpleNote
//
//  Created by Tran Khanh Trung on 3/21/17.
//  Copyright © 2017 KhanhTrung. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MBProgressHUD

class NoteListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var noteList = [Note]()
    var noteRef = DataService().REF_NOTES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Remove the UITableViewCell separator for empty cells
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Set observe to display everytime view appear (while viewdidload only excutes once)
        setObserveNoteList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Remove listener when view not appear
        noteRef.removeAllObservers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Note cell clicked
        if segue.identifier == "updateNote" {
            let noteCell = sender as! NoteViewCell
            let indexPath = tableView.indexPath(for: noteCell)
            let note = noteList[(indexPath?.row)!]
            
            let detailNoteViewController = segue.destination as! DetailNoteViewController
            detailNoteViewController.noteData = note
        }
    }
    
    // Get all notes
    func setObserveNoteList() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        noteRef.observe(.value, with: {(snapshot) in
            var newNotes = [Note]()
            for note in snapshot.children {
                let newNote = Note(snapshot: note as! FIRDataSnapshot)
                newNotes.insert(newNote, at: 0)
            }
            self.noteList = newNotes
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }) {(error) in
            print(error.localizedDescription)
        }
    }
}

// Extend TableViewController
extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteViewCell") as! NoteViewCell
        if noteList.count > 0 {
            let note = noteList[indexPath.row]
            
            cell.titleLabel.text = note.Title
            cell.detailLabel.text = note.Detail
            
            // Disable selection highlighting
            //cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //noteList.remove(at: indexPath.row)
        //tableView.reloadData()
        
        let noteKey = noteList[indexPath.row].Key
        noteRef.child(noteKey).removeValue()
    }
}
