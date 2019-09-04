//
//  MovieUseCase.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol MovieUseCaseType {
    func getMovie(id: String) -> Observable<Movie>
}

struct MovieUseCase: MovieUseCaseType {
    let movieRepository: MovieRepositoryType
    
    func getMovie(id: String) -> Observable<Movie> {
        return movieRepository.getMovie(id: id)
    }
}

