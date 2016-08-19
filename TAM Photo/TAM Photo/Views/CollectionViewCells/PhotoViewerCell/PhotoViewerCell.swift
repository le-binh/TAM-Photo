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
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    private let maximumZoomScale: CGFloat = 1
    var minimumZoomScale: CGFloat {
        return minimumZoomScaleForSize(bounds.size)
    }
    
    var inZoom: Bool = false
    
    //MARK:- LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.maximumZoomScale = maximumZoomScale
        activityIndicatorView.hidesWhenStopped = true
        addTapGestureForPhotoImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMinZoomScaleForSize(bounds.size)
    }
    
    //MARK:- Gesture Handler
    
    func tapGestureHandler(sender: AnyObject) {
        guard let tapGesture = sender as? UITapGestureRecognizer else { return }
        inZoom = !inZoom
        
        if inZoom {
            let point = tapGesture.locationInView(photoImageView)
            let zoomRect = scrollView.zoomRectWithScale(maximumZoomScale, withCenter: point)
            scrollView.zoomToRect(zoomRect, animated: true)
        } else {
            scrollView.setZoomScale(minimumZoomScale, animated: true)
        }
    }
    
    //MARK:- Public functions
    
    func configureCell(wallPaper: WallPaper) {
        activityIndicatorView.startAnimating()
        photoImageView.image = nil
        guard let url = wallPaper.imageURL else { return }
        photoImageView.af_setImageWithURL(url) { (response) in
            if let image = response.result.value {
                self.activityIndicatorView.stopAnimating()
                self.photoImageView.image = image
                self.layoutIfNeeded()
                self.layoutSubviews()
                self.centerPhotoImageViewInSize(self.bounds.size)
            }
        }
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
        
        let xOffset = max(0, (size.width - photoImageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        
        layoutIfNeeded()
    }
    
    private func addTapGestureForPhotoImageView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureHandler(_:)))
        tapGesture.numberOfTapsRequired = 2
        photoImageView.userInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
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