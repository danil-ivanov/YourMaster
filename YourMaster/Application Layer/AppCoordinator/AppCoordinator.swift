//
//  AppCoordinator.swift
//  YourMaster
//
//  Created by Maxim Egorov on 21.06.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import class UIKit.UINavigationController
import class UIKit.UIWindow
import Foundation

///Протокол для взаимодействия с координатором
protocol CoordinatorInput: AnyObject {

    ///запустить флоу
    func start()
}

///Координатор, который выбирает стартовый флоу приложения
final class AppCoordinator: CoordinatorInput {
    private let userDefaults: UserDefaultsWrapperProtocol
    private let coordinatorsAssembly: AssemblyFactory

    private var loginFlowCoordinator: (CoordinatorInput & LoginFlowCoordinatorOutput)?

    init(coordinatorsAssembly: AssemblyFactory, navigationController: UINavigationController, userDefaults: UserDefaultsWrapperProtocol) {
        self.coordinatorsAssembly = coordinatorsAssembly
        self.userDefaults = userDefaults
    }
    
    func start() {
        guard let _ = try? userDefaults.getToken() else {
            loginFlowCoordinator = coordinatorsAssembly.createLoginAssembly().coordinator()
            loginFlowCoordinator?.onLoginSucces = { [weak self] in
                DispatchQueue.main.async {
                    self?.startShopsFlow()
                }
            }
            loginFlowCoordinator?.start()
            return
        }
        startShopsFlow()
    }
    
    private func startShopsFlow() {
        loginFlowCoordinator = nil
        coordinatorsAssembly.createShopsAssembly().coordinator().start()
    }
    
    deinit {
        print("Deinit AppCoordinator")
    }
}
