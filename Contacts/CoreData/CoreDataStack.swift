import UIKit
import CoreData

// MARK: - CoreDataStack Protocol

protocol CoreDataStack {
    var context: NSManagedObjectContext { get }
    func isCoreDataEmpty() -> Bool?
    func loadAllContacts() -> [ContactModel]
    func deleteAllContacts()throws
}

class CoreDataStackImpl: CoreDataStack {
    
    // MARK: - Public Properties
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Public Methods
    
    // проверяем есть ли в CoreData элементы
    func isCoreDataEmpty() -> Bool? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactModel")
        var results : Array<Any>?
        
        do {
            results = try context.fetch(fetchRequest) as! [NSManagedObject]
            return results?.count == 0
        } catch {
            print("CoreData fetching error!")
            print(error.localizedDescription)
            return nil
        }
    }
    
    // получаем все контакты из CoreData
    func loadAllContacts() -> [ContactModel] {
        var contacts = [ContactModel]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ContactModel")
        let sort = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        do {
            contacts = try context.fetch(fetchRequest) as! [ContactModel]
        } catch {
            print("CoreData fetching error!")
            print(error.localizedDescription)
        }
        return contacts
    }
    
    // удаляем все элементы из CoreData
    func deleteAllContacts() throws {
        let fetchRequest = ContactModel.fetchRequest() as NSFetchRequest<NSFetchRequestResult>

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try self.context.execute(deleteRequest)
        try self.context.save()
    }
}
