//
//  HomeView.swift
//  City Sights App
//
//  Created by Jakob Jerse on 01/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    
    var body: some View {
       
        if(model.restaurants.count != 0 || model.sights.count != 0) {
            
            // Determine if we shoukd show list or map
            if(!isMapShowing) {
                // Show List
                
                VStack {
                    HStack {
                        Image(systemName: "location")
                        Text("San Francisco")
                        
                        Spacer()
                        Text("Switch to MapView")
                    }
                    Divider()
                    BusinessList()
                }
                .padding([.horizontal, .top])
            }
            else {
                // Show Map
            }
        }
        else {
            // Still waiting for data, so show spinner
            ProgressView()
        }
       
    }
}

