//
//  BusinessList.swift
//  City Sights App
//
//  Created by Jakob Jerse on 01/09/2021.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        ScrollView (showsIndicators: false) {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                
                // Section - loci na vec containerjev + lahko dodas header/footer
                BusinessSection(title: "Restaurants", businesses: model.restaurants)
                
                BusinessSection(title: "Sights", businesses: model.sights)
               
            }
        }
        
        
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
