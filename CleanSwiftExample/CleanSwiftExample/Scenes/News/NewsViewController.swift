//
//  NewsViewController.swift
//  CleanSwiftExample
//
//  Created by admin on 5/2/20.
//  Copyright (c) 2020 admin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsDisplayLogic: class {
    func displayDataSource(viewModel: News.DataSource.ViewModel)
}

class NewsViewController: UIViewController, NewsDisplayLogic {
    var interactor: NewsBusinessLogic?
    var router: (NSObjectProtocol & NewsRoutingLogic & NewsDataPassing)?
    
    @IBOutlet weak var newsTableView: UITableView!
    var dataSource = [News.DataSource.ViewModel.DisplayedNews]()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = NewsInteractor()
        let presenter = NewsPresenter()
        let router = NewsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        registerCustomCells()
        addNewsNavigationButton()
    }
    
    func registerCustomCells() {
        self.newsTableView.register(UINib(resource: R.nib.newsTableViewCell), forCellReuseIdentifier: R.nib.newsTableViewCell.name)
    }
    
    func addNewsNavigationButton() {
        let addNewsNavigationButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewsAction(sender:)))
        navigationItem.rightBarButtonItem = addNewsNavigationButton
    }
    
    @objc func addNewsAction(sender: UIBarButtonItem) {

    }
    
    
    func displayDataSource(viewModel: News.DataSource.ViewModel) {
        self.dataSource = viewModel.displayedNews
        self.newsTableView.reloadData()
    }
    
    func requestDataSource() {
        let request = News.DataSource.Request()
        self.interactor?.requestDataSource(request: request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestDataSource()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.newsTableView.dequeueReusableCell(withIdentifier: R.nib.newsTableViewCell.name) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
}