//
//  NetworkRequestError.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

enum NetworkRequestError: Error {
    
    case offline
    case error(description: String)
    
    var description: String {
        switch self {
        case .offline:
            return "Нет подключения к интернету"
            
        case .error(let description):
            return description
        }
    }
}

