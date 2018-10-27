//
//  DBCache.swift
//  DeliciousBody
//
//  Created by changmin lee on 28/10/2018.
//  Copyright © 2018 changmin. All rights reserved.
//

import Foundation
import UIKit

class DBCache: NSObject {
    static let shared = DBCache()
    var memCache: [String : UIImage]?
    
    override init() {
        super.init()
        memCache = [String : UIImage]()
        print("cache init")
    }
    func loadImage(key: String) -> UIImage? {
        if let image = memCache?[key] {
            print("mem hit")
            return image
        }
        
        let fileURL = documentsUrl.appendingPathComponent(key)
        do {
            let imageData = try Data(contentsOf: fileURL)
            print("local hit")
            let image = UIImage(data: imageData)
            memCache?[key] = image
            return image
        } catch {
            print("Error loading image : \(error)")
        }
        print("no hit")
        return nil
    }
    
    func saveImage(key: String, image: UIImage) -> Bool {
        memCache?[key] = image
        let fileURL = documentsUrl.appendingPathComponent(key)
        if let imageData = UIImageJPEGRepresentation(image, 0.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            print("saved")
            return true
        }
        print("saving flase")
        return false
    }
}
