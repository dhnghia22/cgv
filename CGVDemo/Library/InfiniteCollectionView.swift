//
//  InfiniteCollectionView.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

@objc protocol InfiniteScrollCollectionViewDelegatge: NSObjectProtocol {
    func uniformItemSizeIn(collectionView: UICollectionView) -> CGSize
}

class InfiniteCollectionView: UICollectionView {
    
    weak var infiniteScrollDelegate: InfiniteScrollCollectionViewDelegatge?
    
    lazy var extraItems: Int = { [unowned self] in
        if self.uniformItemSize.width > 0 {
            let viewSize = self.bounds.size
            let mexItemVisibleOnScreen = Int(ceil(viewSize.width / self.uniformItemSize.width))
            let extraItems = max(1, mexItemVisibleOnScreen - 1)
            return extraItems
        } else {
            return 0
        }
        }()
    
    lazy private var uniformItemSize: CGSize = {[unowned self] in
        if let size = self.infiniteScrollDelegate?.uniformItemSizeIn(collectionView: self) {
            return size
        } else {
            return .zero
        }
        }()
    
    lazy private var offsetCompensation: CGFloat = { [unowned self] in
        if self.uniformItemSize.width > 0 {
            let viewSize = self.bounds.size
            let fraction = ceil(viewSize.width / self.uniformItemSize.width) -
                (viewSize.width / self.uniformItemSize.width)
            return fraction * self.uniformItemSize.width
        } else {
            return 0
        }
        }()
    
    private var numberOfElementsInDataSource: Int! = 0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setInitialOffset() {
        self.contentOffset = CGPoint(x: uniformItemSize.width * CGFloat(extraItems), y: 0)
    }
    
    func infiniteScrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self {
            if uniformItemSize.width > 0.0 && numberOfElementsInDataSource > 0 {
                if scrollView.contentOffset.x <= 0 {
                    scrollView.contentOffset = CGPoint(x: CGFloat(numberOfElementsInDataSource)
                        * uniformItemSize.width, y: 0)
                } else if scrollView.contentOffset.x >=
                    scrollView.contentSize.width - scrollView.bounds.size.width {
                    scrollView.contentOffset = CGPoint(x: (CGFloat(max(1, extraItems - 1)) * uniformItemSize.width)
                        + offsetCompensation, y: 0)
                }
            }
        }
    }
    
    func prepareDataSourceForInfiniteScroll(array: [Any]) -> [Any] {
        numberOfElementsInDataSource = array.count
        if extraItems > 0 {
            var newArray = [Any]()
            newArray.append(contentsOf: array)
            newArray.insert(contentsOf: array[0..<extraItems], at: array.count)
            newArray.insert(contentsOf: array[(array.count - extraItems)..<array.count], at: 0)
            return newArray
        } else {
            return array
        }
    }
    
    func autoScroll(completion: (Int) -> Void) {
        let rectToScroll = CGRect(x: contentOffset.x + frame.width,
                                  y: contentOffset.y,
                                  width: frame.width,
                                  height: frame.height)
        DispatchQueue.main.async {
            self.scrollRectToVisible(rectToScroll, animated: true)
        }
        let pageNumber = Int(contentOffset.x / frame.width)
        if pageNumber >= numberOfElementsInDataSource {
            completion(0)
        } else {
            completion(Int(contentOffset.x / frame.width))
        }
    }
    
    func infiniteScrollViewWillEndDragging(_ scrollView: UIScrollView,
                                           withVelocity velocity: CGPoint,
                                           targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Int {
        let pageNumber = Int(targetContentOffset.pointee.x / frame.width)
        if pageNumber > numberOfElementsInDataSource {
            return 0
        } else if pageNumber == 0 {
            return numberOfElementsInDataSource
        } else {
            return pageNumber - self.extraItems
        }
    }
}

