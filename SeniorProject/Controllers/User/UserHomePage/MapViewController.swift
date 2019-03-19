//
//  MapViewController.swift
//  SeniorProject
//
//  Created by Jiaqing Mo on 2/3/19.
//  Copyright © 2019 Jiaqing Mo. All rights reserved.
//

import UIKit
import MapKit

protocol ChangeUserLocation {
    
    func changeUserLocationZoomIn(placemark: MKPlacemark)
    
}

class MapViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {

    let annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    let defaultLocation = CLLocationCoordinate2D(latitude: 37.7840, longitude: -122.405)
    var userLocation: CLLocationCoordinate2D?
    var currentUser: CurrentUserModel?
    var postList = PostListModel()
    var poi: [PostListEntryModel] = [] { didSet { visiblePOI = poi; filterVisiblePOI() } }
    var visiblePOI: [PostListEntryModel] = []
    var selectedPin:MKPlacemark? = nil
    var resultSearchController:UISearchController? = nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let currentLocation = locationManager.location
        userLocation = currentLocation?.coordinate ?? defaultLocation
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.ChangeUserLocationDelegate = self
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.centerMapInInitialCoordinates()
        loadAnnotationsForCurrentView()
        /* postList.loadDataInRegion(longitude: 0.0, latitude: 0.0) {
            (result) in
            if result == .success {
                self.updateUIAsync {
                    self.poi = self.postList.entries
                    self.showPointsOfInterestInMap()
                }
            } else {
                self.updateUIAsync {
                    self.showAlert(withTitle: "Error", message: "Unable to load post list")
                    let destination = self.storyboard?.instantiateViewController(withIdentifier: "appHomePage") as! FirstPageViewController
                    self.navigationController?.pushViewController(destination, animated: true)
                }
            }
        } */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        filterVisiblePOI()
    }
    
    func loadAnnotationsForCurrentView() {
        let topLeftCorner = mapView.topLeftCoordinate()
        let bottomRightCorner = mapView.bottomRightCoordinate()
        print(topLeftCorner)
        print(bottomRightCorner)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func centerMapInInitialCoordinates() {
        // fixed user location at latitude: -77.01639, longitude: 38.88833
        mapView.setCenter(userLocation!, animated: true)
        let visibleRegion = MKCoordinateRegion(center: userLocation!, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(self.mapView.regionThatFits(visibleRegion), animated: true)
    }
    
    func showPointsOfInterestInMap() {
        mapView.removeAnnotations(mapView.annotations)
        
        for point in poi {
            let pin = POIAnnotation(point: point)
            //let pin = MKPointAnnotation()
            //pin.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            //pin.title = point.title
            //print(point.latitude)
            mapView.addAnnotation(pin)
        }
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is POIAnnotation else {
            return nil
        }
        
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visiblePOI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PointOfInterestCell", for: indexPath)
        
        // configure cell
        let point = visiblePOI[indexPath.row]
        cell.textLabel?.text = point.title
        //cell.detailTextLabel?.text = "(\(point.latitude), \(point.longitude))"
        cell.detailTextLabel?.text = point.address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let point = visiblePOI[indexPath.row]
        
        if let annotation = (mapView.annotations as? [POIAnnotation])?.filter({ $0.coordinate.latitude == point.latitude && $0.coordinate.longitude == point.longitude}).first {
            selectPinPointInTheMap(annotation: annotation)
        }
    }
  
    func selectPinPointInTheMap(annotation: POIAnnotation) {
        mapView.selectAnnotation(annotation, animated: true)
        if CLLocationCoordinate2DIsValid(annotation.coordinate) {
            self.mapView.setCenter(annotation.coordinate, animated: true)
        }
    }
    
    func filterVisiblePOI() {
        let visibleAnnotations = self.mapView.annotations(in: self.mapView.visibleMapRect)
        var annotations = [POIAnnotation]()
        for visibleAnnotation in visibleAnnotations {
            if let annotation = visibleAnnotation as? POIAnnotation {
                annotations.append(annotation)
            }
        }
        self.visiblePOI = annotations.map({$0.pointOfInterest})
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        filterVisiblePOI()
    }
    
}

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
}
extension MapViewController: ChangeUserLocation {
    func changeUserLocationZoomIn(placemark: MKPlacemark) {
        // cache the pin
        selectedPin = placemark
        mapView.removeAnnotation(annotation as MKAnnotation)
        //let annotation = MKAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        userLocation = (placemark.location?.coordinate)!
        let selectedLatitude =  placemark.coordinate.latitude
        let selectedLongitude = placemark.coordinate.longitude
        print(selectedLatitude)
        print(selectedLongitude)
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}
