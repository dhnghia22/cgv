//
//  BlogAssembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


protocol BlogAssembler {
    func resolve(navigationController: BaseNavigationController, blogId: String) -> BlogViewController
    func resolve(navigationController: BaseNavigationController, blogId: String) -> BlogViewModel
    func resolve(navigationController: BaseNavigationController) -> BlogNavigatorType
    func resolve() -> BlogUseCaseType
}

extension BlogAssembler {
    func resolve(navigationController: BaseNavigationController, blogId: String) -> BlogViewController {
        let vc = BlogViewController.instantiateFromNib()
        let vm: BlogViewModel = resolve(navigationController: navigationController, blogId: blogId)
        vc.bindViewModel(to: vm)
        return vc
        
    }
    func resolve(navigationController: BaseNavigationController, blogId: String) -> BlogViewModel {
        return BlogViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), blogId: blogId)
    }
}

extension BlogAssembler where Self: DefaultAssembler {
    func resolve() -> BlogUseCaseType {
        return BlogUseCase(blogRepository: resolve())
    }
    
    func resolve(navigationController: BaseNavigationController) -> BlogNavigatorType {
        return BlogNavigator(assembler: self, navigationController: navigationController)
    }
}


