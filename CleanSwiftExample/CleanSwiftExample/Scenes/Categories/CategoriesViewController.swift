//
//  CategoriesViewController.swift
//  CleanSwiftExample
//
//  Created by admin on 4/25/20.
//  Copyright (c) 2020 admin. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CategoriesDisplayLogic: class {
    func displayDataSource(viewModel: Categories.DataSource.ViewModel)
}

class CategoriesViewController: UIViewController, CategoriesDisplayLogic {
    var interactor: CategoriesBusinessLogic?
    var router: (NSObjectProtocol & CategoriesRoutingLogic & CategoriesDataPassing)?
    
    @IBOutlet weak var categoriesTableView: UITableView!
    var dataSource = [Categories.DataSource.ViewModel.DisplayedCategory]()
    
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
        let interactor = CategoriesInteractor()
        let presenter = CategoriesPresenter()
        let router = CategoriesRouter()
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
        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        registerCustomCells()
        requestDataSource()
    }
    
    func requestDataSource() {
        let request = Categories.DataSource.Request()
        interactor?.requestDataSource(request: request)
    }
    
    func displayDataSource(viewModel: Categories.DataSource.ViewModel) {
        self.dataSource = viewModel.displayedCategory
        self.categoriesTableView.reloadData()
    }
    
    func registerCustomCells() {
        self.categoriesTableView.register(UINib(resource: R.nib.categoryTableViewCell), forCellReuseIdentifier: R.nib.categoryTableViewCell.name)
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.categoriesTableView.dequeueReusableCell(withIdentifier: R.nib.categoryTableViewCell.name) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(category: self.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.goToNextScreen(index: indexPath.row)
    }
    	
}
