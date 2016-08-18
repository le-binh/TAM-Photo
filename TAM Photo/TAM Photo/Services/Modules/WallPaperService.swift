//
//  WallPaperService.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class WallPaperService: BaseService {
    func loadWallPappers(category: String, page: Int, completion: Completion?) {
        let path = ApiPath.WallPaper.path
        var parameters = JSObject()
        parameters["category"] = category
        parameters["page"] = page
        request(.GET, path: path, parameters: parameters) { (result) in
            switch result {
            case .Success(let json):
                print(json)
            case .Failure(let error):
                print(error)
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion?(result: result)
            }
        }
    }
}
