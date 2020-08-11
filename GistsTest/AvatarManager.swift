//
//  AvatarManager.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 07.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

class AvatarManager {

    static var shared: AvatarManager = {
        return AvatarManager()
    }()

    private init() {}

    private let imageCache = NSCache<NSString, UIImage>()

    func getImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage)
        }

        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self?.imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                            completion(downloadedImage)
                        }
                    }
                }
            }).resume()
        }
    }
}

extension AvatarManager: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}

