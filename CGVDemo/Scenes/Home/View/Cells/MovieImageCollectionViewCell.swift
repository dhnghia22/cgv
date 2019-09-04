//
//  MovieImageCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit
import FSPagerView

class MovieImageCollectionViewCell: FSPagerViewCell, NibLoadable {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var sneakShow: Movie? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    private func updateView() {
        guard let sneakShow = sneakShow else { return }
        movieImageView.sd_setImage(with: URL(string: sneakShow.thumbnail ?? ""))
        indexLabel.text = "\(sneakShow.position ?? 0)"
    }
    
    func set(sneakShow: Movie, at index: Int) {
        movieImageView.sd_setImage(with: URL(string: sneakShow.thumbnail ?? ""))
        indexLabel.text = "\(index)"
    }

}
