//
//  CenterCollectionViewFlowLayout.swift
//  TAM Photo
//
//  Created by Le Van Binh on 8/19/16.
//  Copyright © 2016 Le Van Binh. All rights reserved.
//

import UIKit

class CenterCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if let collectionView = collectionView {
            let collectionViewSize = collectionView.bounds.size
            let proposeRect = CGRectMake(proposedContentOffset.x, 0, collectionViewSize.width, collectionViewSize.height)
            if let layoutAttributes = self.layoutAttributesForElementsInRect(proposeRect) {
                let proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width / 2
                var candidateAttributes: UICollectionViewLayoutAttributes?
                for attributes in layoutAttributes {
                    if attributes.representedElementCategory != .Cell {
                        continue
                    }
                    
                    if candidateAttributes == nil {
                        candidateAttributes = attributes
                        continue
                    }
                    
                    if fabs(attributes.center.x - proposedContentOffsetCenterX) < fabs(candidateAttributes!.center.x - proposedContentOffsetCenterX) {
                        candidateAttributes = attributes
                    }
                }
                if let candidateAttributes = candidateAttributes {
                    let newContentOffsetX = candidateAttributes.center.x - collectionViewSize.width / 2
                    return CGPointMake(newContentOffsetX, proposedContentOffset.y)
                } else {
                    return super.targetContentOffsetForProposedContentOffset(proposedContentOffset, withScrollingVelocity: velocity)
                }
                
            } else {
                return super.targetContentOffsetForProposedContentOffset(proposedContentOffset, withScrollingVelocity: velocity)
            }
            
        } else {
            return super.targetContentOffsetForProposedContentOffset(proposedContentOffset, withScrollingVelocity: velocity)
        }
    }
}
