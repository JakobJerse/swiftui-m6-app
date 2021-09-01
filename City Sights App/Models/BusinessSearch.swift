//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Jakob Jerse on 01/09/2021.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
