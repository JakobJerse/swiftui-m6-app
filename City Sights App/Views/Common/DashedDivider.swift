//
//  DashedDivider.swift
//  City Sights App
//
//  Created by Jakob Jerse on 09/09/2021.
//

import SwiftUI

struct DashedDivider: View {
    var body: some View {
        
        GeometryReader { geo in
            // Sami kreiramo neko obliko/crto
            Path { path in
                path.move(to: CGPoint.zero)
                path.addLine(to: CGPoint(x: geo.size.width, y: 0)) // uporabimo GeometryReader, da se bo crta izrisala cez celotno sirino - geometry reader zavzame celoten dan prostor
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5])) // dash - kako siroki so dashi
            .foregroundColor(.gray)
        }
        .frame(height: 1) // ne bo zavzemal prevec prostora
    }
}

