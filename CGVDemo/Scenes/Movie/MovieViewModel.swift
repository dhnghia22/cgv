//
//  MovieViewModel.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

struct MovieViewModel: ViewModelType {
    let navigator: MovieNavigatorType
    let useCase: MovieUseCaseType
    var id: String
    var blogs: [Blog]
    
    func transform(_ input: MovieViewModel.Input) -> MovieViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        
        let getMovieDetail = input.loadTrigger.flatMap { _ in
            return self.useCase.getMovie(id: self.id)
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        

        let getBlog = Driver.just(blogs)
        
        let booknow = input.bookTrigger.do(onNext: { movie in
            self.navigator.toBooking(movie: movie)
        })
        
        let selectBlog = input.selectBlogTrigger.do(onNext: { (blog) in
            self.navigator.toOfferInfo(blog: blog)
        }).mapToVoid()
        
        return Output(movieDetail: getMovieDetail,
                      error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      bookNow: booknow, blogs: getBlog, selectBlog: selectBlog)
    }
}


extension MovieViewModel {
    struct Input: Then {
        let bookTrigger: Driver<Movie>
        let loadTrigger: Driver<Void>
        let selectBlogTrigger: Driver<Blog>
    }
    
    struct Output {
        let movieDetail: Driver<Movie>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let bookNow: Driver<Movie>
        let blogs: Driver<[Blog]>
        let selectBlog: Driver<Void>
    }
}

extension MovieViewModel {
    final class InputBuilder: Then {
        var bookTrigger: Driver<Movie> = Driver.empty()
        var loadTrigger: Driver<Void> = Driver.empty()
        var selectBlogTrigger: Driver<Blog> = Driver.empty()
    }
}

extension MovieViewModel.Input {
    init(builder: MovieViewModel.InputBuilder) {
        self.init(bookTrigger: builder.bookTrigger,
                  loadTrigger: builder.loadTrigger,
                    selectBlogTrigger: builder.selectBlogTrigger)
    }
    
}
