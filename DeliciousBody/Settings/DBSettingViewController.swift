//
//  DBSettingViewController.swift
//  DeliciousBody
//
//  Created by changmin lee on 2018. 9. 8..
//  Copyright © 2018년 changmin. All rights reserved.
//

import UIKit

class DBSettingViewController: UIViewController {
    
    var sampleData: [(BodyType, Int)] = []
    var max = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        sampleData = [(.neck, 20), (.chest, 18), (.abdomen, 14), (.thigh, 3), (.calf, 10), (.arm, 6), (.back, 16), (.hip, 10)]
    }
}

extension DBSettingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DBRecordCell
        let row = indexPath.row
        let data = sampleData[row]
        cell.configure(type: data.0, percent: Float(data.1) / Float(max), record: data.1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count
    }
}
