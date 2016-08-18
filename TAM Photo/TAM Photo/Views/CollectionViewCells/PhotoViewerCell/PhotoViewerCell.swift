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
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    private let kZoomScaleUpdatingAnimationDuration = 0.3
    
    var image: UIImage? {
        didSet {
            photoImageView.image = image
        }
    }
    
    var minimumZoomScale: CGFloat {
        return minimumZoomScaleForSize(bounds.size)
    }
    
    var inZoom: Bool = false {
        didSet {
            updateZoomScale(true)
        }
    }
    
    //MARK:- LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        addTapGestureForPhotoImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMinZoomScaleForSize(bounds.size)
    }
    
    //MARK:- Gesture Handler
    
    func tapGestureHandler(sender: AnyObject) {
        inZoom = !inZoom
    }
    
    
    //MARK:- Private functions
    
    private func minimumZoomScaleForSize(size: CGSize) -> CGFloat {
        let widthScale = size.width / photoImageView.bounds.width
        let heightScale = size.height / photoImageView.bounds.height
        return min(widthScale, heightScale)
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.zoomScale = minimumZoomScale
    }
    
    private func centerPhotoImageViewInSize(size: CGSize) {
        let yOffset = max(0, (size.height - photoImageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - photoImageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        layoutIfNeeded()
    }
    
    private func addTapGestureForPhotoImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHandler(_:)))
        tapGesture.numberOfTapsRequired = 2
        photoImageView.userInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
    }
    
    private func updateZoomScale(animated: Bool) {
        if animated {
            UIView.animateWithDuration(kZoomScaleUpdatingAnimationDuration, animations: {
                self.scrollView.zoomScale = self.inZoom ? 1 : self.minimumZoomScale
            })
        } else {
            scrollView.zoomScale = inZoom ? 1 : minimumZoomScale
        }
    }
}

//MARK:- UIScrollView Delegate

extension PhotoViewerCell: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        centerPhotoImageViewInSize(bounds.size)
    }
}