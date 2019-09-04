//
//  BlogCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class BlogCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blogImageView: UIImageView!
    
    var blog: Blog? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView() {
        guard let blog = blog else { return }
        blogImageView.sd_setImage(with: URL(string: blog.thumbnail ?? ""))
        titleLabel.text = blog.title
    }

}
