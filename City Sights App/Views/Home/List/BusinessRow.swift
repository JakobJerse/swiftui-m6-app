//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Jakob Jerse on 02/09/2021.
//

import SwiftUI

struct BusinessRow: View {
    
    
    @ObservedObject var business: Business
    
    var body: some View {
       
        VStack(alignment: .leading) {
            
            HStack {
                // Image
                let uiImage = UIImage(data: business.imageData ?? Data())
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 58, height: 58)
                    .cornerRadius(10)
                
                // Name and distante
                VStack(alignment: .leading) {
                    Text(business.name ?? "")
                        .bold()
                    Text(String(format: "%.1f km away", (business.distance ?? 0) / 1000 )) // "%.1f" pomeni, da zelimo izpis na eno decimalno mesto
                        .font(.caption)
                }
                
                Spacer()
                
                // Star rating and number of reviews
                VStack(alignment: .leading) {
                    Image("regular_\(business.rating ?? 0)") // da displayamo prave slike
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            
            Divider()
        }
        
        
    }
}


