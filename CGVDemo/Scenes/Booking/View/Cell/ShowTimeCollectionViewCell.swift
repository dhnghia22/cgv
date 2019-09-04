//
//  ShowTimeCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class ShowTimeCollectionViewCell: UICollectionViewCell, NibReusable {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    var session: Session? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView() {
        guard let session = session else { return }
        timeLabel.text = session.time
    }
}
