//
//  BookingNavigator.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol BookingNavigatorType {
    
}

struct BookingNavigator: BookingNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let navigationController: BaseNavigationController
}

