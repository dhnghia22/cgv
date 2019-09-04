//
//  BookingViewController.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit
import FSCalendar

class BookingViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: BookingViewModel!
    let dateTrigger = PublishSubject<String>()
    let bookTrigger = PublishSubject<Session>()
    
    let calendarHeader = CalendarTableViewCell.loadFromNib()
    var showTime: ShowTimeDate?
    var currentCityShowTime: ShowTimeLocation?
    var cinemas: [ShowTimeCinema] = []
    var cellStateArray: [CellState] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            calendarHeader.frame.size.height = 120
            calendarHeader.delegate = self
            $0.tableHeaderView = calendarHeader
            $0.register(cellType: ExpandHeaderTableViewCell.self)
            $0.register(cellType: ShowTimeTableViewCell.self)
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
        }
    }
}

extension BookingViewController: BindableType {
    func bindViewModel() {
        let builder = BookingViewModel.InputBuilder().then {
            $0.dateTrigger = dateTrigger.asDriverOnErrorJustComplete()
            $0.bookTrigger = bookTrigger.asDriverOnErrorJustComplete()
        }
        let input = BookingViewModel.Input(builder: builder)
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.showTimeDate
            .drive(showTimeBinder)
            .disposed(by: rx.disposeBag)
        
        output.bookTrigger
            .drive()
            .disposed(by: rx.disposeBag)
        
        if let dateString = Date().convertToString(format: "ddMMyyyy") {
            dateTrigger.onNext(dateString)
        }
    }
    
    fileprivate var showTimeBinder: Binder<ShowTimeDate?> {
        return Binder(self) { vc, model in
            vc.showTime = model
            vc.preProcess()
        }
    }
}

