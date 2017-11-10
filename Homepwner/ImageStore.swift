//
//  ImageStore.swift
//  Homepwner
//
//  Created by sajiner on 2017/11/10.
//  Copyright © 2017年 张鑫. All rights reserved.
//

import UIKit

class ImageStore {
    var cache = NSCache<NSString, UIImage>()
    
    //MARK: - 添加image
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    //MARK: - 获取image
    func image(forKey key: String) -> UIImage? {
        let image = cache.object(forKey: key as NSString)
        return image
    }
    
    //MARK: - 删除image
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
}
