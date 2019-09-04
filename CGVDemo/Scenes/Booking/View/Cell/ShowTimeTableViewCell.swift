//
//  ShowTimeTableViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class ShowTimeTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var timeShowCollectionView: UICollectionView!
    @IBOutlet weak var typeMovieLabel: UILabel!
    
    var onSelect: ((_ session: Session) -> Void)?
    
    var movieLanguage: Language? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timeShowCollectionView.do {
            $0.register(cellType: ShowTimeCollectionViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.setCollectionViewLayout(layout, animated: false)
            $0.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView() {
        guard let movie = movieLanguage else { return }
        typeMovieLabel.text = movie.name
        timeShowCollectionView.reloadData()
        
    }
}

extension ShowTimeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieLanguage?.sessions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ShowTimeCollectionViewCell.self)
        cell.session = movieLanguage?.sessions?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height * 1.5, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let sessionArray = movieLanguage?.sessions {
            if 0..<sessionArray.count ~= indexPath.row {
                onSelect?(sessionArray[indexPath.row])
            }
        }
    }
    
    
}
