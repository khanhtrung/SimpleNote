//
//  Note.swift
//  SimpleNote
//
//  Created by Tran Khanh Trung on 3/21/17.
//  Copyright © 2017 KhanhTrung. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

let NOTE_TITLE = "note-title"
let NOTE_DETAIL = "note-detail"

class Note{
    private var _noteRef: FIRDatabaseReference!
    
    private(set) var noteKey: String!
    private(set) var noteTitle: String!
    private(set) var noteDetail: String!
    // Init
    init(noteTitle: String, noteDetail: String) {
        self.noteTitle = noteTitle
        self.noteDetail = noteDetail
    }
    
    // Init with key and Dict data
    init(noteKey: String, noteData: Dictionary <String, AnyObject>) {
        self.noteKey = noteKey
        
        if let noteTitle = noteData[NOTE_TITLE] as? String {
            self.noteTitle = noteTitle
        }
        
        if let noteDetail = noteData[NOTE_DETAIL] as? String {
            self.noteDetail = noteDetail
        }
    }
    
    // Init to parse data from snapshot
    init(snapshot: FIRDataSnapshot) {
        self.noteKey = snapshot.key
        
        let dict = snapshot.value as? Dictionary <String, AnyObject>
        //print("TRUNG: ---- \(snapshot.value!)")
        //print(dict!)
        if let noteTitle = dict![NOTE_TITLE] as? String {
            self.noteTitle = noteTitle
        }
        
        if let noteDetail = dict![NOTE_DETAIL] as? String {
            self.noteDetail = noteDetail
        }
        
        _noteRef = snapshot.ref
    }
    
    func toAnyObject() -> [String: AnyObject] {
        return [NOTE_TITLE: noteTitle as AnyObject,
                NOTE_DETAIL: noteDetail as AnyObject
        ]
    }
    
}
