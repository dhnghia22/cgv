//
//  BookingViewModel.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

struct BookingViewModel: ViewModelType {
    let navigator: BookingNavigatorType
    let useCase: BookingUseCaseType
    let movie: Movie
    
    func transform(_ input: BookingViewModel.Input) -> BookingViewModel.Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        
        let getShowTime = input.dateTrigger
            .distinctUntilChanged()
            .flatMap { date in
            return self.useCase.getShowTime(sku: self.movie.sku!, date: date).map { (time) -> ShowTimeDate? in
                return time.count > 0 ? time[0] : nil
            }.trackError(errorTracker)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
        }
        

        
        let bookTrigger = input.bookTrigger.do(onNext: { (session) in
            
        }).mapToVoid()
        
        return Output(showTimeDate: getShowTime,
                      error: errorTracker.asDriver(),
                      loading: activityIndicator.asDriver(),
                      bookTrigger: bookTrigger)
    }
    
}


extension BookingViewModel {
    struct Input: Then {
        let bookTrigger: Driver<Session>
        let dateTrigger: Driver<String>
    }
    
    struct Output {
        let showTimeDate: Driver<ShowTimeDate?>
        let error: Driver<Error>
        let loading: Driver<Bool>
        let bookTrigger: Driver<Void>
    }
}

extension BookingViewModel {
    final class InputBuilder: Then {
        var bookTrigger: Driver<Session> = Driver.empty()
        var dateTrigger: Driver<String> = Driver.empty()
        
    }
}

extension BookingViewModel.Input {
    init(builder: BookingViewModel.InputBuilder) {
        self.init(bookTrigger: builder.bookTrigger,
                  dateTrigger: builder.dateTrigger)
    }
}

