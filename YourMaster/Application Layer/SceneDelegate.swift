
import UIKit
import GoogleMaps
import IQKeyboardManager

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: CoordinatorInput?
    
    private lazy var serviceAssembly: ServiceAssemblyProtocol = ServiceAssembly()
    private lazy var coordinatorsAssembly: AssemblyFactory = AssemblyFactory(serviceAssembly: serviceAssembly)


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "Готово"
        GMSServices.provideAPIKey(AppDefaults.GoogleMaps.apiKey)
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator(coordinatorsAssembly: coordinatorsAssembly, navigationController: navigationController, userDefaults: UserDefaultsWrapper())
        appCoordinator?.start()
    }
}

