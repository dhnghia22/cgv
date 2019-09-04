//
//  MovieCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit
import FSPagerView

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var widthButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var timeMovieLabel: UILabel!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var pagerView: FSPagerView!
    var onSelectMovie: ((_ sneakShow: Movie) -> Void)?
    var onBookMovie: ((_ sneakShow: Movie) -> Void)?
    
    var sneakShow: [Movie] = [] {
        didSet {
            setupData()
        }
    }
    
    var sneakShowDisplay: [Movie] = []
    
    
    var categorySelected: Category = Category.nowShowing {
        didSet {
            update()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pagerView.do {
            $0.register(UINib(nibName: "MovieImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieImageCollectionViewCell")
            let transform = FSPagerViewTransformer(type: .coverFlow)
            transform.minimumScale = 1.0
            
            $0.transformer = transform
//            $0.decelerationDistance = 0
            $0.removesInfiniteLoopForSingleItem = true
            $0.bounces = false
            $0.isInfinite = true
            $0.delegate = self
            $0.dataSource = self
            $0.itemSize = CGSize(width: getWindowWidth() * 0.6, height: getWindowWidth() * 0.6 * 1.4)
//            $0.interitemSpacing = 50.0
        }

        
        bookNowButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            let item = self.sneakShowDisplay[self.pagerView.currentIndex]
            self.onBookMovie?(item)
        }).disposed(by: rx.disposeBag)
    }
    
    private func setupData() {
        update()
    }
    
    private func update() {
        switch categorySelected {
        case .nowShowing, .commingSoon:
            sneakShowDisplay = sneakShow.filter{ $0.category == categorySelected.categoryString }
            break
        case .special:
            sneakShowDisplay = sneakShow.filter{ $0.codes != "2D" }
            break
        }
        pagerView.reloadData()
    }
}

extension MovieCollectionViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return sneakShowDisplay.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "MovieImageCollectionViewCell", at: index) as! MovieImageCollectionViewCell
        cell.contentView.layer.shadowRadius = 0.0
        cell.contentView.layer.shadowOpacity = 0.0
        cell.sneakShow = sneakShowDisplay[index]
        cell.indexLabel.isHidden = (categorySelected != .nowShowing)
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let item = sneakShowDisplay[index]
        onSelectMovie?(item)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let sneakShow = sneakShowDisplay[pagerView.currentIndex]
        nameMovieLabel.text = sneakShow.name
        if let ratingString = sneakShow.ratingIcon {
            ratingImageView.sd_setImage(with: URL(string: ratingString))
        } else {
            ratingImageView.image = nil
        }
        if let isBooking = sneakShow.isBooking {
            bookNowButton.isHidden = !isBooking
            widthButtonConstraint.constant = isBooking ? 80.0 : 0
        }
        var dateString = ""
        if let endTime = sneakShow.movieEndtime, endTime > 0 {
            let duration = minutesToHoursMinutes(minutes: endTime)
            let string = "\(duration.0)\(duration.0 > 1 ? "hrs" : "hr") \(duration.1)\(duration.1 > 1 ? "mins" : "min") "
            dateString.append(string)
        }
        if let dateStr = sneakShow.releaseDate, let date = dateStr.convertToDate(format: "yyyy-MM-dd hh:mm:ss"), let dateStringFormated = date.convertToString(format: "dd MMM, yyyy") {
            dateString.append(dateStringFormated)
        }
        timeMovieLabel.text = dateString
        
    }
    
    
}
