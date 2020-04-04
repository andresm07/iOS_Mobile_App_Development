//
//  CarListViewController.swift
//  TableViewWithCustomHeaders
//
//  Created by admin on 4/4/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let carModelCellIdentifier = "CarModelTableViewCell"
    var cars = [CarBrand]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        fillCarsArray()
        registerCustomCells()
    }
    
    private func fillCarsArray() {
        let toyotaModels = [CarModel(name: "Yaris", year: 2012, engine: .gasoline), CarModel(name: "Corolla", year: 2020, engine: .diesel), CarModel(name: "Prius", year: 2021, engine: .electric)]
        self.cars.append(CarBrand(name: "Toyota", country: "Japan", models: toyotaModels))
        let chevroletModels = [CarModel(name: "Camaro", year: 2020, engine: .gasoline), CarModel(name: "Colorado", year: 2021, engine: .diesel)]
        self.cars.append(CarBrand(name: "Chevrolet", country: "USA", models: chevroletModels))
        let bmwModels = [CarModel(name: "X6", year: 2021, engine: .diesel)]
        self.cars.append(CarBrand(name: "BMW", country: "Germany", models: bmwModels))
    }
    
    private func registerCustomCells() {
        self.tableView.register(UINib(resource: R.nib.carModelTableViewCell), forCellReuseIdentifier: R.nib.carModelTableViewCell.name)
        self.tableView.register(UINib(resource: R.nib.carBrandHeaderView), forHeaderFooterViewReuseIdentifier: R.nib.carBrandHeaderView.name)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars[section].models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.carModelCellIdentifier) as? CarModelTableViewCell else
        {
            return UITableViewCell()
        }
        cell.setupCell(carModel: self.cars[indexPath.section].models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: R.nib.carBrandHeaderView.name) as? CarBrandHeaderView else {
            return UIView()
        }
        cell.setupCell(carBrand: self.cars[section])
        return cell
    }
    
    
}
