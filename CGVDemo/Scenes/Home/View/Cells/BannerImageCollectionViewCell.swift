//
//  BannerImageCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class BannerImageCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    var banner: Banner? {
        didSet {
            guard let banner = banner else {
                bannerImageView.image = nil
                return
            }
            bannerImageView.sd_setImage(with: URL(string: banner.image ?? ""))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
