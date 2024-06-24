//
//  Rating.swift
//  Restaurants
//
//  Created by Artur Reiner on 19.06.24.
//

import Foundation

enum Rating: String {
    case awesome
    case good
    case okay
    case bad
    case terrible
    
    var image: String {
        switch self {
        case .awesome:
            return "love"
        case .good:
            return "cool"
        case .okay:
            return "happy"
        case .bad:
            return "sad"
        case .terrible:
            return "angry"
        }
    }
}
