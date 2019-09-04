//
//  HomeViewController+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

extension HomeViewController.Section {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int,
                        vc: HomeViewController) -> Int {
        switch self {
        case .banners:
            guard !vc.banners.isEmpty else {
                return 0
            }
            return 1
        case .movies:
            if vc.sneakShows.isEmpty {
                return 0
            }
            return 1
        case .location:
            if vc.cinemas.isEmpty {
                return 0
            }
            return 1
        case .offer:
            return vc.blogs.count > 3 ? 3 : vc.blogs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath,
                        vc: HomeViewController) -> UICollectionViewCell {
        switch self {
        case .banners:
            return vc.collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: BannerCollectionViewCell.self).then {
                                                            $0.backgroundColor = UIColor.white
                                                            $0.onSelectBanner = { [weak vc] banner in
                                                                vc?.selectBannerTrigger.onNext((banner, vc?.blogs ?? []))
                                                            }
                                                            $0.banners = vc.banners
            }
        case .movies:
            return vc.collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: MovieCollectionViewCell.self).then {
                                                            $0.sneakShow = vc.sneakShows
                                                            $0.onSelectMovie = { [weak vc] sneakShow in
                                                                vc?.selectMovieTrigger.onNext((sneakShow, vc?.blogs ?? []))
                                                            }
                                                            $0.onBookMovie = { [weak vc] sneakShow in
                                                                vc?.bookMovieTrigger.onNext(sneakShow)
                                                            }
                                                         }
        case .location:
            return vc.collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: LocationCollectionViewCell.self).then {
                                                            $0.cinema = vc.nearestCinema
            }
        case .offer:
            return vc.collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: BlogCollectionViewCell.self).then {
                                                            $0.blog = vc.blogs[indexPath.row]
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath,
                        vc: HomeViewController) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch self {
            case .movies:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: HomeButtonView.self)
                header.onButtonTapped = { [weak vc] index in
                    vc?.reloadMovieCell(index: index)
                }
                return header
            case .offer:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: BlogHeaderView.self)
                return header

            default:
                break

            }
        }
        return UICollectionReusableView()
    }
 
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath,
                        vc: HomeViewController) -> CGSize {
        switch self {
        case .banners:
            return CGSize(width: vc.collectionView.bounds.width,
                          height: vc.collectionView.bounds.width * 0.6)
        case .movies:
            return CGSize(width: vc.collectionView.bounds.width,
                          height: vc.collectionView.bounds.width * 0.9 + 45)
        case .location:
            return CGSize(width: vc.collectionView.bounds.width,
                          height: 45)
        case .offer:
            return CGSize(width: vc.collectionView.bounds.width,
                          height: 125)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int,
                        vc: HomeViewController) -> CGSize {
        switch self {
        case .movies:
            if vc.sneakShows.isEmpty {
                return .zero
            }
            return CGSize(width: vc.collectionView.bounds.width,
                                  height: 44)
        case .offer:
            return vc.blogs.count > 0 ? CGSize(width: vc.collectionView.bounds.width,
            height: 55) : CGSize.zero
        default:
            return CGSize.zero
        }
    }
    
}

extension HomeViewController {
     func reloadMovieCell(index: Int) {
        let newCategory = Category(rawValue: index)!
        if newCategory != categorySelected {
            categorySelected = newCategory
            if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 1)) as? MovieCollectionViewCell {
                cell.categorySelected = categorySelected
            }
        }
    }
}

