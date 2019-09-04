//
//  BookingViewController+Ext.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/3/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import FSCalendar

extension BookingViewController: UITableViewDelegate {
    
}

extension BookingViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = self.currentCityShowTime {
            return self.cinemas.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = self.currentCityShowTime {
            if self.cellStateArray[section] == .expand {
                return self.cinemas[section].languages?.count ?? 0
            } else {
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ShowTimeTableViewCell.self)
        cell.movieLanguage = self.cinemas[indexPath.section].languages?[indexPath.row]
        cell.onSelect = { [weak self] session in
            guard let `self` = self else { return }
            self.bookTrigger.onNext(session)
            self.showError(title: "Booking Movie",message: "Book movie at \(session.time ?? ""), \(session.theater ?? ""), \(session.room ?? "") ")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandHeaderTableViewCell.loadFromNib()
        header.set(cinema: self.cinemas[section], state: cellStateArray[section])
        header.onTapView = { [weak self] state in
            guard let `self` = self else { return }
            self.replaceState(currentState: state, at: section)
            self.tableViewReload(at: section)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: getWindowWidth(), height: 1.0))
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return view
    }
    
    private func tableViewReload(at section: Int) {
        self.tableView.reloadData()
    }
    
    private func replaceState(currentState: CellState, at index: Int) {
        let state = currentState.changeState()
        self.cellStateArray[index] = state
    }
}

extension BookingViewController: CalendarTableViewDelegate {
    func calendar(_ calendarView: CalendarTableViewCell, didDeselect date: Date) {
        if let stringDate = date.convertToString(format: "ddMMyyyy") {
            print(stringDate)
            dateTrigger.onNext(stringDate)
        }
    }
}

extension BookingViewController {
    func preProcess() {
        if let showTimes = self.showTime {
            var currentCityCinemas: ShowTimeLocation?
            if let city = AppManager.shared.getCity() {
                currentCityCinemas = (showTimes.locations ?? []).filter({ (item) -> Bool in
                    return item.name?.folding(options: .diacriticInsensitive, locale: .current).lowercased() == city.name?.folding(options: .diacriticInsensitive, locale: .current).lowercased()
                }).first
                if let currentCityCinemas = currentCityCinemas {
                    self.currentCityShowTime = currentCityCinemas
                    if let cinemaList = self.currentCityShowTime?.cinemas, let location = LocationManager.shared.location {
                        self.cinemas = cinemaList.sorted(by: { (lhs, rhs) -> Bool in
                            if let lhsDistance = lhs.getDistance(from: location), let rhsDistance = rhs.getDistance(from: location) {
                                return lhsDistance < rhsDistance
                            } else {
                                return false
                            }
                        })
                        setupStateArray()
                    } else {
                        resetData()
                    }
                }
            } else {
                self.currentCityShowTime = showTimes.locations?.first
                if let cinemaList = currentCityShowTime?.cinemas {
                    self.cinemas = cinemaList
                    setupStateArray()
                }
            }
        } else {
            resetData()
        }
        self.tableView.reloadData()
    }
    
    private func resetData() {
        self.currentCityShowTime = nil
        self.cinemas = []
        self.cellStateArray = []
    }
    
    private func setupStateArray() {
        self.cellStateArray = []
        for i in 0..<self.cinemas.count {
            if i == 0 {
                self.cellStateArray.append(.expand)
            } else {
                self.cellStateArray.append(.collapse)
            }
        }
    }
}
