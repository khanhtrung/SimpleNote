//
//  DetailNoteViewController.swift
//  SimpleNote
//
//  Created by Tran Khanh Trung on 3/21/17.
//  Copyright © 2017 KhanhTrung. All rights reserved.
//

import UIKit

class DetailNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var DetailTextView: UITextView!
    
    var noteRef = DataService().REF_NOTES
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    @IBAction func saveNote(_ sender: Any) {
        saveNote()
    }
    
    
    func saveNote() {
        
        
        let newNote = Note(noteTitle: titleTextField.text!, noteDetail: DetailTextView.text)
        let newNoteData = newNote.toAnyObject()
        if newNoteData.isEmpty {
            return
        }
        
        // Create New Note Reference in the FirDatabase
        let noteRef = DataService.ds.REF_NOTES
        let newNoteKey = noteRef.childByAutoId().key
        let childUpdate = ["\(newNoteKey)": newNoteData]
        noteRef.updateChildValues(childUpdate)
    }

}
