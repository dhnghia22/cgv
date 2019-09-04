//
//  HomeViewController.swift
//  CGVDemo
//
//  Created by Dinh Huu Nghia on 9/1/19.
//  Copyright © 2019 Dinh Huu Nghia. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var heightBarConstraint: NSLayoutConstraint!
    var viewModel: HomeViewModel!
    //IBOutlet
    @IBOutlet weak var topBarConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Rx varible
    let selectBannerTrigger = PublishSubject<(Banner, [Blog])>()
    let selectMovieTrigger = PublishSubject<(Movie, [Blog])>()
    let bookMovieTrigger = PublishSubject<Movie>()
    let selectOfferTrigger = PublishSubject<Blog>()

    //enum
    enum Section : Int {
        case banners = 0
        case movies
        case location
        case offer
    }
    
    var sections: [Section] = [.banners,
                               .movies,
                               .location,
                               .offer]
    
    var movieCollectionViewCell: MovieCollectionViewCell!
    var banners: [Banner] = []
    var sneakShows: [Movie] = []
    var cinemas: [CinemaRegion] = []
    var blogs: [Blog] = []
    var nearestCinema: Cinema?
    var categorySelected: Category = .nowShowing
    
    private let heightBar: CGFloat = UIApplication.shared.statusBarFrame.size.height + 49
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configView() {
        collectionView.do {
            $0.contentInset = UIEdgeInsets(top: -UIApplication.shared.statusBarFrame.height, left: 0, bottom: 0, right: 0)
            $0.register(cellType: BannerCollectionViewCell.self)
            $0.register(cellType: MovieCollectionViewCell.self)
            $0.register(cellType: LocationCollectionViewCell.self)
            $0.register(supplementaryViewType: HomeButtonView.self, ofKind: UICollectionView.elementKindSectionHeader)
            $0.register(supplementaryViewType: BlogHeaderView.self,
                        ofKind: UICollectionView.elementKindSectionHeader)
            $0.register(cellType: BlogCollectionViewCell.self)
            $0.dataSource = self
            $0.delegate = self
            let layout = StickyCollectionLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            $0.collectionViewLayout = layout
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            
        }
        
        heightBarConstraint.constant = heightBar
        topBarConstraint.constant = -heightBar
    }
}

extension HomeViewController: BindableType{
    func bindViewModel() {
        let builder = HomeViewModel.InputBuilder().then {
            $0.loadTrigger = Driver.just(())
            $0.selectBannerTrigger = selectBannerTrigger.asDriverOnErrorJustComplete()
            $0.selectMovieTrigger = selectMovieTrigger.asDriverOnErrorJustComplete()
            $0.bookMovieTrigger = bookMovieTrigger.asDriverOnErrorJustComplete()
            $0.selectOfferTrigger = selectOfferTrigger.asDriverOnErrorJustComplete()
        }
        let input = HomeViewModel.Input(builder: builder)
        let output = viewModel.transform(input)
        
        output.selectBanner
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.selectMovie
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.loading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
        
        output.banners
            .drive(bannersBinder)
            .disposed(by: rx.disposeBag)
        
        output.sneakShow
            .drive(sneakShowBinder)
            .disposed(by: rx.disposeBag)
        
        output.cinemas
            .drive(cinemasBinder)
            .disposed(by: rx.disposeBag)
        
        output.blogs
            .drive(blogBinder)
            .disposed(by: rx.disposeBag)
        
        output.bookMovie
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.selecOffer
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    fileprivate var bannersBinder: Binder<[Banner]> {
        return Binder(self) { vc, model in
            vc.banners = model
            vc.collectionView.reloadSections(IndexSet(integer: Section.banners.rawValue))
        }
    }
    
    fileprivate var sneakShowBinder: Binder<[Movie]> {
        return Binder(self) { vc, model in
            vc.sneakShows = model
            vc.collectionView.reloadSections(IndexSet(integer: Section.movies.rawValue))
        }
    }
    
    fileprivate var cinemasBinder: Binder<[CinemaRegion]> {
        return Binder(self) { vc, model in
            vc.cinemas = model
            vc.nearestCinema = Utilities.getNearestCinema(cinemas: vc.cinemas, from: LocationManager.shared.location)
            AppManager.shared.set(city: Utilities.getCurentCityCinema(cinemas: vc.cinemas, from: LocationManager.shared.location))
            vc.collectionView.reloadSections(IndexSet(integer: Section.location.rawValue))
        }
    }
    
    fileprivate var blogBinder: Binder<[Blog]> {
        return Binder(self) { vc, model in
            vc.blogs = model
            vc.collectionView.reloadSections(IndexSet(integer: 3))
        }
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard 0..<sections.count ~= section else { return 0 }
        return sections[section].collectionView(collectionView,
                                                numberOfItemsInSection: section,
                                                vc: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].collectionView(collectionView,
                                                          cellForItemAt: indexPath,
                                                          vc: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return sections[indexPath.section].collectionView(collectionView,
                                                          viewForSupplementaryElementOfKind: kind,
                                                          at: indexPath,
                                                          vc: self)
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let bannerCell = cell as? BannerCollectionViewCell else {
            return
        }
        bannerCell.startAutoScroll()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let bannerCell = cell as? BannerCollectionViewCell else {
            return
        }
        bannerCell.stopTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if topBarConstraint.constant >= 0 && scrollView.contentOffset.y > heightBar {
            topBarConstraint.constant = 0
        } else {
            topBarConstraint.constant = -heightBar + scrollView.contentOffset.y
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard 0..<sections.count ~= indexPath.section else { return }
        if sections[indexPath.section] == .offer {
            self.selectOfferTrigger.onNext(blogs[indexPath.row])
        }
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard 0..<sections.count ~= indexPath.section else { return CGSize.zero }
        return sections[indexPath.section].collectionView(collectionView,
                                                          layout: collectionViewLayout,
                                                          sizeForItemAt: indexPath,
                                                          vc: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard 0..<sections.count ~= section else { return CGSize.zero }
        return sections[section].collectionView(collectionView,
                                                layout: collectionViewLayout,
                                                referenceSizeForHeaderInSection: section,
                                                vc: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if sections[section] == .offer {
            return 1.0
        }
        return 0.0
    }
}
