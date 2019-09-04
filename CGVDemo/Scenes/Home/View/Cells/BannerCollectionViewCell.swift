//
//  BannerCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var collectionView: InfiniteCollectionView!
    private var timer: Timer?
    var onSelectBanner: ((Banner) -> Void)?
    
    var banners: [Banner] = [] {
        didSet {
            if !banners.isEmpty,
                let models = collectionView.prepareDataSourceForInfiniteScroll(array: banners)
                    as? [Banner] {
                infiniteBanner = models
            }
        }
    }
    
    fileprivate var infiniteBanner: [Banner] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.setInitialOffset()
                self.collectionView.reloadData()
            }
        }
    }
        
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.showsHorizontalScrollIndicator = false
            $0.decelerationRate = UIScrollView.DecelerationRate.normal
            $0.isPagingEnabled = true
            $0.register(cellType: BannerImageCollectionViewCell.self)
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                     height: collectionView.bounds.size.height)
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
            $0.collectionViewLayout = layout
            $0.infiniteScrollDelegate = self

        }
    }
    
    deinit {
        stopTimer()
    }
    
    func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true,
                                     block: { [unowned self] _ in
                                        self.collectionView.isUserInteractionEnabled = false
                                        self.collectionView.autoScroll(completion: { (_) in
                                        })
                                        
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        stopTimer()
        startAutoScroll()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        collectionView.isUserInteractionEnabled = true
    }
}

extension BannerCollectionViewCell: InfiniteScrollCollectionViewDelegatge {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.infiniteScrollViewDidScroll(scrollView: scrollView)
    }
    
    func uniformItemSizeIn(collectionView: UICollectionView) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: collectionView.bounds.size.height)
    }
}

extension BannerCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return infiniteBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                      cellType: BannerImageCollectionViewCell.self)
        if 0..<infiniteBanner.count ~= indexPath.row {
            cell.banner = infiniteBanner[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if 0..<infiniteBanner.count ~= indexPath.row {
            onSelectBanner?(infiniteBanner[indexPath.row])
        }
    }
}

extension BannerCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

