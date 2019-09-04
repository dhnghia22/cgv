//
//  Enum.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation


enum Category: Int {
    case nowShowing = 0
    case special
    case commingSoon
    
    var categoryString: String {
        switch self {
        case .nowShowing:
            return "Now Showing"
        case .special:
            return ""
        case .commingSoon:
            return "Coming Soon"
        }
    }
}

enum Rate: String {
    case p = "p"
    case c16 = "C16"
    case c18 = "C18"
    case c13 = "C13"
    
    var contentString: String {
        switch self {
        case .p:
            return "P - General movie for all customers"
        case .c13:
            return "C18 - No children under 13 years old"
        case .c16:
            return "C16 - No children under 16 years old"
        case .c18:
            return "C18 - No children under 18 years old"
        }
    }
}

enum Code: String {
    case imax = "imax"
    case threeD = "3d"
    case fourD = "4dx"
    case starium = "starium"
}


enum CellState {
    case expand
    case collapse

    func changeState() -> CellState {
        return self == .expand ? .collapse : .expand
    }
}
