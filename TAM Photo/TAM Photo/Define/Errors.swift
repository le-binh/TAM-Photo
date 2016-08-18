//
//  Errors.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import Foundation

private enum ErrorType {
    case JSON
    var code: Int {
        switch self {
        case .JSON:
            return 600
        }
    }
    
    var description: String {
        switch self {
        case .JSON:
            return "JSON could not be serialized."
        }
    }
}

struct Errors {
    static var JSON: NSError {
        let errorType: ErrorType = .JSON
        return Error.error(code: errorType.code, failureReason: errorType.description)
    }
}