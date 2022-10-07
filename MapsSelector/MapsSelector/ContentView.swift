//
//  ContentView.swift
//  MapsSelector
//
//  Created by Juan Williman on 10/7/22.
//

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    
    // MARK: - Variables
    
    @ObservedObject private var directionsController = DirectionsController()
    
    // MARK: - Body
    
    var body: some View {
        
        VStack(spacing: 25) {
            
            Text("Transport")
                .font(.largeTitle)
            
            HStack(spacing: 30) {
                ForEach(Transport.allCases, id: \.self) { transport in
                    Button(transport.rawValue) {
                        directionsController.selectTransport(transport)
                    }
                    .foregroundColor(directionsController.selectedTransport == transport ? .red : .accentColor)
                }
            }
            .padding(.bottom, 50)
            
            Button("Show Directions") {
                directionsController.isShowingMapsActionSheet = true
            }.buttonStyle(.borderedProminent)
            
        }
        .actionSheet(isPresented: $directionsController.isShowingMapsActionSheet) {
            ActionSheet(
                title: Text("Maps App"),
                message: Text("Select which Maps App to use"),
                buttons: directionsController.getMapsButtons(
                    lat: 37.334626676586204,
                    lon: -122.00895219984801
                )
            )
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
