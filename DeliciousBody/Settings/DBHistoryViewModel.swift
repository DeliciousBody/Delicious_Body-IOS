//
//  DBHistoryViewModel.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 9..
//  Copyright © 2018년 changmin. All rights reserved.
//
import Foundation
import UIKit

class HistoryViewModelItem {
    var count: Int {
        return exercises.count
    }
    var exercises: [Exercise]
    init(exercises: [Exercise]) {
        self.exercises = exercises
    }
}

class HistroyViewModel: NSObject {
    var item = HistoryViewModelItem(exercises: [])
    var handler: ((IndexPath, Exercise) -> Void)?
    
    override init() {
        super.init()
        item.exercises = []
    }
    
    func reload() {
        item.exercises = DBHistoryManager.loadHistory()
    }
}

extension HistroyViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DBHistoryCell
        let exer = item.exercises[indexPath.row]
        cell.configure(exer: exer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.handler?(IndexPath(row: indexPath.row, section: 0), item.exercises[indexPath.row])
    }
}
