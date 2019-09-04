//
//  ExpandHeaderTableViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class ExpandHeaderTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var onTapView: ((_ currentState: CellState) -> Void)?
    
    var cellState: CellState = .collapse
    var cinema: ShowTimeCinema? {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event.subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.onTapView?(self.cellState)
        }).disposed(by: rx.disposeBag)
        self.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(cinema: ShowTimeCinema, state: CellState) {
        self.cinema = cinema
        self.cellState = state
        let image = state == .expand ? UIImage(named: "arrow-up") : UIImage(named: "arrow-down")
        arrowImageView.image = image
    }
    
    private func updateView() {
        guard let cinema = cinema else { return }
        let cinemaName = cinema.name ?? ""
        let myMutableString = NSMutableAttributedString(string: cinemaName, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0, weight: .semibold),
                                                                                         NSAttributedString.Key.foregroundColor: UIColor.mainTextColor])
        let range = (cinemaName as NSString).range(of: "CGV", options: .caseInsensitive)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.mainRedColor, range: range)
        
        nameLabel.attributedText = myMutableString
        
        if let location = LocationManager.shared.location, let distance = cinema.getDistance(from: location)  {
            distanceLabel.text = String(format: "%.1fKm", distance / 1000)
        } else {
            distanceLabel.text = nil
        }
    }
    
}
