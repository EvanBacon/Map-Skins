//
//  DesiignerOverlay.swift
//  CustomMap
//
//  Created by Evan Bacon on 9/24/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol TiileOverlayDataSource {
    func tiileOverlay(tilleOverlay:TiileOverlay, URLforCoords x:Int, y:Int, z:Int, andScale scale:CGFloat) -> String
}

class TiileOverlay : MKTileOverlay {
    init() {
        super.init(urlTemplate: "")
    }
    private let cache = NSCache<AnyObject, AnyObject>()
    private let operationQueue = OperationQueue()
    var dataSource:TiileOverlayDataSource?
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let x = path.x
        let y = path.y
        let z = path.z
        let s = path.contentScaleFactor
        
        guard let url = dataSource?.tiileOverlay(tilleOverlay: self, URLforCoords: x, y: y, z: z, andScale: s) else {
            return URL(string: "")!
        }
        return URL(string: url)!
    }
    
    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        guard let dataSource = dataSource else {
            result(nil, nil)
            return
        }
        
        let url = self.url(forTilePath: path)
        
        if let cachedData = cache.object(forKey: url as AnyObject) as? Data {
            result(cachedData, nil)
        } else {
            
            let req = NSMutableURLRequest(url: url)
            req.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: req as URLRequest) { data, response, error in
                if error != nil {
                    //Your HTTP request failed.
                    print(error?.localizedDescription)
                } else {
                    //Your HTTP request succeeded
                    if let data = data {
                        self.cache.setObject(data as AnyObject, forKey: url as AnyObject)
                    }

                }
                result(data, error)

                }.resume()
        }
    }
}
