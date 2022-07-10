//
//  SceneDelegate.swift
//  FiatMoneyCoin
//
//  Created by tambanco 🥳 on 28.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        let assemblyBuilder = AssemblyModuleBuilder()
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        let amountForCell = ["foo": "bar"]
        let fiatViewController = assemblyBuilder.createFiatModule(router: router, amountForCell: amountForCell)
        navigationController.viewControllers = [fiatViewController]
        window?.rootViewController = navigationController
        window?.rootViewController?.view.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
