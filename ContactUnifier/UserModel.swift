import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let success: Int?
    let message: String?
    let data: UserData?
}

// MARK: - UserData
struct UserData: Codable {
    let user: User?
    let token_type: String?
    let access_token: String?
    let refresh_token: String?
    let expires_at: String?
    let token_id: String?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let avatar: String?
    let timezone: String?
    let birthday_reminder_days: [String]?
    let is_active: Bool?
    let is_admin: Bool?
    let is_email_verified: Bool?
    let last_seen_at: String?
    let created_at: String?
    let is_social_auth: Bool?
    let linked_providers: [String]?
    let social_accounts: [String]?
    let devices: [Device]?
}

// MARK: - Device
struct Device: Codable {
    let id: Int?
    let device_type: String?
    let login_type: String?
    let device_name: String?
    let app_version: String?
    let os_version: String?
    let last_used_at: String?
    let last_ip: String?
    let is_active: Bool?
    let is_current_session: Bool?
}

struct TokenData: Codable {
    let success: Int?
    let message: String?
    let data: String?
}
