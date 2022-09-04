//
//  FiatTableView.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 02.09.2022.
//

import UIKit

class FiatTableView: UIView {
    private var dropShadow: DropShadowProtocol!
    private var gradientor: GradientProtocol!
    lazy var fiatTableView = createFiatTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fiatTableView.register(FiatCell.self, forCellReuseIdentifier: FiatCell.reuseId)
        fiatTableView.delegate = self
        fiatTableView.dataSource = self
        fiatTableView.rowHeight = 100
        fiatTableView.separatorStyle = .none
        
        addSubview(fiatTableView)
        
        fiatTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension FiatTableView {
    private func createFiatTableView() -> UITableView {
        let tableView = UITableView(frame: CGRect.zero)
        return tableView
    }
}

extension FiatTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FiatCell.reuseId, for: indexPath) as! FiatCell
        cell.currencyImage.image = UIImage(systemName: "dollarsign.circle.fill")
        cell.amountCurrency.text = "foo"
        cell.amountCurrencySymbol.text = "bar"
        cell.convertedValue.text = "baz"
        cell.earnPercent.text = String("0" + " " + "%")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableViewHeader(frame: CGRect.zero)
        dropShadow = DropShadow(onView: headerView)
        gradientor = Gradientor(forView: headerView,
                                topColor: UIColor.systemBlue.cgColor,
                                bottomColor: UIColor.systemRed.cgColor)
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
        print("edit")
    }
    
    func moveToTrash(index: Int) {
        print("moveToTrash")
    }
}
