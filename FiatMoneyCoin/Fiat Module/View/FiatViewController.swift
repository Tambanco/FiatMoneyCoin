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
    private var dropShadow: DropShadowProtocol!
    private var gradientor: GradientProtocol!
    private var animator: AnimatorProtocol!
    private var hapticTouch: HapticFeedBackerProtocol!
    private let refreshControl = UIRefreshControl()
    
    var presenter: FiatPresenterProtocol!
    private var fiatTableView: UITableView!
    private var addNewFiatButton: UIButton!
    
    private var totalValue: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFiatTableView()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let viewForGradient = self.fiatTableView.tableHeaderView
        
        self.gradientor = Gradientor(forView: viewForGradient ?? UIView(),
                                     topColor: UIColor(hexString: colorCode.four.rawValue).cgColor,
                                     bottomColor: UIColor(hexString: colorCode.three.rawValue).cgColor)
        self.presenter.fetchCurrency { _ in
            fiatTableView.reloadData()
        }
    }
    
    @objc func refresh() {
        self.fiatTableView.reloadData()
        presenter.fetchCurrency { view in
            fiatTableView.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    func setupFiatTableView() {
        fiatTableView = UITableView(frame: CGRect.zero)
        fiatTableView.register(FiatCell.self, forCellReuseIdentifier: FiatCell.reuseId)
        fiatTableView.delegate = self
        fiatTableView.dataSource = self
        fiatTableView.rowHeight = 100
        fiatTableView.separatorStyle = .none
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        
        view.addSubview(fiatTableView)
        fiatTableView.addSubview(refreshControl)
        
        fiatTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    private func setupAddButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = UIColor(hexString: colorCode.three.rawValue)
        config.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        addNewFiatButton = UIButton(configuration: config, primaryAction: UIAction() { _ in
            self.presenter.showCurrencyView()
        })
        
        view.addSubview(addNewFiatButton)
        addNewFiatButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(90)
        }
    }
}

// MARK: - Bindings
extension FiatViewController: FiatViewProtocol {
    func showEditAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateTotalView(totalValue: String?) {
        self.totalValue = totalValue ?? "0"
    }
    
    func updateFiatView() {
        fiatTableView.reloadData()
    }
}

extension FiatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.fiatCurrenciesFromCoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiatCell.reuseId, for: indexPath) as! FiatCell
        cell.currencyImage.image = UIImage(systemName: "dollarsign.circle.fill")
        cell.amountCurrency.text = presenter.fiatCurrenciesFromCoreData[indexPath.row].value(forKey: "totalCurrency") as? String
        cell.amountCurrencySymbol.text = presenter.fiatCurrenciesFromCoreData[indexPath.row].value(forKey: "currencySymbol") as? String
        cell.convertedValue.text = presenter.fiatCurrenciesFromCoreData[indexPath.row].value(forKey: "convertedValue") as? String
        cell.earnPercent.text = String("0" + " " + "%")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableViewHeader(frame: CGRect.zero)
        dropShadow = DropShadow(onView: headerView)
        gradientor = Gradientor(forView: headerView,
                                topColor: UIColor.systemBlue.cgColor,
                                bottomColor: UIColor.systemRed.cgColor)
        headerView.totalLabel.text = "Сумма: \(totalValue)"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    // MARK: - Cell manipulation
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let config = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        let trash = UIContextualAction(style: .normal,
                                       title: nil) { [weak self] (action, view, completionHandler) in
            self?.moveToTrash(index: indexPath.row)
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed
        trash.image = UIImage(systemName: "trash.circle.fill", withConfiguration: config)
        
        let edit = UIContextualAction(style: .normal,
                                      title: nil) { [weak self] (action, view, completionHandler) in
            self?.editValue(index: indexPath.row)
        }
        
        edit.backgroundColor = .systemGray2
        edit.image = UIImage(systemName: "pencil.circle.fill", withConfiguration: config)
        let configuration = UISwipeActionsConfiguration(actions: [trash, edit])
        
        return configuration
    }
    
    func editValue(index: Int) {
        presenter.editCurrencyValue(rowIndex: index)
    }
    
    func moveToTrash(index: Int) {
        presenter.removeCurrency(rowIndex: index)
    }
}

// MARK: - NavBar
extension FiatViewController {
    private func setupNavigationBar() {
        let settingsButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "gear")
        settingsButton.setImage(imageView.image, for: .normal)
        settingsButton.backgroundColor = UIColor(hexString: "#e96443")
        settingsButton.tintColor = UIColor(hexString: "e96443")
        settingsButton.layer.cornerRadius = 10
        if let imageView = settingsButton.imageView {
            settingsButton.bringSubviewToFront(imageView)
        }
        
        dropShadow = DropShadow(onView: settingsButton)
        gradientor = Gradientor(forView: settingsButton,
                                topColor: UIColor.systemGray4.cgColor,
                                bottomColor: UIColor.systemGray5.cgColor)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem(customView: settingsButton)
        self.navigationItem.rightBarButtonItems = [rightBarButton]
    }
    
    @objc private func settingsTapped() {
        print("foo")
    }
    
    @objc private func profileTapped() {
        print("profileTapped")
    }
}
