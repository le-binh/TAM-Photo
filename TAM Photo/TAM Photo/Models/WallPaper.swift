//
//  WallPaper.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class WallPaper: Mappable {
    var title = ""
    var imageURLString = ""
    var thumbnailURLString = ""
    var id: Double = 0
    var timestamp = ""
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["Title"]
        imageURLString <- map["UrlImage"]
        thumbnailURLString <- map["UrlThum"]
        id <- map["PictureId"]
        timestamp <- map["Timestamp"]
    }
}

extension WallPaper {
    var imageURL: NSURL? {
        return NSURL(string: imageURLString)
    }
    
    var thumbnailURL: NSURL? {
        return NSURL(string: thumbnailURLString)
    }
}