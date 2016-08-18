//
//  PhotoViewerViewController.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/18/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class PhotoViewerViewController: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet private weak var photoViewerCollectionView: UICollectionView!
    
    private let cellPadding: CGFloat = 10 * Ratio.horizontal
    private let itemSize = CGSize(width: kScreenSize.width, height: kScreenSize.height)
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- Private functions
    
    private func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        photoViewerCollectionView.dataSource = self
        photoViewerCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
        photoViewerCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        photoViewerCollectionView.collectionViewLayout = layoutForCollectionView()
    }
    
    private func layoutForCollectionView() -> UICollectionViewLayout {
        let layout = CenterCollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumLineSpacing = cellPadding
        layout.scrollDirection = .Horizontal
        return layout
    }
}

//MARK:- UICollectionView Data Source

extension PhotoViewerViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoViewerCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        photoViewerCell.contentView.backgroundColor = UIColor.greenColor()
        return photoViewerCell
    }
}