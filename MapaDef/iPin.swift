//
//  iPin.swift
//  MapaDef
//
//  Created by user130165 on 11/30/17.
//  Copyright © 2017 KevinGonzalez. All rights reserved.
//

import Foundation

import MapKit

class iPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var  title: String?
    var subtitle: String?
    
    init(coordinate:CLLocationCoordinate2D , title : String, minortitle : String) {
        self.coordinate = coordinate
        self.title = title
        subtitle = minortitle
    }
}
