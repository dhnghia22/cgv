//
//  AppNavigator.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation


protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let window: UIWindow
    
    func toMain() {
        let vc = HomeViewController.instantiateFromNib()
        let navi = BaseNavigationController(rootViewController: vc)
        let vm: HomeViewModel = assembler.resolve(navigationController: navi)
        vc.bindViewModel(to: vm)
        window.rootViewController = navi
        window.makeKeyAndVisible()
    }
}
