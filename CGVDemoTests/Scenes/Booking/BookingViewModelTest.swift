//
//  BookingViewModelTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest
import RxBlocking

class BookingViewModelTest: XCTestCase {
    
    
    var viewModel: BookingViewModel!
    var useCase: BookingUseCaseMock!
    var navigator: BookingNavigatorMock!
    var disposeBag: DisposeBag!
    
    private var input: BookingViewModel.Input!
    private var output: BookingViewModel.Output!
    
    let dateTrigger = PublishSubject<String>()
    let bookTrigger = PublishSubject<Session>()
    
    override func setUp() {
        super.setUp()
        
        useCase = BookingUseCaseMock()
        navigator = BookingNavigatorMock()
        viewModel = BookingViewModel(navigator: navigator, useCase: useCase, movie: Movie.mock())
        disposeBag = DisposeBag()
        
        let builder = BookingViewModel.InputBuilder().then {
            $0.dateTrigger = dateTrigger.asDriverOnErrorJustComplete()
            $0.bookTrigger = bookTrigger.asDriverOnErrorJustComplete()
        }
        input = BookingViewModel.Input(builder: builder)
        output = viewModel.transform(input)
        
        output.error
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.showTimeDate
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.bookTrigger
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    func testTransformGetShowTimeSuccess() {
        // act
//        loadTrigger.onNext(())
         dateTrigger.onNext("13123131")
        
        // assert
        let showTime = try? output.showTimeDate.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getShowTimeCalled)
        XCTAssertNotNil(showTime)
    }
    
    func testTransformGetShowTimeShowError() {
        // arrange
        let getShowTimeSubject = PublishSubject<[ShowTimeDate]>()
        useCase.getShowTimeReturnValue = getShowTimeSubject
        
        //act
//        loadTrigger.onNext(())
        dateTrigger.onNext("13123131")
        getShowTimeSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }
    
    func testShowTimeFilter() {
        output.showTimeDate.asObservable().subscribe(onNext: { (item) in
            XCTAssertNotNil(item)
        }).disposed(by: disposeBag)
        
        dateTrigger.onNext("13413")
    }
}
