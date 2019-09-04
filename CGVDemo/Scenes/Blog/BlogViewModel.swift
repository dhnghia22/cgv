//
//  BlogViewModel.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

struct BlogViewModel: ViewModelType {
    let navigator: BlogNavigatorType
    let useCase: BlogUseCaseType
    let blogId: String
    
    func transform(_ input: BlogViewModel.Input) -> BlogViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let getBlogDetail = input.loadTrigger.flatMap { _ in
            return self.useCase.getBlogDetail(blogId: self.blogId)
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        
    
        
        return Output(error: errorTracker.asDriver(), loading: activityIndicator.asDriver(), blogTrigger: getBlogDetail)
    }
    
}


extension BlogViewModel {
    struct Input: Then {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let blogTrigger: Driver<Blog>
    }
}

extension BlogViewModel {
    final class InputBuilder: Then {
        var loadTrigger: Driver<Void> = Driver.empty()
    }
}

extension BlogViewModel.Input {
    init(builder: BlogViewModel.InputBuilder) {
        self.init(loadTrigger: builder.loadTrigger)
    }
}


