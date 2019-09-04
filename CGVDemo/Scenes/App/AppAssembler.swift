//
//  AppAssembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel
    func resolve(window: UIWindow) -> AppNavigatorType
//    func resolve() -> AppUseCaseType
}

extension AppAssembler {
    func resolve(window: UIWindow) -> AppViewModel {
        return AppViewModel(navigator: resolve(window: window))
    }
}

extension AppAssembler where Self: DefaultAssembler {
    func resolve(window: UIWindow) -> AppNavigatorType {
        return AppNavigator(assembler: self, window: window)
    }
    
//    func resolve() -> AppUseCaseType {
//        return AppUseCase(pushNotificationRepo: DefaultAssembler.shared.resolve())
//    }
}


