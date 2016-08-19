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
                if let jsWallPapers = json as? JSArray {
                    let wallPapers: [WallPaper] = Mapper<WallPaper>().mapArray(jsWallPapers) ?? []
                    completion?(result: Result.Success(wallPapers))
                } else {
                    completion?(result: Result.Failure(Errors.JSON))
                }
            case .Failure(let error):
                completion?(result: Result.Failure(error))
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion?(result: result)
            }
        }
    }
}
