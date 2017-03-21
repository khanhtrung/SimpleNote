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
    @IBOutlet weak var detailTextView: UITextView!
    
    var noteData: Note!
    var noteRef = DataService().REF_NOTES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if noteData != nil {
            titleTextField.text = noteData.Title
            detailTextView.text = noteData.Detail
            detailTextView.sizeToFit()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func saveAction(_ sender: Any) {
        // Add new note
        if noteData == nil {
            addNote()
        } else {
            // Update existing note
            updateNote()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func addNote() {
        let newNote = Note(noteTitle: titleTextField.text!, noteDetail: detailTextView.text)
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
    
    func updateNote() {
        // Create New Note Reference in the FirDatabase
        let noteRef = DataService.ds.REF_NOTES
        noteData.Update(title: titleTextField.text!, detail: detailTextView.text)
        noteRef.child(noteData.Key).setValue(noteData.toAnyObject())
    }
}
