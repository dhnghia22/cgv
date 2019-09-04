//
//  BlogViewModelTest.swift
//  CGVDemoTests
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

@testable import CGVDemo
import XCTest
import RxBlocking

class BlogViewModelTest: XCTestCase {
    
    
    var viewModel: BlogViewModel!
    var useCase: BlogUseCaseMock!
    var navigator: BlogNavigatorMock!
    var disposeBag: DisposeBag!
    
    private var input: BlogViewModel.Input!
    private var output: BlogViewModel.Output!
    
    let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        
        useCase = BlogUseCaseMock()
        navigator = BlogNavigatorMock()
        viewModel = BlogViewModel(navigator: navigator, useCase: useCase, blogId: Blog.mock().id ?? "")
        disposeBag = DisposeBag()
        
        let builder = BlogViewModel.InputBuilder().then {
            $0.loadTrigger = loadTrigger.asDriverOnErrorJustComplete()
            
        }
        input = BlogViewModel.Input(builder: builder)
        
        
        
        output = viewModel.transform(input)
        
        output.error
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.blogTrigger
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    func testTransformGetBlogSuccess() {
        // act
        loadTrigger.onNext(())
        
        
        // assert
        let blog = try? output.blogTrigger.toBlocking(timeout: 1).first()
        XCTAssertTrue(useCase.getBlogCalled)
        XCTAssertNotNil(blog)
    }
    
    func testTransformGetShowBlogError() {
        // arrange
        let getBlogSubject = PublishSubject<Blog>()
        useCase.getBlogReturnValue = getBlogSubject
        
        //act
        loadTrigger.onNext(())
        getBlogSubject.onError(TestError())
        
        //assert
        let error = try? output.error.toBlocking(timeout: 1).first()
        XCTAssert(error is TestError)
    }
    
}

