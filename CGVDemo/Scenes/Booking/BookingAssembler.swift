//
//  BookingAssembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol BookingAssembler {
    func resolve(navigationController: BaseNavigationController, movie: Movie) -> BookingViewController
    func resolve(navigationController: BaseNavigationController, movie: Movie) -> BookingViewModel
    func resolve(navigationController: BaseNavigationController) -> BookingNavigatorType
    func resolve() -> BookingUseCaseType
}


extension BookingAssembler {
    func resolve(navigationController: BaseNavigationController, movie: Movie) -> BookingViewController {
        let vc = BookingViewController.instantiateFromNib()
        let vm: BookingViewModel = resolve(navigationController: navigationController, movie: movie)
        vc.bindViewModel(to: vm)
        return vc
    }
    func resolve(navigationController: BaseNavigationController, movie: Movie) -> BookingViewModel {
        return BookingViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), movie: movie)
    }
}

extension BookingAssembler where Self: DefaultAssembler {
    func resolve() -> BookingUseCaseType {
        return BookingUseCase(bookingRepository: resolve())
    }
    
    func resolve(navigationController: BaseNavigationController) -> BookingNavigatorType {
        return BookingNavigator(assembler: self, navigationController: navigationController)
    }
}

