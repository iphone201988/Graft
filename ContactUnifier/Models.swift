import Foundation

struct MergeContacts {
    var name: String
    var source: String
    var phone: String?
    var email: String?
    var company: String?
    var isNameChoose: Bool = false
    var isPhoneChoose: Bool = false
    var isCompanyChoose: Bool = false
}

struct ContactInfo {
    var total: Int
    var info: [MergeContacts]
    var event: MergeContactEvents = .normal
}

struct Contacts {
    var data: [ContactInfo]
}

struct NewContactInfo {
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var company: String?
    var jobTitle: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: String?
    var country: String?
    var birthday: String?
    var note: String?
    var initials: String?
}
