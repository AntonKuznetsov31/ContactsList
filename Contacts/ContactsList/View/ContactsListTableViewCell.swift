import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contactImage: ImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    // MARK: - Methods
    
    func configureCellWithContact(contact: ContactModel) {
        contactNameLabel.text = "\(contact.name ?? "") \(contact.surname ?? "")"
        contactEmailLabel.text = contact.email ?? ""
        contactImage.fetchImage(with: contact.imageStr)
    }
}
