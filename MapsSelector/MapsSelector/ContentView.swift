//
//  ContentView.swift
//  MapsSelector
//
//  Created by Juan Williman on 10/7/22.
//

import SwiftUI

// MARK: - Content View

struct ContentView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var directionsController = DirectionsController.shared
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("Transport", selection: $directionsController.selectedTransport) {
                        ForEach(Transport.allCases, id: \.self) { transport in
                            Text(transport.rawValue)
                        }
                    }
                    Button("Show Directions") {
                        directionsController.isShowingMapsActionSheet = true
                    }
                } header: {
                    Text("Options")
                } footer: {
                    Text("If Google Maps isn't installed, it will be launched from your browser.")
                }
            }
            .navigationTitle("Maps Selector")
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

#Preview {
    ContentView()
}
