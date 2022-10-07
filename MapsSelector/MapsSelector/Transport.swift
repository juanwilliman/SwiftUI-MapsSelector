//
//  Transport.swift
//  MapsSelector
//
//  Created by Juan Williman on 10/7/22.
//

import Foundation

// MARK: - Transport

enum Transport: String, CaseIterable {
    
    case driving = "Driving"
    case walking = "Walking"
    
    var longCode: String {
        switch self {
        case .driving:
            return "driving"
        case .walking:
            return "walking"
        }
    }
    
    var shortCode: String {
        switch self {
        case .driving:
            return "d"
        case .walking:
            return "w"
        }
    }
    
}
