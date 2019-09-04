//
//  UIViewController+Rx.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import Foundation
import MBProgressHUD

extension Reactive where Base: UIViewController {
    var error: Binder<Error> {
        return Binder(base) { viewController, error in
            if let error = error as? API.APIError {
                viewController.showError(message: String(describing: error))
            } else {
                viewController.showError(message: error.localizedDescription)
            }
        }
    }
    
    var isLoading: Binder<Bool> {
        return Binder(base) { viewController, isLoading in
            if isLoading {
                MBProgressHUD.showAdded(to: viewController.view, animated: true)
            } else {
                MBProgressHUD.hide(for: viewController.view, animated: true)
            }
        }
    }
}
