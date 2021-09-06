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
            
            NavigationView {
                // Determine if we shoukd show list or map
                if(!isMapShowing) {
                    // Show List
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text("San Francisco")
                            
                            Spacer()
                            Button("Switch to Map View") {
                                self.isMapShowing = true
                            }
                        }
                        Divider()
                        BusinessList()
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                }
                else {
                    BusinessMap()
                        .ignoresSafeArea()
                }
            }
           
        }
        else {
            // Still waiting for data, so show spinner
            ProgressView()
        }
       
    }
}

