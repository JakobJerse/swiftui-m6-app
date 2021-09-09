//
//  LocationDeniedView.swift
//  City Sights App
//
//  Created by Jakob Jerse on 09/09/2021.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings.")
            
            Spacer()
            
            Button(action: {
                
                // Open settings
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        // If we can open this settings url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            }, label: {
                
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }
            })
            .padding()
            
            Spacer()
        }
        .foregroundColor(.white)    // text bo bel, gumb text pa ne, ker smo izrecno spremenili barvo
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea(.all, edges: .all)
    }
}


