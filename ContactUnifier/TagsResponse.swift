import Foundation

// MARK: - TagsModel
struct TagsModel: Codable {
    let success: Int?
    let message: String?
    let data: [TagData]?
}

struct TagModel: Codable {
    let success: Int?
    let message: String?
    let data: TagData?
}

// MARK: - TagData
struct TagData: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let color: String?
    let contacts_count: Int?
    let created_at: String?
}

struct ColorsModel: Codable {
    let success: Int?
    let message: String?
    let data: [ColorData]?
}

// MARK: - ColorData
struct ColorData: Codable, Hashable {
    let id: Int?
    let code: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

    static func == (lhs: ColorData, rhs: ColorData) -> Bool {
        return lhs.code == rhs.code
    }
}
