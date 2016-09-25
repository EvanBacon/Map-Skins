//
//  PandaTiileOverlay.swift
//  CustomMap
//
//  Created by Evan Bacon on 9/24/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum MapStyle:String {
    case light = "light"
    case dark = "dark"
}

class PandaTiileOverlay: NSObject {
    var labels:Bool = true
    var style:MapStyle = .light
    let overlay = TiileOverlay()
    
    init(hasLabels:Bool = true, style:MapStyle = .dark, replacesContent:Bool = true) {
        super.init()
        
        self.labels = hasLabels
        self.style = style
        /// A Flag you could flip 🇮🇱
        overlay.canReplaceMapContent = replacesContent
        overlay.dataSource = self
    }
}
extension PandaTiileOverlay: TiileOverlayDataSource {
    func tiileOverlay(tilleOverlay: TiileOverlay, URLforCoords x: Int, y: Int, z: Int, andScale scale: CGFloat) -> String {
        let labelString = labels ? "_all" : "_nolabels";
        let url = "http://\(scale).basemaps.cartocdn.com/\(style.rawValue)\(labelString)/\(z)/\(x)/\(y).png"
        print(url)
        return url
    }
}
