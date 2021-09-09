//
//  YelpAttribution.swift
//  City Sights App
//
//  Created by Jakob Jerse on 09/09/2021.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link: String
    
    var body: some View {
        
        Link(destination: URL(string: link)!, label: {
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
        })
        
        
    }
}

struct YelpAttribution_Previews: PreviewProvider {
    static var previews: some View {
        YelpAttribution(link: "https://yelp.ca")
    }
}
