//
//  DirectionsController.swift
//  MapsSelector
//
//  Created by Juan Williman on 10/7/22.
//

import SwiftUI

// MARK: - Directions Controller

class DirectionsController: ObservableObject {
    
    // MARK: - Variables
    
    @Published var isShowingMapsActionSheet = false
    
    @AppStorage("selectedTransport") var selectedTransport: Transport = .driving
    
}

// MARK: - Maps App

extension DirectionsController {
    
    func openAppleMaps(lat: CGFloat, lon: CGFloat) throws {
        let transport = selectedTransport.shortCode
        let appleMapsURL = URL(string: "maps://?saddr=&daddr=\(lat),\(lon)&dirflg=\(transport)")
        UIApplication.shared.open(appleMapsURL!, options: [:], completionHandler: nil)
    }
    
    func openGoogleMaps(lat: CGFloat, lon: CGFloat) throws {
        let transport = selectedTransport.longCode
        let googleMapsURL = URL(
            string: "comgooglemaps://?saddr=&daddr=\(lat),\(lon)&directionsmode=\(transport)"
        )
        UIApplication.shared.open(googleMapsURL!, options: [:], completionHandler: nil)
    }
    
    func openWaze(lat: CGFloat, lon: CGFloat) throws {
        let wazeURL = URL(string: "waze://?ll=\(lat),\(lon)&navigate=yes")
        UIApplication.shared.open(wazeURL!, options: [:], completionHandler: nil)
    }
    
    func openGoogleMapsWeb(lat: CGFloat, lon: CGFloat) throws {
        let transport = selectedTransport.longCode
        let googleMapsWebURL = URL(
            string: "https://www.google.co.in/maps/dir/??saddr=&daddr=\(lat),\(lon)&directionsmode=\(transport)"
        )
        UIApplication.shared.open(googleMapsWebURL!, options: [:], completionHandler: nil)
    }
    
}

// MARK: - Transport

extension DirectionsController {
    
    func selectTransport(_ transport: Transport) {
        selectedTransport = transport
    }
    
}

// MARK: - Buttons

extension DirectionsController {
    
    func getMapsButtons(lat: CGFloat, lon: CGFloat) -> [ActionSheet.Button] {
        
        var mapButtons: [ActionSheet.Button] = []
        
        let appleMapsURLScheme = "maps://"
        let googleMapsURLScheme = "comgooglemaps://"
        let wazeURLScheme = "waze://"
        
        guard let appleMapsURL = URL(string: appleMapsURLScheme) else { return mapButtons }
        guard let googleMapsURL = URL(string: googleMapsURLScheme) else { return mapButtons }
        guard let wazeURL = URL(string: wazeURLScheme) else { return mapButtons }
        
        if UIApplication.shared.canOpenURL(appleMapsURL) {
            mapButtons.append(
                .default(Text("Apple Maps")) {
                    do {
                        try self.openAppleMaps(lat: lat, lon: lon)
                    } catch {
                        print("There was an error trying to open Apple Maps")
                    }
                }
            )
        }
        
        mapButtons.append(
            .default(Text("Google Maps")) {
                do {
                    if UIApplication.shared.canOpenURL(googleMapsURL) {
                        try self.openGoogleMaps(lat: lat, lon: lon)
                    } else {
                        try self.openGoogleMapsWeb(lat: lat, lon: lon)
                    }
                } catch {
                    print("There was an error trying to open Google Maps")
                }
            }
        )
        
        if UIApplication.shared.canOpenURL(wazeURL) {
            mapButtons.append(
                .default(Text("Waze")) {
                    do {
                        try self.openWaze(lat: lat, lon: lon)
                    } catch {
                        print("There was an error trying to open Waze")
                    }
                }
            )
        }
        
        mapButtons.append(.cancel())
        
        return mapButtons
    }
    
}
