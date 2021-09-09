//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by Jakob Jerse on 08/09/2021.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business:Business
    
    var body: some View {
      
        VStack(alignment: .leading) {
        // Business Name
        Text(business.name!)
            .font(.largeTitle)
            
        
        // Loop through display address
        if(business.location != nil && business.location?.displayAddress != nil) {
            ForEach(business.location!.displayAddress, id: \.self) { displayLine in
                Text(displayLine!)
                
            }
        }
        
        // Rating
        Image("regular_\(business.rating ?? 0)")
        
        }
    }
}