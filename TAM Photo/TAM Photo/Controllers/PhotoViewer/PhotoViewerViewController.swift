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
    
    var wallPapers: [WallPaper] = []
    var selectedWallPaper: WallPaper?
    
    private var itemSize: CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- Private functions
    
    private func setupUI() {
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoViewerCollectionView.collectionViewLayout = layoutForCollectionView()
        moveToSelectedWallPaperIfNeeded()
    }
    
    private func setupCollectionView() {
        photoViewerCollectionView.dataSource = self
        photoViewerCollectionView.decelerationRate = UIScrollViewDecelerationRateFast
        photoViewerCollectionView.registerNib(PhotoViewerCell)
        photoViewerCollectionView.collectionViewLayout = layoutForCollectionView()
    }
    
    private func layoutForCollectionView() -> UICollectionViewLayout {
        let layout = CenterCollectionViewFlowLayout()
        layout.itemSize = itemSize
        layout.minimumLineSpacing = cellPadding
        layout.scrollDirection = .Horizontal
        return layout
    }
    
    private func moveToSelectedWallPaperIfNeeded() {
        guard let wallPaper = selectedWallPaper else { return }
        guard let index = wallPapers.indexOf(wallPaper) else { return }
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        photoViewerCollectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
    }
}

//MARK:- UICollectionView Data Source

extension PhotoViewerViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallPapers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoViewerCell = collectionView.dequeueReusableCell(PhotoViewerCell.self, forIndexPath: indexPath)
        photoViewerCell.configureCell(wallPapers[indexPath.row])
        return photoViewerCell
    }
}