//
//  UserReservationTableViewCell.swift
//  SeniorProject
//
//  Created by Zuoyuan Huang on 3/19/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

class UserReservationTableViewCell: UITableViewCell, MKMapViewDelegate {
    
    var latitude: Double?
    var longitude: Double?
    let annotation = MKPointAnnotation()

    @IBOutlet weak var reservationEntryView: UIView!
    @IBOutlet weak var timeRateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mapView.delegate = self
        mapView.isUserInteractionEnabled = false
        reservationEntryView.layer.borderColor = UIColor(red: 0.9137, green: 0.9137, blue: 0.9137, alpha: 1.0).cgColor
        reservationEntryView.layer.borderWidth = 1.0
        reservationEntryView.layer.masksToBounds = true
        reservationEntryView.layer.cornerRadius = 4
        timeRateLabel.lineBreakMode = .byWordWrapping
        timeRateLabel.lineBreakMode = .byWordWrapping
        addressLabel.lineBreakMode = .byWordWrapping
        self.selectionStyle = UITableViewCell.SelectionStyle.none

    }

    func placeAnnotation() {
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }


}
