import UIKit

class CompositionRoot {
    
    // MARK: - Properties
    
    static var sharedInstance: CompositionRoot = CompositionRoot()
    
    var rootTabBarController: UITabBarController!
    
    // MARK: - Initializer
    
    required init() {
        configureRootTabBarController()
    }
    
    // MARK: - Methods
    
    func configureRootTabBarController() {
        rootTabBarController = UITabBarController()
        rootTabBarController.tabBar.isTranslucent = false
    }
    
    func resolveContactsListViewController() -> ContactsListViewController {
        let contactsListVC = ContactsListViewController.instantiateFromStoryboard("ContactsList")
        contactsListVC.viewModel = resolveContactsListViewModel(view: contactsListVC, coreData: resolveCoreDataStack(), networkManager: resolveNetworkManager())
        return contactsListVC
    }
    
    func resolveContactDetailsViewController(contact: ContactModel) -> ContactDetailsViewController {
        let contactsDetailsVC = ContactDetailsViewController.instantiateFromStoryboard("ContactDetails")
        contactsDetailsVC.viewModel = resolveContactDetailsViewModel(contact: contact)
        return contactsDetailsVC
    }
    
    // MARK: - Model Resolve
    
    func resolveContactsListViewModel(view: ContactsListProtocol, coreData: CoreDataStack, networkManager: NetworkManager) -> ContactsListViewModel {
        return ContactsListViewModel(view: view, coreData: coreData, networkManager: networkManager)
    }
    
    func resolveContactDetailsViewModel(contact: ContactModel) -> ContactDetailsViewModel {
        return ContactDetailsViewModel(contact: contact)
    }
    
    func resolveCoreDataStack() -> CoreDataStackImpl {
        return CoreDataStackImpl()
    }
    
    func resolveNetworkManager() -> NetworkManagerImpl {
        return NetworkManagerImpl()
    }
}
