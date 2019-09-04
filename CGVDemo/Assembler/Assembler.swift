//
//  Assembler.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

protocol Assembler: class,
    HomeAssembler,
    RepositoriesAssembler,
    MovieAssembler,
    BookingAssembler,
    BlogAssembler,
    AppAssembler {
    
}


class DefaultAssembler: Assembler {
    static let shared = DefaultAssembler()
}
