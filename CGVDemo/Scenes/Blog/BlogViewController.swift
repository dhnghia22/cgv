//
//  BlogViewController.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/4/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class BlogViewController: BaseViewController {
    @IBOutlet weak var blogImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: BlogViewModel!
    let loadTrigger = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension BlogViewController: BindableType {
    func bindViewModel() {
        let builder = BlogViewModel.InputBuilder().then {
            $0.loadTrigger = Driver.just(())
        }
        let input = BlogViewModel.Input(builder: builder)
        
        let output = viewModel.transform(input)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
    
        output.blogTrigger
            .drive(blogsBinder)
            .disposed(by: rx.disposeBag)
    }
    
    fileprivate var blogsBinder: Binder<Blog> {
        return Binder(self) { vc, model in
            vc.setupView(blog: model)
        }
    }
    
    private func setupView(blog: Blog) {
        if let images = blog.images, images.count > 0 {
            blogImageView.sd_setImage(with: URL(string: images[0]))
        }
        titleLabel.text = blog.title
        timeLabel.text = blog.shortDescription
        if let attString = blog.content?.htmlToAttributed {
            let contentString = NSMutableAttributedString(attributedString: attString)
            contentString.setFontFace(font: UIFont.systemFont(ofSize: 15))
            contentLabel.attributedText = contentString
        }
    }
}


