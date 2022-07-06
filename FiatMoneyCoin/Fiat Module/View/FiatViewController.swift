//
//  FiatViewController.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 28.06.2022.
//
//  Template generated by Tambanco
//

import UIKit

class FiatViewController: UIViewController {

	var presenter: FiatPresenterProtocol!
    var fiatCurrencyList: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fiatTotalView: UIView!
    
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var earnValue: UILabel!
    @IBOutlet weak var eranPercent: UILabel!
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTotalView()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
//        presenter.getCurrencyList()
        presenter.showAddAlert()
        let addCurrencyVC = ModuleBuilder.createCurrencyModule()
        present(addCurrencyVC, animated: true, completion: nil)
        
    }
    
    func setupTotalView() {
        presenter.caculateTotalFiat()
        fiatTotalView.layer.backgroundColor = Constants.backgroundColorView
        fiatTotalView.layer.cornerRadius = 10
        fiatTotalView.layer.masksToBounds = true
    }
    
    func setupTableView() {
//        tableView.backgroundColor = .systemRed
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "FiatCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
    }
}

// MARK: - TableView
extension FiatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiatCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiatCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .systemTeal
        cell.amountCurrency.text = "0"
        cell.amountBaseCurrency.text = String(0)
        cell.earnPercent.text = String("0" + " " + "%")
        cell.amountForCell.text = String(0)
        cell.amountCurrencySymbol.text = fiatCurrencyList[indexPath.row]
        return cell
    }
}

// MARK: - Bindings
extension FiatViewController: FiatViewProtocol {
    func setupTotalValue(totalValue: String, earnValue: String, earnPercent: String) {
        self.totalValue.text = totalValue
        self.earnValue.text = earnValue
        self.eranPercent.text = earnPercent
        
    }
    
    func present(viewControllerToPresent: UIViewController) {
        self.present(viewControllerToPresent, animated: true)
    }
    
    func setupTableView(currencyList: [String]) {
        fiatCurrencyList = currencyList
        self.tableView.reloadData()
    }
}
