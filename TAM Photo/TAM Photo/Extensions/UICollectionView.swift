//
//  UICollectionView.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/18/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    public func registerNib<T: UICollectionViewCell>(aClass: T.Type) {
        let name = String(aClass)
        let nib = UINib(nibName: name, bundle: nil)
        registerNib(nib, forCellWithReuseIdentifier: name)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(aClass: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
        return dequeueReusableCellWithReuseIdentifier(String(aClass), forIndexPath: indexPath) as! T
    }
}