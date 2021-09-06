//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by Jakob Jerse on 06/09/2021.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                
                GeometryReader() { geo in
                    
                    // Business image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        
                }
                .ignoresSafeArea(.all, edges: .top)
                
               
                
                // Open/closed indicator
                ZStack {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                }
            }
          
            
            Group {
                
                // Business Name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                
                // Loop through display address
                if(business.location != nil && business.location?.displayAddress != nil) {
                    ForEach(business.location!.displayAddress, id: \.self) { displayLine in
                        Text(displayLine!)
                            .padding(.horizontal)
                    }
                }
                
                // Rating
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                
                Divider()
                
                // Phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    
                    Spacer()
                    
                    // "tel:..." je sintaksa, ki s klikom na link odpre phone app od iphona! - podobno obstaja za mail, maps, sms, itd... (ne dela na simulatorju)
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                
                Divider()
                
                // Reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0)) // ker je int in rabimo string - pretvorimo int v string
                    
                    Spacer()
                    
                    Link("Read", destination: URL(string: "\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                
                // Website
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    
                    Spacer()
                    
                    // "tel:..." je sintaksa, ki s klikom na link odpre phone app od iphona! - podobno obstaja za mail, maps, sms, itd... (ne dela na simulatorju)
                    Link("Visit", destination: URL(string: "tel:\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
                
                
            }
            
            // Get directions button
            Button(action: {
                // TODO: Show directions
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            })
        }

    }
}

