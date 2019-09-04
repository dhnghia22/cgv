//
//  BlogTableViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var didSelect: ((_ blog: Blog) -> Void)?
    
    var blogs: [Blog]? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.do {
            $0.register(cellType: BlogImageCollectionViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            $0.setCollectionViewLayout(layout, animated: false)
            $0.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
        // Configure the view for the selected state
    }
    
    private func updateView() {
        collectionView.reloadData()
    }
}

extension BlogTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: BlogImageCollectionViewCell.self)
        cell.blog = blogs?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height * 1.5, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let blogs = blogs else { return }
        didSelect?(blogs[indexPath.row])
    }
}
