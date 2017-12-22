//
//  ViewController.swift
//  MapaDef
//
//  Created by user130165 on 11/30/17.
//  Copyright © 2017 KevinGonzalez. All rights reserved.
//

import UIKit
import MapKit

var paisSelecinado = ""

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var myMap: MKMapView!
    {
        didSet{
            myMap.delegate = self
            myMap.mapType = .standard
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFile(filename: "lugares")
        checkSelection()
        createAnnotations()
    }
    var datos : [[String]] = []
    
    var seleccion = ""

    func createAnnotations()
    {
        var Pines : [iPin] = []
        for linea in datos{
            let name = linea[1]
            let continente = linea[0]
            let lat = CLLocationDegrees (Double (linea[2])!)
            let long = CLLocationDegrees (Double (linea[3])!)
            let ubicacion : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let myPin = iPin(coordinate: ubicacion, title: name, minortitle: continente)
            if continente == seleccion
            {
                if (name == "Portugal" || name == "Ukraine" || name == "Greece"
                || name == "Iceland" || name == "South_Africa" || name == "Morocco" || name == "Somalia" || name == "Senegal" || name == "Falkland Islands" || name == "Chile" || name  == "Greenland" || name == "Canada" || name  == "French Polynesia" || name  == "Russia" || name == "Turkey" || name  == "Singapore" || name  == "Japan" || name  == "Australia" || name == "New Zealand" || name == "Indonesia" || name == "Marshall Islands")
                {
                    Pines.append(myPin)
                }
            }
            myMap.addAnnotation(myPin)
            myMap.showAnnotations(Pines, animated: true)
        }
    }
    
    
    
    func readFile (filename : String)
    {
        let path = Bundle.main.path(forResource: filename, ofType: "txt")
        let fileMngr = FileManager.default
        if fileMngr.fileExists(atPath: path!)
        {
            do{
                let fulltxt = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                var reading  = fulltxt.components(separatedBy: "\n") as [String]
                datos.removeAll();
                for i in 0 ..< reading.count
                {
                    reading[i] = reading[i].replacingOccurrences(of: "\"", with: "")
                    reading[i] = reading[i].replacingOccurrences(of: "\r", with: "")
                    datos.append(reading[i].components(separatedBy: ",") as [String])
                }
                datos.removeLast()
            }
            catch let error as NSError{
                print(error)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationIdentifier)
        if view == nil
        {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationIdentifier)
            view.canShowCallout = true
        }
        else
        {
            view.annotation = annotation
        }
        view.leftCalloutAccessoryView = nil
        if let bandera = UIImage(named: annotation.title!!)
        {
            view.leftCalloutAccessoryView = UIButton(frame: Constants.LetfCalloutFrame)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let button = view.leftCalloutAccessoryView as? UIButton, let image = UIImage(named: (view.annotation?.title!!)!)
        {
            button.setImage(image, for: .normal)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView
        {
            paisSelecinado = (view.annotation?.title!!)!
            performSegue(withIdentifier: Constants.ShowImageSegue, sender: view)
        }
    }
    

    
    func checkSelection()
    {
        switch elegido {
        case 0:
            seleccion = "Africa"
        case 1:
            seleccion = "America"
        case 2:
            seleccion = "Asia"
        case 3:
            seleccion = "Europa"
        case 4:
            seleccion = "Oceania"
        default:
            seleccion = "Oceania"
        }
    }
    
    
    private struct Constants
    {
        static let LetfCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationIdentifier = "iPin"
        static let ShowImageSegue = "Show Image"
        static let EditUserPoint = "Edit"
    }


}

