//
//  UIScrollView.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    var scrolledToEnd: Bool {
        let scrollViewHeight = bounds.height
        let contentOffsetY = contentOffset.y
        let contentSizeHeight = contentSize.height
        return contentSizeHeight - contentOffsetY < scrollViewHeight
    }
    
    var scrolledToHorizontalEdges: Bool {
        let contentOffsetX = contentOffset.x
        let contentSizeWidth = contentSize.width
        let scrollWidth = bounds.width
        let scrolledToHorizontalEdge = contentOffsetX == 0 || contentOffsetX == (contentSizeWidth - scrollWidth)
        return scrolledToHorizontalEdge
    }
}