//
//  CalendarTableViewCell.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit
import FSCalendar
import AFDateHelper

protocol CalendarTableViewDelegate: class {
    func calendar(_ calendarView: CalendarTableViewCell, didDeselect date: Date)
}



class CalendarTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heightCalendarConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendar: FSCalendar!
    weak var delegate: CalendarTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCalendar()
        calendar.do {
            $0.headerHeight = 0
            $0.firstWeekday = UInt(Calendar.current.component(.weekday, from: Date()))
            $0.setScope(.week, animated: false)
            $0.delegate = self
            $0.dataSource = self
            $0.select(Date())
        }
        setTime(date: Date())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupCalendar() {
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        calendar.appearance.weekdayTextColor = UIColor(hex: 0xA99D92)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        calendar.appearance.titleFont =  UIFont.systemFont(ofSize: 16.0, weight: .regular)
    }
    
    func setTime(date: Date) {
        self.timeLabel.text = date.convertToString(format: "EEEE MMM, d yyyy")
    }
    
}


extension CalendarTableViewCell: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        heightCalendarConstraint.constant = bounds.height
        self.layoutIfNeeded()
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return .white
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return UIColor(hex: 0xA99D92)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return UIColor.mainRedColor
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        setTime(date: date)
        delegate?.calendar(self, didDeselect: date)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
