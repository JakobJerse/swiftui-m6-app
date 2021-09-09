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
    @State var selectedBusiness: Business?  // s tem bomo detectali kateri business gleda user
    
    var body: some View {
       
        if(model.restaurants.count != 0 || model.sights.count != 0) {
            
            NavigationView {
                // Determine if we should show list or map
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
                    // Show map
                    ZStack(alignment: .top) {
                        BusinessMap(selecetedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in   // poppa up ko tapnemo na annotation
                                
                                // Create a business detail view instance
                                // Pass in the selecred business
                                BusinessDetail(business: business)
                        }
                        
                        // Rectangle overlay
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                           
                            HStack {
                                Image(systemName: "location")
                                Text("San Francisco")
                                
                                Spacer()
                                Button("Switch to list view") {
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding()
                    }
                  
                }
            }
           
        }
        else {
            // Still waiting for data, so show spinner
            ProgressView()
        }
       
    }
}

