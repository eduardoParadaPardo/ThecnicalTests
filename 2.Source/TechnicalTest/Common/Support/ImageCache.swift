//
//  ImageCache.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 24/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import UIKit

class ImageCache {
    
    // MARK: Singleton
    
    static let shared = ImageCache()
    
    // MARK: Private properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: Public method
    
    func downloadImage(url: String, completion: @escaping (_ image: UIImage?) -> Void) {
        if let cachedImage = self.imageCache.object(forKey: url as NSString) {
            completion(cachedImage)
        } else {
            ServicesManager().downloadImag(url: url) { image in
                self.updateImage(url: url, image: image)
                completion(image)
            }
        }
    }
    
    func updateImage(url: String, image: UIImage?) {
        guard let image = image else {
            return
        }
        self.imageCache.setObject(image, forKey: url as NSString)
    }
}
