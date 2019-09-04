//
//  StickyCollectionLayout.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

class StickyCollectionLayout: UICollectionViewFlowLayout {
    
    var constantHeightHeader: CGFloat = (49.0 + UIApplication.shared.statusBarFrame.height)
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard var layoutAttributes = super.layoutAttributesForElements(in: rect), let collectionView = collectionView else {
            return super.layoutAttributesForElements(in: rect)
        }
        
        let missingSections = NSMutableIndexSet()
        layoutAttributes.forEach({ (attributes) in
          if attributes.representedElementCategory == .cell && attributes.representedElementKind != UICollectionView.elementKindSectionHeader  && attributes.indexPath.section == 0 {
                missingSections.add(attributes.indexPath.section)
            }
        })
        
        missingSections.enumerate(using: { idx, stop in
            let indexPath = IndexPath(item: 0, section: idx)
            if let attributes = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
                layoutAttributes.append(attributes)
            }
        })
        
        for layoutAttributes in layoutAttributes {
            if let representedElementKind = layoutAttributes.representedElementKind {
                if representedElementKind == UICollectionView.elementKindSectionHeader && layoutAttributes.indexPath.section != 0 {
                    let section = layoutAttributes.indexPath.section
                    //                    let numberOfItemsInSection = collectionView.numberOfItems(inSection: section)
                    
                    //                    let firstCellIndexPath = IndexPath(item: 0, section: section)
                    //                    let lastCellIndexPath = IndexPath(item: max(0, (numberOfItemsInSection - 1)), section: section)
                    guard let boundaries = boundaries(forSection: section) else { break }
                    
                    let contentOffsetY = collectionView.contentOffset.y
                    var frameForSupplementaryView = layoutAttributes.frame
                    
                    let minimum = boundaries.minimum - frameForSupplementaryView.height
                    let maximum = boundaries.maximum - frameForSupplementaryView.height
                    
                    if contentOffsetY < minimum - constantHeightHeader  {
                        frameForSupplementaryView.origin.y = minimum
                    } else if contentOffsetY > maximum  {
                        frameForSupplementaryView.origin.y = maximum
                    } else {
                        frameForSupplementaryView.origin.y = contentOffsetY + constantHeightHeader
//                        layoutAttributes.zIndex = 0
                    }
                    
                    layoutAttributes.frame = frameForSupplementaryView
                }
            }
        }
        
        return layoutAttributes
    }
    
    
    // MARK: - Helper Methods
    func boundaries(forSection section: Int) -> (minimum: CGFloat, maximum: CGFloat)? {
        // Helpers
        var result = (minimum: CGFloat(0.0), maximum: CGFloat(0.0))
        
        // Exit Early
        guard let collectionView = collectionView else { return result }
        
        // Fetch Number of Items for Section
        let numberOfItems = collectionView.numberOfItems(inSection: section)
        
        // Exit Early
        guard numberOfItems > 0 else { return result }
        
        if let firstItem = layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
            let lastItem = layoutAttributesForItem(at: IndexPath(item: (numberOfItems - 1), section: section)) {
            result.minimum = firstItem.frame.minY
            result.maximum = lastItem.frame.maxY
            
            // Take Header Size Into Account
            result.minimum -= headerReferenceSize.height
            result.maximum -= headerReferenceSize.height
            
            // Take Section Inset Into Account
            result.minimum -= sectionInset.top
            result.maximum += (sectionInset.top + sectionInset.bottom)
        }
        
        return result
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


