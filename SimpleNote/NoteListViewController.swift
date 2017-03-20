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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // set observe to display everytime view appear (while viewdidload only excutes once)
        setObserveNoteList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // remove listener when view not appear
        noteRef.removeAllObservers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // Get all notes
    // !!! Currently cannot clear old data of tableview !!!
    func setObserveNoteList() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        noteRef
            //.queryOrdered(byChild: "\(NOTE_ROOT)")
            .observe(.value, with: {(snapshot) in
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


extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteViewCell") as! NoteViewCell
        if noteList.count > 0 {
            let note = noteList[indexPath.row]
            
            cell.titleLabel.text = note.noteTitle
            cell.detailLabel.text = note.noteDetail
        }
        return cell
    }
}
