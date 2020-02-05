import UIKit
import CoreData

class ContactsListViewModel: ViewModel {
    
    // MARK: - Properties
    
    var contacts: [ContactModel]
    
    var view: ContactsListProtocol!
    
    var coreData: CoreDataStack!
    
    var networkManager: NetworkManager!
    
    // MARK: - Initializer
    
    init(view: ContactsListProtocol, coreData: CoreDataStack, networkManager: NetworkManager) {
        self.view = view
        self.coreData = coreData
        self.networkManager = networkManager
        self.contacts = [ContactModel]()
    }
    
    // MARK: - Methods
    
    func pushToContactDetails(contact: ContactModel) {
        Coordinator.shared.goContactDetailsViewController(contact: contact)
    }
    
    func pullToRefresh() {
        getContactsFromNetwork()
    }
    
    func getContactsFromNetwork() {
        do {
            try coreData.deleteAllContacts()
        } catch {
            print("CoreData deleting error!")
        }
        
        networkManager.getContacts { (contacts) in
            let contactsListModel = self.convertContactsForCD(contacts: contacts)
            self.contacts = contactsListModel
            self.view.reloadTableView()
        }
    }
    
    // проверяем пустая ли CoreData, если пустая - берем данные с сервера
    // если не пустая - берем данные из CoreData
    func launchFetchContacts() throws {
        guard let isCoreDataEmpty = coreData.isCoreDataEmpty() else {
            print("CoreData fetching error!")
            return }
        if isCoreDataEmpty {
            getContactsFromNetwork()
            try coreData.context.save()
        } else {
            coreData.loadAllContacts { (contacts) in
                self.contacts = contacts
            }
        }
        self.view.reloadTableView()
    }
    
    // MARK: - Конвертация типов данных
    
    // TODO: поправить костыль
    // конвертируем тип Contact в тип сущности CoreData ContactModel
    func convertContactsForCD(contacts: [Contact]) -> [ContactModel] {
        var contactsCD = [ContactModel]()
        for contact in contacts {
            let contactCD = ContactModel(context: coreData.context)
            contactCD.id = contact.id ?? 0.0
            contactCD.name = contact.name
            contactCD.surname = contact.surname
            contactCD.email = contact.email
            contactCD.gender = contact.gender
            contactCD.imageStr = contact.imageStr
            contactsCD.append(contactCD)
        }
        return contactsCD
    }
}
