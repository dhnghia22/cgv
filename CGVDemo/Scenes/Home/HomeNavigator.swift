//
//  HomeNavigator.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit


protocol HomeNavigatorType {
    func toMovie(sneakShow: Movie, blogs: [Blog])
    func toOfferInfo(blogId: String)
    func toBook(movie: Movie)
    func toBanner(banner: Banner, blogs: [Blog])
}

struct HomeNavigator: HomeNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let navigationController: BaseNavigationController
    
    func toMovie(sneakShow: Movie, blogs: [Blog]) {
        guard let id = sneakShow.id else { return }
        let vc: MovieViewController = assembler.resolve(navigationController: navigationController, movieId: id, blogs: blogs)
        navigationController.pushViewController(vc, animated: true)
        navigationController.isNavigationBarHidden = false
        vc.setUpNavi(title: "Movie")
    }
    
    func toBook(movie: Movie) {
        let vc: BookingViewController = assembler.resolve(navigationController: navigationController, movie: movie)
        self.navigationController.pushViewController(vc, animated: true)
        navigationController.isNavigationBarHidden = false
        vc.setUpNavi(title: "Booking")
    }
    
    func toOfferInfo(blogId: String)  {
        if blogId.isEmpty { return }
        let vc: BlogViewController = assembler.resolve(navigationController: navigationController, blogId: blogId)
        navigationController.pushViewController(vc, animated: true)
        navigationController.isNavigationBarHidden = false
        vc.setUpNavi(title: "New & Offers")
    }
    
    func toBanner(banner: Banner,  blogs: [Blog]) {
        if let type = banner.type, let id = banner.id, type == "movie" {
            let vc: MovieViewController = assembler.resolve(navigationController: navigationController, movieId: id, blogs: blogs)
            navigationController.pushViewController(vc, animated: true)
            navigationController.isNavigationBarHidden = false
            vc.setUpNavi(title: "Movie")
        } else if let type = banner.type, let id = banner.id, type == "blog" {
            let vc: BlogViewController = assembler.resolve(navigationController: navigationController, blogId: id)
            navigationController.pushViewController(vc, animated: true)
            navigationController.isNavigationBarHidden = false
            vc.setUpNavi(title: "New & Offers")
        }
    }
}
