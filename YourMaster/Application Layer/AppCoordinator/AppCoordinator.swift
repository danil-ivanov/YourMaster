
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
    private let coordinatorsAssembly: AssemblyFactory

    private var loginFlowCoordinator: (CoordinatorInput & LoginFlowCoordinatorOutput)?

    init(coordinatorsAssembly: AssemblyFactory, navigationController: UINavigationController) {
        self.coordinatorsAssembly = coordinatorsAssembly
    }
    
    func start() {
        guard !AppShared.storage.authorized else {
            startShopsFlow()
            return
        }
        loginFlowCoordinator = coordinatorsAssembly.createLoginAssembly().coordinator()
        loginFlowCoordinator?.onLoginSucces = { [weak self] in
            DispatchQueue.main.async {
                self?.startShopsFlow()
            }
        }
        loginFlowCoordinator?.start()
    }
    
    private func startShopsFlow() {
        loginFlowCoordinator = nil
        coordinatorsAssembly.createShopsAssembly().coordinator().start()
    }
}
