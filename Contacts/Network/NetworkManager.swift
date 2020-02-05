import Alamofire

protocol NetworkManager {
    func getContacts(completion: @escaping ([Contact]) -> Void) -> ()
}

class NetworkManagerImpl: NetworkManager {
    
    // MARK: - Public Methods
    
    func getContacts(completion: @escaping ([Contact]) ->  () )  {
        let url = "https://api.mockaroo.com/api/30600730"
        //let url = "https://api.mockaroo.com/api/41444880"
        let key = "ba104fe0"
        let count = "3"
        let urlMain = "\(url)?count=\(count)&key=\(key)"
        Alamofire
            .request(urlMain, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON { dataResponse in
                do {
                    let contacts = try JSONDecoder().decode([Contact].self, from: dataResponse.data!)
                    DispatchQueue.main.async {
                        completion(contacts)
                    }
                }
                catch {
                    print("Alamofire request error!")
                    print(error.localizedDescription)
                }
        }
    }
}
