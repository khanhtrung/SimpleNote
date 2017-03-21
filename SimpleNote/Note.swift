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
    
    private(set) var _key: String!
    private(set) var _title: String!
    private(set) var _detail: String!
    
    var Key: String {
        return _key
    }
    var Title: String {
        return _title
    }
    var Detail: String {
        return _detail
    }
    
    
    // Init
    init(noteTitle: String, noteDetail: String) {
        self._title = noteTitle
        self._detail = noteDetail
    }
    
    // Init with key and Dict data
    init(noteKey: String, noteData: Dictionary <String, AnyObject>) {
        self._key = noteKey
        
        if let noteTitle = noteData[NOTE_TITLE] as? String {
            self._title = noteTitle
        }
        
        if let noteDetail = noteData[NOTE_DETAIL] as? String {
            self._detail = noteDetail
        }
    }
    
    // Init to parse data from snapshot
    init(snapshot: FIRDataSnapshot) {
        self._key = snapshot.key
        
        let dict = snapshot.value as? Dictionary <String, AnyObject>
        if let noteTitle = dict![NOTE_TITLE] as? String {
            self._title = noteTitle
        }
        
        if let noteDetail = dict![NOTE_DETAIL] as? String {
            self._detail = noteDetail
        }
        
        _noteRef = snapshot.ref
    }
    
    func toAnyObject() -> [String: AnyObject] {
        return [NOTE_TITLE: _title as AnyObject,
                NOTE_DETAIL: _detail as AnyObject
        ]
    }
    
    func Update(title: String, detail: String) {
        self._title = title
        self._detail = detail
    }
}
