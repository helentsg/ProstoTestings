//
//  NetworkRequestError.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

enum NetworkRequestError: Error {
    
    case offline
    case error(description: String)
    
    var localizedDescription: String {
        switch self {
        case .offline:
            return "No Internet Connection"
            
        case .error(let description):
            return description
        }
    }
}

