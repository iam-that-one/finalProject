//
//  MapViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 03/01/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var offer : Offer? = nil
    let map = MKMapView()
    var cordinat = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    lazy var dismissMapView : UIButton = {
        $0.setTitle("إخفاء", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.backgroundColor = UIColor(red: 249/255, green: 195/255, blue: 34/255, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(dismissBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewDidLoad() {
        super.viewDidLoad()
        cordinat =  CLLocationCoordinate2D(latitude: offer!.lat, longitude: offer!.log)
        print("My",cordinat.latitude, cordinat.longitude)
        
        map.frame = view.bounds
        view.backgroundColor = .white
        view.addSubview(map)
        map.addSubview(dismissMapView)
        map.delegate = self
        addPin()
        map.setRegion(MKCoordinateRegion(center: cordinat, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        dismissMapView.bottomAnchor.constraint(equalTo: map.safeAreaLayoutGuide.bottomAnchor,constant: -20).isActive = true
        dismissMapView.centerXAnchor.constraint(equalTo: map.centerXAnchor).isActive = true
        dismissMapView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        dismissMapView.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    func addPin(){
        let pin = MKPointAnnotation()
        pin.coordinate = cordinat
        pin.title = offer!.title
        pin.subtitle = offer!.description
        map.addAnnotation(pin)
        
        
    }
    @objc func dismissBtnClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else{
            return nil
        }
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "myMap")
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "myMap")
            annotationView?.canShowCallout = true
        }else{
            annotationView?.annotation = annotation
        }
        let pinImage = UIImage(data: offer!.image1)
        let size = CGSize(width: 100, height: 100
        )
               UIGraphicsBeginImageContext(size)
               pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
               let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView!.image = resizedImage
        return annotationView
    }
    internal func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
            let latitude: CLLocationDegrees = Double(offer!.lat)
            let longitude: CLLocationDegrees = Double(offer!.log)
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        
            let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = offer!.title
        mapItem.phoneNumber = "+966547105745"
            mapItem.openInMaps(launchOptions: options)
        }
}
