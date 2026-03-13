import Foundation

// MARK: - DashboardModel
struct DashboardModel: Codable {
    let success: Int?
    let message: String?
    let data: DashboardData?
}

// MARK: - DashboardData
struct DashboardData: Codable {
    let stats: Stats?
    let lists: Lists?
    let preferences: [Preference]?
}

// MARK: - Lists
struct Lists: Codable {
    let recent_activity: [Favorite]?
    let favorites: [Favorite]?
    let upcoming_birthdays: [Favorite]?
}

// MARK: - Favorite
struct Favorite: Codable {
    let id: Int?
    let full_name: String?
    let avatar_url: String?
    let birthday: String?
    let days_until: Int?
}

// MARK: - Preference
struct Preference: Codable {
    let id: Int?
    let user_id: Int?
    let widget_key: String?
    let is_visible: Bool?
    let sort_order: Int?
    let created_at: String?
    let updated_at: String?
}

// MARK: - Stats
struct Stats: Codable {
    let total_contacts: Int?
    let duplicates_found: Int?
    let lost_touch: Int?
    let connected_sources: Int?
    let upcoming_birthdays: Int?
    let favorites_count: Int?
}
