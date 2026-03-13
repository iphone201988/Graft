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

struct NewAddingInfo {
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
    var socialURL: String?
    var tagName: String?
    var tagDesc: String?
    var tagColorID: String?
    var tagHexaColor: String?
    var interactionType: String?
    var interactionSubject: String?
    var interactionNote: String?
    var interactionCreatedAt: String?
    var interactionIcon: String?
    var existingContactID: String?
}
