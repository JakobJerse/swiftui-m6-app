//
//  ContentView.swift
//  City Sights App
//
//  Created by Jakob Jerse on 31/08/2021.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        // Detect the authorization status of geolocating the user
        if(model.authorizationState == .notDetermined) {
            // If undetermined, show onbording
            OnboardingView()
        }
        else if(model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse) {
            // If approved, show home view
            HomeView()
        }
        else {
            // If denied, show denied view
            LocationDeniedView()
        }
    }
}


