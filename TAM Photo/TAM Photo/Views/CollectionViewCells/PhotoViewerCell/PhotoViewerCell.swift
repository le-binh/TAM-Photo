//
//  PhotoViewerCell.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class PhotoViewerCell: UICollectionViewCell {

    //MARK:- Properties
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            photoImageView.image = image
        }
    }
}
