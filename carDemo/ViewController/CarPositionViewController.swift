//
//  CarPositionViewController.swift
//  carDemo
//
//  Created by 丁健 on 2018/9/20.
//  Copyright © 2018年 丁健. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import MapKit

class CarPositionViewController: UIViewController, MKMapViewDelegate {
    var requestUrl: String?
    var dataJson: JSON?
    var markArray: Array<MKAnnotation>?
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getCarListRequest(sUrl: self.requestUrl!)
    }
    
    class PlaceMarks {
        var name: String = ""
        var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
        
//        override init(name: String, coordinates: CLLocationCoordinate2D) {
//            self.name = name
//            self.coordinates = coordinates
//        }
        
    }
    
    
    func getCarListRequest(sUrl : String) {
        Alamofire.request(sUrl).responseJSON { (response) in
            switch response.result.isSuccess {
            case true:
                if let value = response.result.value {
                    let json = JSON(value)
                    self.dataJson = json
                    print(json)
                    self.addAnnotation()
                }
            case false:
                print(response.result.error ?? "ddd")
            }
            print(response.response!)
        };
    }
    
    func addAnnotation(){
        for (index,mark):(String,JSON) in self.dataJson!["placemarks"] {
//            let placemark:PlaceMarks = PlaceMarks()
//            placemark.name = mark["name"].string ?? ""
//            markArray?.append(placemark)
            print(index)
            let annotation:MKPointAnnotation = MKPointAnnotation.init()
            annotation.coordinate = CLLocationCoordinate2DMake(mark["coordinates"][1].doubleValue, mark["coordinates"][0].doubleValue)
            annotation.title = mark["name"].string
            self.map.addAnnotation(annotation)
        }
    }

}

extension CarPositionViewController {
    
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let idetifier = "carpostion"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: idetifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: idetifier)
        }
        let imageCar = UIImage(named: "icon_car_driverposition")
        annotationView?.annotation = annotation
        annotationView?.image = imageCar
        return annotationView
    }
}
