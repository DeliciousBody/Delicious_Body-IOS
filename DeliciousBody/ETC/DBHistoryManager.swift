//
//  DBHistoryManager.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 10. 8..
//  Copyright © 2018년 changmin. All rights reserved.
//

import Foundation
import RealmSwift

class DBHistoryManager: NSObject {
    static func addHistory(exercise: Exercise?) {
        guard let exercise = exercise else { return }
        let realm = try! Realm()
        try! realm.write {
            exercise.updatedat = Date()
            realm.add(exercise, update: true)
        }
    }
    
    static func loadHistory() -> [Exercise] {
        let realm = try! Realm()
        let result = Array(realm.objects(Exercise.self))
        return result.sorted(by: { (exer1, exer2) -> Bool in
            return exer1.updatedat > exer2.updatedat
        })
    }
    
    static func resetHistory() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
