import Foundation

// MARK: - ContactModel
struct ContactModel: Codable {
    let success: Int?
    let message: String?
    let data: ContactData?
}

struct ContactsModel: Codable {
    let success: Int?
    let message: String?
    let data: ContactsMetaData?
}

struct ContactsMetaData: Codable {
    let data: [ContactData]?
}

// MARK: - ContactData
struct ContactData: Codable {
    let id: Int?
    let full_name: String?
    let prefix: String?
    let first_name: String?
    let last_name: String?
    let middle_name: String?
    let nickname: String?
    let company: String?
    let job_title: String?
    let department: String?
    let website: String?
    let avatar_url: String?
    let birthday: String?
    let note: String?
    let source: String?
    let is_favorite: Bool?
    let is_archived: Bool?
    let last_contacted_at: String?
    let primary_email: String?
    let primary_phone: String?
    let emails: [Email]?
    let phones: [Email]?
    let addresses: [Address]?
    let social_links: [SocialLink]?
    let tags: [String]?
    let created_at: String?
    let updated_at: String?
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let label: String?
    let street: String?
    let city: String?
    let state: String?
    let zip_code: String?
    let country: String?
    let is_primary: Bool?
}

// MARK: - Email
struct Email: Codable {
    let id: Int?
    let label: String?
    let email: String?
    let is_primary: Bool?
    let phone_number: String?
}

// MARK: - SocialLink
struct SocialLink: Codable {
    let id: Int?
    let platform: String?
    let url: String?
    let username: String?
}
