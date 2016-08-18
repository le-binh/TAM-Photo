//
//  PhotoListViewController.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/18/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet private weak var photosCollectionView: UICollectionView!
    
    private let cellPadding: CGFloat = 2 * Ratio.horizontal
    private let numberOfItemsInRow = 4
    
    private let kWallPaperCategory = "b9c14c74-5741-4cd3-8dd0-dd43d27a04b5"
    
    private var wallPapers: [WallPaper] = []
    
    private var itemSize: CGFloat {
        let screenWidth = UIScreen.mainScreen().bounds.width
        let totalCellPading = CGFloat(numberOfItemsInRow - 1) * cellPadding
        return (screenWidth - totalCellPading) / CGFloat(numberOfItemsInRow)
    }
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        WallPaperService().loadWallPappers(kWallPaperCategory, page: 1) { (result) in
            switch result {
            case .Success(let wallPapers):
                let loadedWallPapers: [WallPaper] = (wallPapers as? [WallPaper]) ?? []
                self.wallPapers.appendContentsOf(loadedWallPapers)
                self.photosCollectionView.reloadData()
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    //MARK:- Private functions
    
    private func setupUI() {
        title = Strings.PhotoList
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        photosCollectionView.dataSource = self
        photosCollectionView.delegate = self
        photosCollectionView.registerNib(PhotoCell)
        photosCollectionView.collectionViewLayout = layoutForCollectionView()
    }
    
    private func layoutForCollectionView() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = cellPadding
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Vertical
        return layout
    }
}

//MARK:- UICollectionView Data Source

extension PhotoListViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallPapers.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(PhotoCell.self, forIndexPath: indexPath)
        let wallPaper = wallPapers[indexPath.row]
        photoCell.configureCell(wallPaper)
        return photoCell
    }
}

//MARK:- UICollectionView Delegate

extension PhotoListViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let photoViewerViewController = PhotoViewerViewController(nibName: "PhotoViewerViewController", bundle: nil)
        navigationController?.pushViewController(photoViewerViewController, animated: true)
    }
}
