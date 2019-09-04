//
//  HomeViewModelTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest
import RxBlocking

class HomeViewModelTest: XCTestCase {
    
    var viewModel: HomeViewModel!
    var useCase: HomeUseCaseMock!
    var navigator: HomeNavigatorMock!
    var disposeBag: DisposeBag!
    
    private var input: HomeViewModel.Input!
    private var output: HomeViewModel.Output!
    
    private let loadTrigger = PublishSubject<Void>()
    private let selectBannerTrigger = PublishSubject<(Banner, [Blog])>()
    private let selectMovieTrigger = PublishSubject<(Movie, [Blog])>()
    private let selectOfferTrigger = PublishSubject<Blog>()
    private let bookMovieTrigger = PublishSubject<Movie>()

    override func setUp() {
        super.setUp()
        useCase = HomeUseCaseMock()
        navigator = HomeNavigatorMock()
        viewModel = HomeViewModel(navigator: navigator, useCase: useCase)
        disposeBag = DisposeBag()
        
        let builder = HomeViewModel.InputBuilder().then {
            $0.loadTrigger = loadTrigger.asDriverOnErrorJustComplete()
            $0.selectBannerTrigger = selectBannerTrigger.asDriverOnErrorJustComplete()
            $0.selectMovieTrigger = selectMovieTrigger.asDriverOnErrorJustComplete()
            $0.bookMovieTrigger = bookMovieTrigger.asDriverOnErrorJustComplete()
            $0.selectOfferTrigger = selectOfferTrigger.asDriverOnErrorJustComplete()
        }
        input = HomeViewModel.Input(builder: builder)
        output = viewModel.transform(input)
        
        output.banners.drive().disposed(by: disposeBag)
        output.selectBanner.drive().disposed(by: disposeBag)
        output.loading.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
        output.sneakShow.drive().disposed(by: disposeBag)
        output.cinemas.drive().disposed(by: disposeBag)
        output.blogs.drive().disposed(by: disposeBag)
        output.selectMovie.drive().disposed(by: disposeBag)
        output.bookMovie.drive().disposed(by: disposeBag)
        output.selecOffer.drive().disposed(by: disposeBag)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTransformLoadTriggerGetSneakshowListSuccess() {
        // act
        loadTrigger.onNext(())
        
        // assert
        let categoryList = try? output.sneakShow.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getSneakShowCalled)
        XCTAssertEqual(categoryList?.count, 1)
//        XCTAssertEqual(categoryList![0].id, "Test")
    }
    
    func testTransformLoadTriggerGetSneakShowShowError() {
        // arrange
        let getSneakShowListSubject = PublishSubject<[Movie]>()
        useCase.getSneakShowReturnValue = getSneakShowListSubject
        
        //act
        loadTrigger.onNext(())
        getSneakShowListSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }

    func testTransformLoadTriggerGetBannerListSuccess() {
        // act
        loadTrigger.onNext(())
        
        // assert
        let categoryList = try? output.banners.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getBannersCalled)
        XCTAssertEqual(categoryList?.count, 1)
        XCTAssertEqual(categoryList![0].type, "Test")
    }
    
    func testTransformLoadTriggerGetBannerListShowError() {
        // arrange
        let getBannerListSubject = PublishSubject<[Banner]>()
        useCase.getBannersReturnValue = getBannerListSubject
        
        //act
        loadTrigger.onNext(())
        getBannerListSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }
    
    
    func testTransformLoadTriggerGetCinemaListSuccess() {
        // act
        loadTrigger.onNext(())
        
        // assert
        let cinemas = try? output.cinemas.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getCinemasCalled)
        XCTAssertEqual(cinemas?.count, 1)
    }
    
    func testTransformLoadTriggerCinemasListShowError() {
        // arrange
        let getCinemaListSubject = PublishSubject<[CinemaRegion]>()
        useCase.getCinemasReturnValue = getCinemaListSubject
        
        //act
        loadTrigger.onNext(())
        getCinemaListSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }
    
    
    func testTransformLoadTriggerBlogShowError() {
        // arrange
        let getBlogSubject = PublishSubject<[Blog]>()
        useCase.getBlogReturnValue = getBlogSubject
        
        //act
        loadTrigger.onNext(())
        getBlogSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }
    
    func testTransformLoadTriggerGetBlogSuccess() {
        // act
        loadTrigger.onNext(())
        
        // assert
        let blogs = try? output.blogs.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getBlogCalled)
        XCTAssertEqual(blogs?.count, 1)
    }
    
    func testTransfromSelectMovieTrigger() {
        //act
        selectMovieTrigger.onNext((Movie.mock(), [Blog.mock()]))
        
        //assert
        XCTAssertTrue(navigator.toMovieCalled)
    }
    
    func testTransfromSelectBannerTrigger() {
        //act
        selectBannerTrigger.onNext((Banner.mock(), [Blog.mock()]))
        
        //assert
        XCTAssert(navigator.toBannerCalled)
        XCTAssertTrue(navigator.toBannerCalled)
    }
    
    func testTransfromSelectBlogTrigger() {
        //act
        selectOfferTrigger.onNext(Blog.mock())
        
        //assert
        XCTAssert(navigator.toOfferCalled)
        XCTAssertTrue(navigator.toOfferCalled)
    }
    
    

}
