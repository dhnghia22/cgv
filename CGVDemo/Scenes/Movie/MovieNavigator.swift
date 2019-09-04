//
//  MovieNavigator.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//



protocol MovieNavigatorType {
    func toBooking(movie: Movie)
    func toOfferInfo(blog: Blog)
}

struct MovieNavigator: MovieNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let navigationController: BaseNavigationController
    
    func toBooking(movie: Movie) {
        let vc: BookingViewController = assembler.resolve(navigationController: navigationController, movie: movie)
        self.navigationController.pushViewController(vc, animated: true)
        vc.setUpNavi(title: "Booking")
    }
    
    func toOfferInfo(blog: Blog) {
        guard let blogId = blog.id else { return }
        let vc: BlogViewController = assembler.resolve(navigationController: navigationController, blogId: blogId)
        navigationController.pushViewController(vc, animated: true)
        vc.setUpNavi(title: "New & Offers")
    }
}
