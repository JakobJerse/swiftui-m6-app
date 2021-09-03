//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Jakob Jerse on 02/09/2021.
//

import SwiftUI

struct BusinessSection: View {
    
    
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        
        Section (header: BusinessSectionHeader(title: title)) {  // da se text ne prekriva - damo belo odzadje
            ForEach(businesses) { business in
                
                BusinessRow(business: business)
            }
        }
        
    }
}

