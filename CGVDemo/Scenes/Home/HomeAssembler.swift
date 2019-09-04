//
//  HomeAssembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

protocol HomeAssembler {
    func resolve(navigationController: BaseNavigationController) -> HomeViewController
    func resolve(navigationController: BaseNavigationController) -> HomeViewModel
    func resolve(navigationController: BaseNavigationController) -> HomeNavigatorType
    func resolve() -> HomeUseCaseType
}

extension HomeAssembler {
    func resolve(navigationController: BaseNavigationController) -> HomeViewController {
        let vc = HomeViewController.instantiateFromNib()
        return vc
    }
    
    func resolve(navigationController: BaseNavigationController) -> HomeViewModel {
        return HomeViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve())
    }
}

extension HomeAssembler where Self: DefaultAssembler {
    func resolve() -> HomeUseCaseType {
        return HomeUseCase(homeRepository: resolve())
    }
    
    func resolve(navigationController: BaseNavigationController) -> HomeNavigatorType {
        return HomeNavigator(assembler: self, navigationController: navigationController)
    }
}

