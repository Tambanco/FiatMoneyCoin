//
//  FiatViewController.swift
//  FiatMoneyCoin
//
//  Created tambanco 🥳 on 28.06.2022.
//
//  Template generated by Tambanco
//

import Foundation
import UIKit

class FiatViewController: UIViewController {
    var presenter: FiatPresenterProtocol!
    var fiatTotalView: FiatTotalView!
    var dropShadow: DropShadowProtocol!
    var gradientor: GradientProtocol!
    var animator: AnimatorProtocol!
    var fiatTableView: UITableView!
    var addNewFiatButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFiatView()
        setupTotalView()
        setupTableView()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            let viewForGradient = self.fiatTotalView.fiatCardView
        
            self.gradientor = Gradientor(forView: viewForGradient ?? UIView(),
                                         topColor: UIColor(hexString: colorCode.four.rawValue).cgColor,
                                         bottomColor: UIColor(hexString: colorCode.three.rawValue).cgColor)
            
            self.presenter.fetchCurrency()
        }
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.tintColor = Constants.backgroundColorButton
    }
    
    private func setupFiatView() {
        gradientor = Gradientor(forView: self.view,
                                topColor: UIColor(hexString: colorCode.five.rawValue).withAlphaComponent(0.1).cgColor,
                                bottomColor: UIColor(hexString: colorCode.six.rawValue).withAlphaComponent(0.1).cgColor)
    }
    
    private func setupTotalView() {
        fiatTotalView = FiatTotalView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dropShadow = DropShadow(onView: fiatTotalView)
        view.addSubview(fiatTotalView)
        
        fiatTotalView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(0)
            make.trailing.equalToSuperview().inset(0)
            make.height.equalTo(190)
        }
    }
    
    private func setupTableView() {
        fiatTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        fiatTableView.register(FiatCell.self, forCellReuseIdentifier: FiatCell.reuseId)
        fiatTableView.delegate = self
        fiatTableView.dataSource = self
        fiatTableView.separatorStyle = .none
        fiatTableView.backgroundColor = .clear
        fiatTableView.rowHeight = 100
        
        self.view.addSubview(fiatTableView)
        
        fiatTableView.snp.makeConstraints { make in
            make.top.equalTo(fiatTotalView.snp.bottom).inset(-50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func setupAddButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = Constants.backgroundColorButton
        config.baseBackgroundColor = UIColor(hexString: colorCode.three.rawValue)
        config.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        addNewFiatButton = UIButton(configuration: config, primaryAction: UIAction() { _ in
            self.presenter.showCurrencyView()
        })
        
        view.addSubview(addNewFiatButton)
        UIView.animate(withDuration: 0.6,
            animations: {
            self.addNewFiatButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
            },
            completion: { _ in
            UIView.animate(withDuration: 0.6) {
                    self.addNewFiatButton.transform = CGAffineTransform.identity
                }
            })
        addNewFiatButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(70)
        }
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
    
    // MARK: - Cell manipulation
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .normal,
                                       title: "Удалить") { [weak self] (action, view, completionHandler) in
            self?.moveToTrash(index: indexPath.row)
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed
        trash.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        
        return configuration
    }
    
    func moveToTrash(index: Int) {
        presenter.removeCurrency(rowIndex: index)
    }
}

// MARK: - Bindings
extension FiatViewController: FiatViewProtocol {
    func updateTotalView(totalValue: String?) {
        self.fiatTotalView.totalValue.text = totalValue ?? "0"
    }
    func updateFiatView() {
        fiatTableView.reloadData()
    }
}
