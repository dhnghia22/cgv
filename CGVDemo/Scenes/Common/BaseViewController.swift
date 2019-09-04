//
//  BaseViewController.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class BaseViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }
    
    
    func setUpNavi(title: String) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: self.navigationController?.navigationBar.frame.size.height ?? 0))
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.navigationController?.navigationBar.frame.size.height ?? 0, height: self.navigationController?.navigationBar.frame.size.height ?? 0))
        backButton.rx.tap.subscribe(onNext: { _ in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        backButton.setImage(UIImage(named: "back-arrow"), for: .normal)
        view.addSubview(backButton)
        let titleLabel = UILabel(frame: CGRect(x: backButton.frame.maxY + 8, y: 0, width: 0, height: backButton.frame.height))
        titleLabel.textColor = UIColor.mainTextColor
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        titleLabel.text = title;
        titleLabel.sizeToFit()
        view.addSubview(titleLabel)
        titleLabel.center.y = backButton.center.y
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: view)
        
    }
    
    ///Add back button on left navigation bar
//    private func setupNavigationBar() {
//        if let navigation = self.navigationController {
//            if navigation.viewControllers.count > 1 {
//                self.addBackButton()
//            }
//        }
//    }
    
//    private func addBackButton() {
//        backButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.backButtonPressed(sender:)))
//
//        self.navigationItem.leftBarButtonItem = backButton
//    }
    
    
    ///Action for back button
    @IBAction private func backButtonPressed(sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
