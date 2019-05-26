//
//  AsyncImageView.swift
//  KinopoiskSwift
//
//  Created by Аскар on 5/19/19.
//  Copyright © 2019 askar.ulubayev. All rights reserved.
//

import UIKit

class CachedImageView: UIImageView {
    
    static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
    
    open var shouldUseEmptyImage = true
    
    private var urlStringForChecking: String?
    private var emptyImage: UIImage?
    
    public convenience init(cornerRadius: CGFloat = 0, tapCallback: @escaping (() ->())) {
        self.init(cornerRadius: cornerRadius, emptyImage: nil)
        self.tapCallback = tapCallback
        backgroundColor = .lightGray
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc func handleTap() {
        tapCallback?()
    }
    
    private var tapCallback: (() -> ())?
    
    public init(cornerRadius: CGFloat = 0, emptyImage: UIImage? = nil) {
        super.init(frame: .zero)
        backgroundColor = .lightGray
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        self.emptyImage = emptyImage
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func loadImage(urlString: String?, completion: (() -> ())? = nil) {
        image = nil
        guard let nonOptionalUrlString = urlString else { return }
        self.urlStringForChecking = urlString
        
        let urlKey = nonOptionalUrlString as NSString
        
        if let cachedItem = CachedImageView.imageCache.object(forKey: urlKey) {
            image = cachedItem.image
            completion?()
            return
        }
        
        guard let url = URL(string: nonOptionalUrlString) else {
            if shouldUseEmptyImage {
                image = emptyImage
            }
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            if let image = UIImage(data: data!) {
                let cacheItem = DiscardableImageCacheItem(image: image)
                CachedImageView.imageCache.setObject(cacheItem, forKey: urlKey)
                if urlString == self?.urlStringForChecking {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?()
                    }
                }
            }
        }).resume()
    }
}
