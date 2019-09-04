//
//  MovieAssembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol MovieAssembler {
    func resolve(navigationController: BaseNavigationController, movieId: String, blogs: [Blog]) -> MovieViewController
    func resolve(navigationController: BaseNavigationController, movieId: String, blogs: [Blog]) -> MovieViewModel
    func resolve(navigationController: BaseNavigationController) -> MovieNavigatorType
    func resolve() -> MovieUseCaseType
}

extension MovieAssembler {
    func resolve(navigationController: BaseNavigationController, movieId: String, blogs: [Blog]) -> MovieViewController {
        let vc = MovieViewController.instantiateFromNib()
        let vm: MovieViewModel = resolve(navigationController: navigationController, movieId: movieId, blogs: blogs)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: BaseNavigationController, movieId: String, blogs: [Blog]) -> MovieViewModel {
        return MovieViewModel(navigator: resolve(navigationController: navigationController), useCase: resolve(), id: movieId, blogs: blogs)
    }
}

extension HomeAssembler where Self: DefaultAssembler {
    func resolve() -> MovieUseCaseType {
        return MovieUseCase(movieRepository: resolve())
    }
    
    func resolve(navigationController: BaseNavigationController) -> MovieNavigatorType {
        return MovieNavigator(assembler: self, navigationController: navigationController)
    }
}
