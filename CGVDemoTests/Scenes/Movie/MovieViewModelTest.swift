//
//  MovieViewModelTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest
import RxBlocking

class MovieViewModelTest: XCTestCase {
    
    var viewModel: MovieViewModel!
    var useCase: MovieUseCaseMock!
    var navigator: MovieNavigatorMock!
    var disposeBag: DisposeBag!
    
    private var input: MovieViewModel.Input!
    private var output: MovieViewModel.Output!
    
    let bookNowTrigger = PublishSubject<Movie>()
    let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        
        useCase = MovieUseCaseMock()
        navigator = MovieNavigatorMock()
        viewModel = MovieViewModel(navigator: navigator, useCase: useCase, id: "2", blogs: [Blog.mock()])
        disposeBag = DisposeBag()
        
        let builder = MovieViewModel.InputBuilder().then {
            $0.loadTrigger = Driver.just(())
            $0.bookTrigger = bookNowTrigger.asDriverOnErrorJustComplete()
        }
        
        input = MovieViewModel.Input(builder: builder)
        output = viewModel.transform(input)
        
        output.loading
            .drive()
            .disposed(by: disposeBag)
        
        output.error
            .drive()
            .disposed(by: disposeBag)
        
        output.movieDetail
            .drive()
            .disposed(by: disposeBag)
        
        output.bookNow
            .drive()
            .disposed(by: disposeBag)
        
        output.blogs
            .drive()
            .disposed(by: disposeBag)
        
        
    }
    
    func testTransformLoadTriggerGetMovieSuccess() {
        // act
        loadTrigger.onNext(())
        
        // assert
        let movie = try? output.movieDetail.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getMovieCalled)
        XCTAssertNotNil(movie)
    }
    
    func testTransformLoadTriggerGetMovieShowError() {
        // arrange
        let getMovieSubject = PublishSubject<Movie>()
        useCase.getMovieReturnValue = getMovieSubject
        
        //act
        loadTrigger.onNext(())
        getMovieSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }
    
    func testTransfromBookNow() {
        //act
        bookNowTrigger.onNext(Movie.mock())
        
        //assert
        XCTAssertTrue(navigator.toBookingCalled)
    }
}
