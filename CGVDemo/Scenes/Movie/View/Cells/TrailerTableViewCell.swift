//
//  TrailerTableViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

class TrailerTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var heightStackView: NSLayoutConstraint!
    @IBOutlet weak var imageThumbnail: UIImageView!
    @IBOutlet weak var widthStackView: NSLayoutConstraint!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    @IBOutlet weak var widthBookButton: NSLayoutConstraint!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var codeStackView: UIStackView!
    @IBOutlet weak var bookNowButton: UIButton!
    
    @IBOutlet weak var heightLabelConstraint: NSLayoutConstraint!
    
    var onSelectViewTrailer: ((_ movie: Movie) -> Void)?
    var onReloadCell: ((_ isReload: Bool) -> Void)?
    var isHaveMore: Bool = false
    
    var movie: Movie? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer()
        imageThumbnail.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.subscribe(onNext: { [weak self] (gesture) in
            self?.goToViewVideo()
        }).disposed(by: rx.disposeBag)
        

        let tapExpandLabel = UITapGestureRecognizer()
        descriptionMovieLabel.addGestureRecognizer(tapExpandLabel)
        descriptionMovieLabel.isUserInteractionEnabled = true
        
        tapExpandLabel.rx.event.subscribe(onNext: { [weak self] (gesture) in
            guard let `self` = self else { return }
            if self.isHaveMore {
                self.onReloadCell?(true)
            }
        }).disposed(by: rx.disposeBag)
        
    }
    
    func set(_ isHaveMore: Bool) {
        self.isHaveMore = isHaveMore
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let movie = movie else { return }
        if let youtubeID = movie.movieTrailer?.youtubeID {
            let thumbailURL = URL(string: "http://img.youtube.com/vi/\(youtubeID)/0.jpg")
            imageThumbnail.sd_setImage(with: thumbailURL)
        }
        nameMovieLabel.text = movie.name
        descriptionMovieLabel.text = movie.fullDescription
        let readmoreFont = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        let readmoreFontColor = UIColor.mainRedColor
        if (descriptionMovieLabel.lines?.count ?? 0) > 4 && !isHaveMore {
            
            DispatchQueue.main.async {
                self.descriptionMovieLabel.addTrailing(with: "... ", moreText: "more", moreTextFont: readmoreFont, moreTextColor: readmoreFontColor)
            }
            isHaveMore = true
        } else {
            if heightLabelConstraint != nil { descriptionMovieLabel.removeConstraint(heightLabelConstraint)
            }
            descriptionMovieLabel.text = movie.fullDescription
        }
        if (movie.isBooking ?? false) {
            widthBookButton.constant = 80.0
        } else {
            widthBookButton.constant = 0.0
        }
        setupCode()
        self.layoutIfNeeded()
    }
    
    private func setupCode() {
        if let movie = movie, let codes = movie.codes {
            let codeArray = codes.components(separatedBy: ",").filter { !$0.isEmpty}
            if codeArray.count == 0 {
                heightStackView.constant = 0
                return
            }
            var width: CGFloat = 0
            for item in codeArray {
                let trimItem = item.trimmingCharacters(in: .whitespacesAndNewlines)
                if let validCode = Code(rawValue: trimItem.lowercased()) {
                    let codeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                    codeLabel.text = validCode.rawValue.uppercased()
                    codeLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .semibold)
                    codeLabel.textAlignment = .center
                    codeLabel.textColor = UIColor.mainTextColor
                    codeLabel.layer.cornerRadius = 25.0
                    codeLabel.layer.borderColor = UIColor.mainTextColor.cgColor
                    codeLabel.layer.borderWidth = 2.0
                    width += 50
                    codeStackView.addArrangedSubview(codeLabel)
                }
            }
            widthStackView.constant = width
        }
        
    }
    
    private func goToViewVideo() {
        guard let movie = movie else { return }
        onSelectViewTrailer?(movie)
    }
}
