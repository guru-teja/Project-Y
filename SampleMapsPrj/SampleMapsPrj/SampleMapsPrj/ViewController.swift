//
//  ViewController.swift
//  SampleMapsPrj
//
//  Created by Ganesh on 8/22/16.
//  Copyright © 2016 Ganesh. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch: class
{
    func sPoint(placemark:MKPlacemark)
}

class ViewController: UIViewController
{
    var resultSearchController: UISearchController!
    //@IBOutlet weak var mapView: MKMapView!
    
    //@IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationSearchTable = storyboard!.instantiateViewControllerWithIdentifier("LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    
}


extension ViewController: HandleMapSearch
{
    
    func sPoint(placemark: MKPlacemark)
    {
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality, let country = placemark.country
        {
            annotation.subtitle = "\(city) \(country)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}


