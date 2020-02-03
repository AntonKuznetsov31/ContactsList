import Foundation

struct Contact: Codable {
    
    // MARK: - Public Properties
    
    var id: Float?
    var name: String?
    var surname: String?
    var email: String?
    var gender: String?
    var imageStr: String?
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "first_name"
        case surname = "last_name"
        case email = "email"
        case gender = "gender"
        case imageStr = "image"
    }
}
