import UIKit

class ContactDetailsViewModel: ViewModel {
    
    // MARK: - Properties
    
    var contact: ContactModel? = nil
    
    // MARK: - Initializer
    
    init(contact: ContactModel) {
        self.contact = contact
    }
}
