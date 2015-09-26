//
// Copyright (c) 2015 Zalando SE. All rights reserved.
//

import UIKit

public class ImageManager {

    private var downloadsInProgress = [NSURL: ImageDownloadOperation]()
    private var downloadQueue: NSOperationQueue {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 10
        return queue
    }

    public class var sharedManager: ImageManager {

        struct Singleton {
            static let instance = ImageManager()
        }

        return Singleton.instance
    }

    deinit {
        downloadQueue.cancelAllOperations()
    }

    public func downloadImageAtURL(url: NSURL, cacheScaled: Bool, imageView: UIImageView?,
                                   storage: Storage = MapleBaconStorage.sharedStorage,
                                   completion: ImageDownloaderCompletion?) -> ImageDownloadOperation? {
        if let cachedImage = storage.image(forKey: url.absoluteString!) {
            completion?(ImageInstance(image: cachedImage, state: .Cached, url: url), nil)
        } else {
            if downloadsInProgress[url] == nil {
                let downloadOperation = ImageDownloadOperation(imageURL: url)
                downloadOperation.qualityOfService = .UserInitiated
                downloadOperation.completionHandler = {
                    [unowned self] (imageInstance, _) in
                    self.downloadsInProgress[url] = nil
                    if let newImage = imageInstance?.image {
                        if cacheScaled && imageView != nil && newImage.images == nil {
                            self.resizeAndStoreImage(newImage, imageView: imageView!, storage: storage,
                                    key: url.absoluteString!)
                        } else if let imageData = imageInstance?.data {
                            storage.storeImage(newImage, data: imageData, forKey: url.absoluteString!)
                        }

                        completion?(ImageInstance(image: newImage, state: .New, url: imageInstance?.url), nil)
                    }
                }
                downloadsInProgress[url] = downloadOperation
                downloadQueue.addOperation(downloadOperation)

                return downloadOperation
            } else {
                completion?(ImageInstance(image: nil, state: .Downloading, url: nil), nil)
                delay(0.1) {
                    downloadImageAtURL(url, cacheScaled: cacheScaled, imageView: imageView, storage: storage, completion: completion)
                }
            }
        }

        return nil
    }

    private func resizeAndStoreImage(image: UIImage, imageView: UIImageView, storage: Storage, key: String) {
        Resizer.resizeImage(image, contentMode: imageView.contentMode, toSize: imageView.bounds.size,
                interpolationQuality: kCGInterpolationDefault) {
            resizedImage in
            storage.storeImage(resizedImage, data: nil, forKey: key)
        }
    }

    public func hasDownloadsInProgress() -> Bool {
        return !downloadsInProgress.isEmpty
    }

}
