//
//  HomeViewModel.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation


struct HomeViewModel: ViewModelType {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
    
    func transform(_ input: HomeViewModel.Input) -> HomeViewModel.Output {
        let errorTracker = ErrorTracker()
        let bannerActivityIndicator = ActivityIndicator()
        let sneakShowActivityIndicator = ActivityIndicator()
        let blogActivityIndicator = ActivityIndicator()
        let cinemaActivityIndicator = ActivityIndicator()
        
        
        let loading = Driver.merge(bannerActivityIndicator.asDriver(), sneakShowActivityIndicator.asDriver(), blogActivityIndicator.asDriver(), cinemaActivityIndicator.asDriver())
            .startWith(false)
        
        let bannerList = input.loadTrigger.flatMap { _ in
            return self.useCase.getBanner()
            .trackActivity(bannerActivityIndicator)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        }
        
        
        let sneakShowList = input.loadTrigger.flatMap { _ in
            return self.useCase.getSneakShow(id: 2)
                .trackActivity(sneakShowActivityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let cinemaList = input.loadTrigger.flatMap { _ in
            return self.useCase.getCinemas()
                .trackActivity(cinemaActivityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let blogList = input.loadTrigger.flatMap { _ in
            return self.useCase.getBLog()
                .trackActivity(blogActivityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        
        
        let selectBanner = input.selectBannerTrigger.do(onNext: { banner in
            self.navigator.toBanner(banner: banner.0, blogs: banner.1)
        }).mapToVoid()
        
        let selectMovie = input.selectMovieTrigger.do(onNext: { data in
            self.navigator.toMovie(sneakShow: data.0, blogs: data.1)
        }).mapToVoid()
        
        let bookMovie = input.bookMovieTrigger.do(onNext: { (movie) in
            self.navigator.toBook(movie: movie)
        }).mapToVoid()
        
        let selectOffer = input.selectOfferTrigger.do(onNext: { blog in
            self.navigator.toOfferInfo(blogId: blog.id ?? "")
        }).mapToVoid()
        
        return Output(selectBanner: selectBanner,
                      error: errorTracker.asDriver(),
                      banners: bannerList,
                      loading:  loading,
                      sneakShow: sneakShowList,
                      cinemas: cinemaList,
                      blogs: blogList,
                      selectMovie: selectMovie,
                      bookMovie: bookMovie,
                      selecOffer: selectOffer)
    }
    

}

extension HomeViewModel {
    struct Input {
        let selectBannerTrigger: Driver<(Banner, [Blog])>
        let selectMovieTrigger: Driver<(Movie, [Blog])>
        let loadTrigger: Driver<Void>
        let bookMovieTrigger: Driver<Movie>
        let selectOfferTrigger: Driver<Blog>
    }
    
    struct Output {
        let selectBanner: Driver<Void>
        let error: Driver<Error>
        let banners: Driver<[Banner]>
        let loading: Driver<Bool>
        let sneakShow: Driver<[Movie]>
        let cinemas: Driver<[CinemaRegion]>
        let blogs: Driver<[Blog]>
        let selectMovie: Driver<Void>
        let bookMovie: Driver<Void>
        let selecOffer: Driver<Void>
    }
}

extension HomeViewModel {
    final class InputBuilder: Then {
        var selectBannerTrigger: Driver<(Banner, [Blog])> = Driver.empty()
        var loadTrigger: Driver<Void> = Driver.empty()
        var selectMovieTrigger: Driver<(Movie, [Blog])> = Driver.empty()
        var bookMovieTrigger: Driver<Movie> = Driver.empty()
        var selectOfferTrigger: Driver<Blog> = Driver.empty()
    }
}

extension HomeViewModel.Input {
    init(builder: HomeViewModel.InputBuilder) {
        self.init(selectBannerTrigger: builder.selectBannerTrigger,
                  selectMovieTrigger: builder.selectMovieTrigger,
                  loadTrigger: builder.loadTrigger,
                  bookMovieTrigger: builder.bookMovieTrigger,
                  selectOfferTrigger: builder.selectOfferTrigger)
        
    }
}



