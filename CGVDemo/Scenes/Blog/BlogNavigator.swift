//
//  BlogNavigator.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation

protocol BlogNavigatorType {
    
}

struct BlogNavigator: BlogNavigatorType {
    unowned let assembler: DefaultAssembler
    unowned let navigationController: BaseNavigationController
    
    
}

