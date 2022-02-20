//
//  ImageCache.swift
//  SwiftyImageCache
//
//  Created by luan on 7/31/17.
//
//  Original code from https://github.com/noblakit01/SwiftyImageCache
//  Modified by Jonas B
//
//  Copyright (c) 2017 Trần Minh Luận
//  Licensed under MIT
//

import UIKit

open class ImageCache {
    
    public static let `default` = ImageCache()
    
    private let autoCleanupDays = 60
    private var lastCleanup = UserDefaults.standard.object(forKey: "lastCleanup") as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(lastCleanup, forKey: "lastCleanup")
        }
    }
    
    let queue = DispatchQueue(label: "ImageCache")
    var workItems = NSCache<NSString, DispatchWorkItem>()
    var images = NSCache<NSString, UIImage>()
    
    open var cacheType = CacheType.disk
    
    open func set(image: UIImage, key: String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            return
        }
        cacheImage(data: data, key: key)
    }
    
    open func loadImage(atUrl url: URL, key: String, fitSize size: CGSize? = nil, completion: ((String, UIImage?) -> Void)? = nil) {
        let urlString = url.absoluteString
        let key = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? key
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard self != nil else {
                return
            }
            
            let workItem = DispatchWorkItem { [weak self] in
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            completion?(urlString, image)
                        }
                        
                        DispatchQueue.global(qos: .utility).async {
                            self?.cacheImage(data: data, key: key)
                        }
                        
                        print("set local cache")
                        
                        return
                    }
                }
                .resume()
            }
            self!.workItems.setObject(workItem, forKey: key as NSString)
            self!.queue.async(execute: workItem)
        }
    }
    
    open func image(of key: String) -> UIImage? {
        if let image = images.object(forKey: key as NSString) {
            return image
        }
        let fileURL = cacheFileUrl(key)
        do {
            let data = try Data(contentsOf: fileURL)
            let image = UIImage(data: data)
            return image
        } catch { }
        return nil
    }
    
    func cacheImage(data: Data, key: String) {
        switch cacheType {
        case .ram:
            if let image = UIImage(data: data) {
                images.setObject(image, forKey: key as NSString)
            }
        case .disk:
            let fileURL = cacheFileUrl(key)
            do {
                try data.write(to: fileURL, options: Data.WritingOptions.atomic)
            } catch let error {
                print("Error write file \(error.localizedDescription)")
            }
        }
    }
    
    open func clearLocalCache() {
        let fileManager = FileManager.default
        let imageDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        if Date().timeIntervalSince(lastCleanup) > TimeInterval(autoCleanupDays * 24 * 3600) {
            if fileManager.isDeletableFile(atPath: imageDirectory.path) {
                do {
                    try fileManager.removeItem(atPath: imageDirectory.path)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
            
            lastCleanup = Date()
        }
        
        workItems.removeAllObjects()
        images.removeAllObjects()
    }
}
