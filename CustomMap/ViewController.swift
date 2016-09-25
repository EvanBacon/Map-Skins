//
//  ViewController.swift
//  CustomMap
//
//  Created by Evan Bacon on 7/11/16.
//  Copyright © 2016 Brix. All rights reserved.
//

import UIKit
import MapKit

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let map = MKMapView(frame:self.view.bounds)
        map.delegate = self
        self.view.addSubview(map)
        
        let tiileOverlay = PandaTiileOverlay(hasLabels: false, style: .dark)

        map.add(tiileOverlay.overlay, level: .aboveRoads) // .aboveLabels
    }
}
