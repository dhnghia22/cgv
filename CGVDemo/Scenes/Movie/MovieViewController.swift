//
//  MovieViewController.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/2/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {
    
    var viewModel: MovieViewModel!
    @IBOutlet weak var movieTableView: UITableView!
    let bookNowTrigger = PublishSubject<Movie>()
    let selectBlogTrigger = PublishSubject<Blog>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        // Do any additional setup after loading the view.
    }
    
    enum Section: Int {
        case trailerAndDescription = 0
        case info
        case offer
    }
    
    let sections: [Section] = [.trailerAndDescription, .info, .offer]
    var movie: Movie?
    var blogs: [Blog]?
    
    var isReload: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func configView() {
        movieTableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = 85.0
            $0.rowHeight = UITableView.automaticDimension
            $0.register(cellType: TrailerTableViewCell.self)
            $0.register(cellType: MovieInfoTableViewCell.self)
            $0.register(cellType: BlogTableViewCell.self)
            $0.tableFooterView = UIView(frame: .zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
    }
}

extension MovieViewController: BindableType{
    func bindViewModel() {
        let builder = MovieViewModel.InputBuilder().then {
            $0.loadTrigger = Driver.just(())
            $0.bookTrigger = bookNowTrigger.asDriverOnErrorJustComplete()
            $0.selectBlogTrigger = selectBlogTrigger.asDriverOnErrorJustComplete()
            
        }
        
        let input = MovieViewModel.Input(builder: builder)
        let output = viewModel.transform(input)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.movieDetail
            .drive(movieBinder)
            .disposed(by: rx.disposeBag)
        
        output.bookNow
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.blogs
            .drive(blogsBinder)
            .disposed(by: rx.disposeBag)
        
        output.selectBlog
            .drive()
            .disposed(by: rx.disposeBag)
        
    }
    
    fileprivate var movieBinder: Binder<Movie> {
        return Binder(self) { vc, model in
            vc.movie = model
            vc.movieTableView.reloadData()
        }
    }
    
    fileprivate var blogsBinder: Binder<[Blog]> {
        return Binder(self) { vc, model in
            vc.blogs = model
            vc.movieTableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDelegate {
    
}

extension MovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard 0..<sections.count ~= section else { return 0 }
        return sections[section].tableView(tableView, numberOfItemsInSection: section, vc: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         return sections[indexPath.section].tableView(tableView, cellForItemAt: indexPath, vc: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16.0
    }
    
    
}
