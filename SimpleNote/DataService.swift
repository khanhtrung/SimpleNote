//
//  DataService.swift
//  SimpleNote
//
//  Created by Tran Khanh Trung on 3/21/17.
//  Copyright © 2017 KhanhTrung. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

// URL of our Firebase database
let DB_BASE = FIRDatabase.database().reference()

struct DataService {
    // Singleton
    static let ds = DataService()
    
    //DB references
    private var _REF_BASE = DB_BASE
    private var _REF_NOTES = DB_BASE.child("notes")
    
    var REF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_NOTES: FIRDatabaseReference {
        return _REF_NOTES
    }
}
