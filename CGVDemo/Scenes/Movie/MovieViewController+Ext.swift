//
//  MovieViewController+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation
import AVKit
import XCDYouTubeKit

extension MovieViewController.Section {
    func tableView(_ tableView: UITableView,
                        numberOfItemsInSection section: Int,
                        vc: MovieViewController) -> Int {
        if let _ = vc.movie {
            if self == .offer {
                return vc.blogs != nil ? 1 : 0
            } else {
                 return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                        cellForItemAt indexPath: IndexPath,
                        vc: MovieViewController) -> UITableViewCell {
        switch self {
        case .trailerAndDescription:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TrailerTableViewCell.self).then {
                $0.set(vc.isReload)
                $0.movie = vc.movie
                $0.selectionStyle = .none
                
                $0.bookNowButton.rx.tap.subscribe(onNext: { _ in
                    guard let movie = vc.movie else { return }
                    vc.bookNowTrigger.onNext(movie)
                }).disposed(by: vc.rx.disposeBag)
                
                $0.onReloadCell = { [weak vc] reload in
                    guard let vc = vc else { return }
                    if reload {
                        vc.isReload = true
                        vc.movieTableView.reloadData()
                    }
                }
                
                $0.onSelectViewTrailer = { [weak vc]   movie in
                    guard let vc = vc else { return }
                    if let youtubeID = movie.movieTrailer?.youtubeID {
                        XCDYouTubeClient.default().getVideoWithIdentifier(youtubeID, cookies: nil, completionHandler: { (video, err) in
                            if let video = video {
                                if let streamURL = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue] {
                                    let player = AVPlayer(url: streamURL)
                                    let playerController = AVPlayerViewController()
                                    playerController.player = player
                                    vc.present(playerController, animated: true, completion: {
                                        playerController.player?.play()
                                    })
                                }
                            }
                        })
                    }
                }
            }
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MovieInfoTableViewCell.self).then {
                $0.movie = vc.movie
                $0.selectionStyle = .none
            }
            return cell
        case .offer:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BlogTableViewCell.self).then {
                $0.blogs = vc.blogs
                $0.selectionStyle = .none
                $0.didSelect = { [weak vc] blog in
                    guard let vc = vc else { return }
                    vc.selectBlogTrigger.onNext(blog)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, vc: MovieViewController) -> CGFloat {
        return UITableView.automaticDimension
    }
}
