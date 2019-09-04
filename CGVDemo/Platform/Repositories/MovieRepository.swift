//
//  MovieRepository.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//


protocol MovieRepositoryType {
    func getMovie(id: String) -> Observable<Movie>
}

class MovieRepository: MovieRepositoryType {
    func getMovie(id: String) -> Observable<Movie> {
        let input = API.GetMovieInput(id: id)
        return API.shared.requestObject(input)
    }
}
