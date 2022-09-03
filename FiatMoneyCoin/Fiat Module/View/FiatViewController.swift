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
    private var dropShadow: DropShadowProtocol!
    private var gradientor: GradientProtocol!
    private var animator: AnimatorProtocol!
    private var hapticTouch: HapticFeedBackerProtocol!
    private var fiatTableView: FiatTableView!
    private var addNewFiatButton: UIButton!
    
    private func createFiatTableView() {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupFiatTableView()
        setupAddButton()
    }
    
    func setupFiatTableView() {
        fiatTableView = FiatTableView(frame: CGRect.zero)
        view.addSubview(fiatTableView)
        
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
        self.fiatTableView.totalValue = totalValue ?? "0"
    }
    func updateFiatView() {
        fiatTableView.fiatTableView.reloadData()
    }
}

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
