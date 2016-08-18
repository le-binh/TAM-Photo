//
//  CGGeometry.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/18/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import Foundation
import UIKit

public enum DeviceType: Int {
    case Phone4
    case Phone5
    case Phone6
    case Phone6p
    case Pad
    
    public var size: CGSize {
        switch self {
        case .Phone4: return CGSize(width: 320, height: 480)
        case .Phone5: return CGSize(width: 320, height: 568)
        case .Phone6: return CGSize(width: 375, height: 667)
        case .Phone6p: return CGSize(width: 414, height: 736)
        case .Pad: return CGSize(width: 768, height: 1024)
        }
    }
}

public let kScreenSize = UIScreen.mainScreen().bounds.size

struct Ratio {
    static let horizontal = kScreenSize.width / DeviceType.Phone6.size.width
    static let vertical = kScreenSize.height / DeviceType.Phone6.size.height
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
}