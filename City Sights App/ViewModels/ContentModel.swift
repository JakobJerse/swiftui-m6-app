//
//  ContentModel.swift
//  City Sights App
//
//  Created by Jakob Jerse on 31/08/2021.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    
    override init() {
        super.init() // poklicemo init funkcijo NSObjecta - kot klic konstrukotrja nadrazreda v javi
        
        // Set contrent model as the delegate of the location manager
        locationManager.delegate = self
        
        // Request permission from the user - dodatek v info.plist
        locationManager.requestWhenInUseAuthorization() // reguest location while using the app
        
      
    }
    
    // MARK - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Update the authorizationState property
        authorizationState = locationManager.authorizationStatus
        
        if( locationManager.authorizationStatus == .authorizedAlways ||
                locationManager.authorizationStatus == .authorizedWhenInUse) {
            
            // We have permission
            locationManager.startUpdatingLocation()
        }
        else if(locationManager.authorizationStatus == .denied) {
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        let userLocation = locations.first
        
        if(userLocation != nil) {
            // We have a location
            // Stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            //  If we have the coordiantes of the user, send itno Yelp API
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
        }
            
    }
    
    
    // MARK: - Yelp API methods
    
    func getBusinesses(category:String, location:CLLocation) {
        
        // Create url
        /* let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let url = URL(string: urlString)
            */
        
        var urlComponents = URLComponents(string: "\(Constants.apiUrl)")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // Get URLSession
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                // Check that there isn't an error
                if(error == nil) {
                    
                    // Parse json
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        DispatchQueue.main.async {
                            // Assign results to the appropriate property
                            switch category {
                            case Constants.sightsKey:
                                self.sights = result.businesses
                                
                            case Constants.restaurantsKey:
                                self.restaurants = result.businesses
                                
                            default:
                                break
                            }
                        }
                      
                    }
                    catch {
                        print(error)
                    }
                }
            }
            
            // Start Data Task
            dataTask.resume()
        }
    }
    
    
}
