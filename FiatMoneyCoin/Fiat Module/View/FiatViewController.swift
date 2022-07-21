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
    
    @IBOutlet weak var fiatTotalView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var earnValue: UILabel!
    @IBOutlet weak var earnPercent: UILabel!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupTotalView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchCurrency()
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        presenter.showCurrencyView()
    }
    
    func setupTotalView() {
        fiatTotalView.dropShadow(color: .systemRed, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        fiatTotalView.layer.backgroundColor = Constants.backgroundColorView
        fiatTotalView.layer.cornerRadius = 10
        fiatTotalView.layer.masksToBounds = true
        totalValue.text = "foo"
        earnValue.text = "bar"
        earnPercent.text = "baz"
    }
    
    func setupTableView() {
//        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "FiatCell")
        tableView.register(FiatCell.self, forCellReuseIdentifier: FiatCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
    }
}

// MARK: - TableView
extension FiatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.fiatCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FiatCell", for: indexPath) as! TableViewCell
//        cell.amountCurrency.text = presenter.fiatCurrencyList[indexPath.row].amountCurrency
//        cell.amountCurrencySymbol.text = presenter.fiatCurrencyList[indexPath.row].amountCurrencySymbol
//        cell.convertedValue.text = presenter.fiatCurrencyList[indexPath.row].convertedValue
//        cell.earnPercent.text = String("0" + " " + "%")
        let cell = tableView.dequeueReusableCell(withIdentifier: FiatCell.reuseId, for: indexPath) as! FiatCell
        cell.currencyImage.image = UIImage(systemName: "dollarsign.circle.fill")
        return cell
    }
}

// MARK: - Bindings
extension FiatViewController: FiatViewProtocol {
    func updateFiatView() {
        tableView.reloadData()
    }
}
