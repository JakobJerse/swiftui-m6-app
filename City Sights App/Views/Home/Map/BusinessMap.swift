//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Jakob Jerse on 06/09/2021.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    @Binding var selecetedBusiness: Business?
    
    var locations:[MKPointAnnotation] {
        
        var annotations  = [MKPointAnnotation]()
        
        // Create a set of annotations from our list of businesses - kooridnate restavracij
        for business in model.restaurants + model.sights {  // loopamo skozi oba arraya
            
            // if the business has lat/long, create an MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                // Create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                // Add to the array
                annotations.append(a)
            }
        }
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView { // namesto some UIVIew
        
        let mapView  = MKMapView()
        
        /* The protocol delegate pattern is a commonly used pattern when working with UIKit, although less often in SwiftUI. We can call methods in the delegate to run when an event is detected, and the delegate can also be notified when an event occurs.
         */
        
        mapView.delegate = context.coordinator  // zazna tappe na annotatione in displaya dodaten info
        
        // Make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading // puscica se spreminja ko se user obraca
        
        
        return mapView
    }
    
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones based on the business - na mapi oznaci nase restavracije
        uiView.addAnnotations(self.locations)
    }
    
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations) // odstranimo pine, ki kazejo na restavracije
    }
    
    // MARK: - Coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self) // pasaamo notr BusinessMap
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var map: BusinessMap
        
        init(map: BusinessMap) {
            self.map = map
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            // If the annotations is the user blue dot, return nil
            if(annotation is MKUserLocation) {
                return nil
            }
            
            // Check if there's a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            
            if(annotationView == nil) {
                // Create a new one
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                
                annotationView.canShowCallout = true    // displaya dodaten info ob tappu
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                // We got a reusable one
                annotationView!.annotation = annotation
            }
            // Return it
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            // User tapped on the annotation view
            
            
            // Get the business object that this annotation represents
            // loop through businesses in the model and find a match
            for business in map.model.restaurants + map.model.sights {
                if(business.name == view.annotation?.title) {
                    
                    // Set the selectedBusiness property to that business object
                    map.selecetedBusiness = business
                    return
                }
            }
            
            
        }
    }
}
