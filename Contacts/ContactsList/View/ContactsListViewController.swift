import UIKit

// MARK: - ContactListProtocol

protocol ContactsListProtocol {
    var contactsListTableView: UITableView! { get set }
    func reloadTableView()
}

class ContactsListViewController: BaseViewController<ContactsListViewModel>, ContactsListProtocol {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contactsListTableView: UITableView! {
        didSet {
            contactsListTableView.delegate = self
            contactsListTableView.dataSource = self
            contactsListTableView.refreshControl = UIRefreshControl()
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        do {
            try viewModel.launchFetchContacts()
        } catch {
            print("CoreData loading error")
            print(error.localizedDescription)
        }
        contactsListTableView.refreshControl?.addTarget(self, action: #selector(tableViewWasPulled), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
    }
    
    // MARK: - Methods
    
    func reloadTableView() {
        contactsListTableView.reloadData()
        contactsListTableView.refreshControl?.endRefreshing()
    }
    
    @objc func tableViewWasPulled() {
        viewModel.pullToRefresh()
        reloadTableView()
    }
}

// MARK: - TableView Delegate and DataSource

extension ContactsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as? ContactTableViewCell {
            
            if self.viewModel.contacts.count != 0 {
                cell.configureCellWithContact(contact: self.viewModel.contacts[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.pushToContactDetails(contact: self.viewModel.contacts[indexPath.row] )
    }
}
