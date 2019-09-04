//
//  AppViewModel.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

struct AppViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let toMain: Driver<Void>
    }
    
    let navigator: AppNavigatorType
//    let useCase: AppUseCaseType
    
    func transform(_ input: Input) -> Output {
        let toMain = input.trigger
            .do(onNext: self.navigator.toMain)
        
        return Output(toMain: toMain)
    }
}

extension AppViewModel {
    final class InputBuilder: Then {
        var trigger: Driver<Void> = Driver.empty()
    }
}

extension AppViewModel.Input {
    init(builder: AppViewModel.InputBuilder) {
        self.init(trigger: builder.trigger)
    }
}
