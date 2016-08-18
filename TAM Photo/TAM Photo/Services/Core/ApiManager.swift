//
//  ApiManager.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import Foundation

typealias JSObject = [String : AnyObject]
typealias JSArray = [JSObject]
typealias Completion = (result: Result <AnyObject, NSError>) -> Void

let apiManager = ApiManager()

class ApiManager {
    
    func request(method: Method, path: URLStringConvertible, parameters: JSObject? = nil, completion: Completion) -> Request {
        let parameters = parameters ?? JSObject()
        let encoding: ParameterEncoding = (method == .GET ? .URL : .JSON)
        let request = Manager.sharedInstance.request(method, path, parameters: parameters, encoding: encoding)
        request.response(completion)
        return request
    }
}

extension Request {
    func response(completion: Completion) {
        responseJSON { (response) in
            let result = response.result
            if let error = result.error {
                completion(result: Result.Failure(error))
            } else if let json = result.value {
                completion(result: Result.Success(json))
            } else {
                let error = Errors.JSON
                completion(result: Result.Failure(error))
            }
        }
    }
}