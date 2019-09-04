//
//  LocationCollectionViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    var cinema: Cinema? {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var nameCinemaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func updateView() {
        if let cinema = cinema {
            let cinemaName = cinema.name ?? ""
            let myMutableString = NSMutableAttributedString(string: cinemaName, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
                                                                            NSAttributedString.Key.foregroundColor: UIColor.mainTextColor])
            let range = (cinemaName as NSString).range(of: "CGV", options: .caseInsensitive)
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainRedColor, range: range)
            
            nameCinemaLabel.attributedText = myMutableString
            if let distance = cinema.getDistance(from: LocationManager.shared.location) {
                let string = String(format: "%.1f", distance / 1000)
                distanceLabel.text = "\(string)km"
            }
        } else {
            nameCinemaLabel.text = "Không thể lấy được vị trí"
            distanceLabel.text = nil
        }
    }

}
