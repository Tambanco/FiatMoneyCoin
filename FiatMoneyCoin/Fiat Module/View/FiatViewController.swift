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
    var fiatTotalView: FiatTotalView!
    var dropShadow: DropShadowProtocol!
    var fiatTableView: UITableView!
    var addNewFiatButton: UIButton!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupTotalView()
        setupTableView()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.fetchCurrency()
    }
    
    func setupTotalView() {
        fiatTotalView = FiatTotalView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropShadow = DropShadow(onView: fiatTotalView)
        view.addSubview(fiatTotalView)
        
        fiatTotalView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(0)
            make.trailing.equalToSuperview().inset(0)
            make.height.equalTo(225)
        }
    }
    
    func setupTableView() {
        fiatTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        fiatTableView.register(FiatCell.self, forCellReuseIdentifier: FiatCell.reuseId)
        fiatTableView.delegate = self
        fiatTableView.dataSource = self
        fiatTableView.separatorStyle = .none
        fiatTableView.rowHeight = 100
        
        self.view.addSubview(fiatTableView)
        
        fiatTableView.snp.makeConstraints { make in
            make.top.equalTo(fiatTotalView.snp.bottom).inset(-10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setupAddButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        addNewFiatButton = UIButton(configuration: config, primaryAction: UIAction() { _ in
            self.presenter.showCurrencyView()
        })
        
        view.addSubview(addNewFiatButton)
        
        addNewFiatButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(70)
        }
    }
    
    deinit {
        print("FiatViewController deinited")
    }
}

// MARK: - TableView
extension FiatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.fiatCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiatCell.reuseId, for: indexPath) as! FiatCell
        cell.currencyImage.image = UIImage(systemName: "dollarsign.circle.fill")
        cell.amountCurrency.text = presenter.fiatCurrencyList[indexPath.row].amountCurrency
        cell.amountCurrencySymbol.text = presenter.fiatCurrencyList[indexPath.row].amountCurrencySymbol
        cell.convertedValue.text = presenter.fiatCurrencyList[indexPath.row].convertedValue
        cell.earnPercent.text = String("0" + " " + "%")
        return cell
    }
}

// MARK: - Bindings
extension FiatViewController: FiatViewProtocol {
    func updateFiatView() {
        fiatTableView.reloadData()
    }
}
