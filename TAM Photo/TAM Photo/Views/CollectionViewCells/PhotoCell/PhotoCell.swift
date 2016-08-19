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
    @IBOutlet private weak var acitivityIndicatorView: UIActivityIndicatorView!
    
    func configureCell(wallPaper: WallPaper) {
        acitivityIndicatorView.startAnimating()
        photoImageView.image = nil
        guard let url = wallPaper.thumbnailURL else { return }
        photoImageView.af_setImageWithURL(url) { (response) in
            if let image = response.result.value {
                self.acitivityIndicatorView.stopAnimating()
                self.photoImageView.image = image
            }
        }
    }
}
