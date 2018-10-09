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
    var handler: ((Exercise) -> Void)?
    
    override init() {
        super.init()
    }
}

extension HistroyViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
}
