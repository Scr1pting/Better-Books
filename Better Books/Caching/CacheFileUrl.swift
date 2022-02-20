//
//  CacheFileUrl.swift
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

import Foundation

func cacheFileUrl(_ fileName: String) -> URL {
    let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    return cacheURL.appendingPathComponent(fileName)
}
