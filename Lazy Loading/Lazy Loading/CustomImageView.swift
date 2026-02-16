//
//  CustomImageView.swift
//  Lazy Loading
//
//  Created by Droisys on 08/08/25.
//

import Foundation
import UIKit
// Shared cache for all images
let sharedImageCache = NSCache<NSString, UIImage>()

class CustomImageView : UIImageView {
    
    private var task: URLSessionDataTask?
    
    
        
    func loadImage(from url: URL, placeholder:UIImage? = UIImage(named: "picture")) {
        
        self.image = placeholder
            
            // Check cache first
            if let cachedImage = sharedImageCache.object(forKey: url.absoluteString as NSString) {
                self.image = cachedImage
                return
            }
            
            // Download image if it is not in cached
            task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else { return }
                guard let data = data, let image = UIImage(data: data), error == nil else {
                    print("Could not load image from \(url)")
                    return
                }
                
                // Save to cache
                sharedImageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                // Set image on main thread
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            
            task?.resume()
        }
    
}
