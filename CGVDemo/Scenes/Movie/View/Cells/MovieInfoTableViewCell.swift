//
//  MovieInfoTableViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var theaterLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var movie: Movie? {
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

        // Configure the view for the selected state
    }
    
    private func updateView() {
        guard let movie = movie else { return }
        rateLabel.text = movie.getRatedString()?.uppercased() ?? "NO"
        theaterLabel.text = movie.getReleaseDateString()
        genreLabel.text = movie.genre
        directorLabel.text = movie.movieDirector
        castLabel.text = movie.movieActress
        if let endTime = movie.movieEndtime, endTime > 0 {
            let duration = minutesToHoursMinutes(minutes: endTime)
            runTimeLabel.text = "\(duration.0)\(duration.0 > 1 ? "hrs" : "hr") \(duration.1)\(duration.1 > 1 ? "mins" : "min") "
        }
        languageLabel.text = movie.movieLanguage
    }
    
}
