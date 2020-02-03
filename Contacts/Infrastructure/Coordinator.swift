import UIKit

class Coordinator {
    
    // MARK: - Public Properties
    
    static let shared = Coordinator()
    
    // MARK: - Private properties
    
    private var lastPresentedViewController: UIViewController?
    
    private var baseNavigationController: UINavigationController? {
        return lastPresentedViewController?.navigationController
    }
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private var compositionRoot: CompositionRoot {
        return CompositionRoot.sharedInstance
    }
    
    // MARK: - Methods
    
    func goContactDetailsViewController(contact: ContactModel) {
        push(compositionRoot.resolveContactDetailsViewController(contact: contact))
    }
    
    func push(_ vc: UIViewController) {
        if let baseNavigationController = baseNavigationController {
            baseNavigationController.pushViewController(vc, animated: true)
            lastPresentedViewController = vc
        } else {
            if let navigationController = appDelegate.window?.rootViewController as? UINavigationController {
                navigationController.pushViewController(vc, animated: true)
            }
        }
    }
    
    func setNavigationsetViewController(_ vc: UIViewController) {
        if let baseNavigationController = baseNavigationController {
            baseNavigationController.setViewControllers([vc], animated: true)
            lastPresentedViewController = vc
        } else {
            if let navigationController = appDelegate.window?.rootViewController as? UINavigationController {
                navigationController.setViewControllers([vc], animated: true)
            }
        }
    }
}
