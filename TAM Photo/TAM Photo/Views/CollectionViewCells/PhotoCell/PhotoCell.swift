//
//  PhotoCell.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/18/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    //MARK:- Properties
    
    @IBOutlet private weak var photoImageView: UIImageView!
    
    func configureCell(wallPaper: WallPaper) {
        photoImageView.image = UIImage(named: "thumbnail.png")
    }
}
