//
//  ViewController.swift
//  CH8-4_FetchAllPhotos
//
//  Created by Chung-I Wu on 2019/7/12.
//  Copyright © 2019 Chung-I Wu. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let imgs = fetchAllPhotos()
        fetchAllPhotos2() { imgs in
            print(imgs.count)
        }
    }

    /** This will cause using out of memory */
    func fetchAllPhotos() -> [UIImage] {
        var images = [UIImage]()
        let fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        
        for n in 0..<fetchResult.count {
            let imgAsset = fetchResult.object(at: n)
            let size = CGSize(width: imgAsset.pixelWidth, height: imgAsset.pixelHeight)
            let requestOptions = PHImageRequestOptions()
            requestOptions.deliveryMode = .fastFormat
            requestOptions.isSynchronous = true
            PHImageManager.default().requestImage(for: imgAsset,
                                                  targetSize: size,
                                                  contentMode: .default,
                                                  options: requestOptions,
                                                  resultHandler: {(image, nil) in
                images.append(image!)
            })
        }
        return images
    }
    
    
    func fetchAllPhotos2(handler: @escaping ([UIImage]) -> Void) {
        var images = [UIImage]()
        let fetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        let queue = DispatchQueue.init(label: "fetchPhotos")
        let group = DispatchGroup()
        
        for n in 0..<fetchResult.count {
            queue.sync {
                group.enter()
                let imgAsset = fetchResult.object(at: n)
                let size = CGSize(width: imgAsset.pixelWidth, height: imgAsset.pixelHeight)
                let requestOptions = PHImageRequestOptions()
                requestOptions.deliveryMode = .fastFormat
                requestOptions.isSynchronous = true
                PHImageManager.default().requestImage(for: imgAsset,
                                                      targetSize: size,
                                                      contentMode: .default,
                                                      options: requestOptions,
                                                      resultHandler: {(image, nil) in
//                                                        images.append(image!)
                                                        print(n)
                                                        group.leave()
                })

            }
            group.wait()
        }
        
        group.notify(queue: queue, execute: {
            handler(images)
        })
    }
    
    func fetchCustomAlbumPhotos() -> [UIImage] {
        let albumName = "Album Name Here"
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult<AnyObject>()
        let fetchOptions = PHFetchOptions()
        var images = [UIImage]()
        fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let firstObject = collection.firstObject{
            //found the album
            assetCollection = firstObject
            albumFound = true
        }
        else { albumFound = false }
        _ = collection.count
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        photoAssets.enumerateObjects{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset,
                                          targetSize: imageSize,
                                          contentMode: .aspectFill,
                                          options: options,
                                          resultHandler: {
                                            (image, info) -> Void in
                                            images.append(image!)
                                            
                })
                
            }
        }
        
        return images
    }
    
}

