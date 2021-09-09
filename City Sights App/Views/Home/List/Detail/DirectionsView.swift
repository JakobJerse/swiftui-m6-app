//
//  Directions View.swift
//  City Sights App
//
//  Created by Jakob Jerse on 08/09/2021.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
    
    var body: some View {
      
        
        VStack(alignment: .leading) {
            HStack {
            
            // Business title
            BusinessTitle(business: business)
            Spacer()
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude, let name  = business.name {
                
                Link("Open in Maps", destination: URL(string:"http://maps.apple.com/?ll=\(lat),\(long)&q=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")!)
            }
        }
            .padding()
        
        // Directions Map
        DirectionsMap(business: business)
    }
    .ignoresSafeArea(.all, edges: .bottom)
    }
}

