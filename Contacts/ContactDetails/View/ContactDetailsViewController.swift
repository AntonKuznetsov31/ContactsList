import UIKit

class ContactDetailsViewController: BaseViewController<ContactDetailsViewModel>, UITextViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contactNameTextField: UITextField!
    @IBOutlet weak var contactSurnameTextField: UITextField!
    @IBOutlet weak var contactEmailTextField: UITextField!
    @IBOutlet weak var contactImage: ImageView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        textFieldSettings()
    }
    
    func textFieldSettings() {
        guard let contact = viewModel.contact else { return }
        contactNameTextField.delegate = self
        contactSurnameTextField.delegate = self
        contactEmailTextField.delegate = self
        
        contactNameTextField.textContentType = .name
        contactSurnameTextField.textContentType = .name
        contactEmailTextField.textContentType = .emailAddress
        
        contactNameTextField.autocapitalizationType = .words
        contactSurnameTextField.autocapitalizationType = .words
        
        contactNameTextField.text = contact.name
        contactSurnameTextField.text = contact.surname
        contactEmailTextField.text = contact.email
        contactImage.fetchImage(with: contact.imageStr)
    }
}

// MARK: - Text Field Delegate

extension ContactDetailsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let userText = textField.text else { return }
        guard let contact = viewModel.contact else { return }
        switch textField.tag {
        case 100:
            contact.name = userText
        case 101:
            contact.surname = userText
        case 102:
            contact.email = userText
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
