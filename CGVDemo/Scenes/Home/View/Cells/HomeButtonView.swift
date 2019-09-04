//
//  HomeButtonView.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class HomeButtonView: UICollectionReusableView, NibReusable {
    
    @IBOutlet var buttonArray: [UIButton]!
    
    var categorySelected: Category = Category.nowShowing {
        didSet {
            
        }
    }
    
    var onButtonTapped: ((_ index: Int) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        buttonArray.first?.isSelected = true
        for button in buttonArray {
            button.rx.tap.subscribe { [weak self] event in
                guard let `self` = self else { return }
                for btn in self.buttonArray {
                    btn.isSelected = false
                }
                button.isSelected = true
                self.onButtonTapped?(button.tag)
                }.disposed(by: rx.disposeBag)
        }
    }
    
    private func updateView() {
        let index = categorySelected.rawValue
        if 0..<buttonArray.count ~= index {
            for button in buttonArray {
                button.isSelected = false
            }
            buttonArray[index].isSelected = true
        }
    }
    
}
