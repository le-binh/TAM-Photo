//
//  BaseService.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class BaseService {
    func request(method: Method, path: URLStringConvertible, parameters: JSObject? = nil, completion: Completion) {
        apiManager.request(method, path: path, parameters: parameters) { (result) in
            switch result {
            case .Success(let json):
                completion(result: Result.Success(json))
            case .Failure(let error):
                completion(result: Result.Failure(error))
            }
        }
    }
}