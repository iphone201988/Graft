import UIKit

enum AppStoryboards: String {
    case main = "Main"
    
    var storyboardInstance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
    
    func controller<T: UIViewController>(_ type: T.Type) -> T? {
        let identifier = String(describing: type)
        return storyboardInstance.instantiateViewController(withIdentifier: identifier) as? T
    }
}

enum Events: String, CaseIterable {
    case landing = "Landing"
    case login = "Login"
    case newRegistration = "New Registration"
    case generalMemberAccountRegistration = "General Member"
    case financialAdvisorAccountRegistration = "Financial Advisor"
    case financialFirmAccountRegistration = "Financial Firm"
    case smallBusinessAccountRegistration = "Small Business"
    case startupAccountRegistration = "Startup"
    case investorVCAccountRegistration = "Investor/ VC"
    case forgotPassword = "Forgot Password"
    case isAlreadyLogged = "Is Already Logged"
    case unspecified = "Unspecified"
    case exchangeShare = "Exchange Share"
    case exchangeStream = "Exchange Stream"
    case exchangeVault = "Exchange Vault"
    case insurance = "Insurance"
    case addComment = "Add Comment"
    case getComments = "Get Comments"
    case likeDislikeComment = "Like Dislike Comment"
    
    var type: String {
        switch self {
        case .generalMemberAccountRegistration: return "general_member"
        case .financialAdvisorAccountRegistration: return "financial_advisor"
        case .financialFirmAccountRegistration: return "financial_firm"
        case .smallBusinessAccountRegistration: return "small_business"
        case .startupAccountRegistration: return "startup"
        case .investorVCAccountRegistration: return "investor"
        default: return ""
        }
    }
    
    static func registrationFor(role: String) -> Events? {
        for event in self.allCases {
            if event.type == role {
                return event
            }
        }
        return nil
    }
}

enum ProfileSections: String, CaseIterable {
    case profile = "Profile"
    case edit = "Edit"
    case calendar = "Calendar"
    case saved = "Saved"
}

enum AccountOptions: String, CaseIterable {
    case profileDetails = "Profile Details"
    case familyAndEducation = "Family & Education"
    case financialInformation = "Financial Information"
    case investmentSummary = "Investment Summary (Optional)"
    case additionalInformation = "Additional Information"
    case accountDetails = "Account Details"
    case changePassword = "Change Password"
}

enum AccountManagementOptions: String, CaseIterable {
    //case memberAgreement = "Member Agreement"
    case accountVerification = "Account Verification"
    case lastLogin = "Last Login"
    case deleteAccount = "Delete Account"
    case logout = "Logout"
}

enum AccountOptionsViaFinancialAdvisors: String, CaseIterable {
    case profileDetails = "Profile Details"
    case professionalInformation = "Professional Information"
    case personalPreferences = "Personal Preferences"
    case formUpload = "Form Upload"
    case accountDetails = "Account Details"
    case changePassword = "Change Password"
}

enum AccountManagementOptionsViaFinancialAdvisors: String, CaseIterable {
    //case advisorAgreement = "Advisor Agreement"
    case accountVerification = "Account Verification"
    case lastLogin = "Last Login"
    case deleteAccount = "Delete Account"
    case logout = "Logout"
}

enum AccountOptionsViaStartUp: String, CaseIterable {
    case profileDetails = "Profile Details"
    case businessFinancialInformation = "Business & Financial Information"
    case additionalInformation = "Additional Information"
    case formUpload = "Form Upload"
    case accountDetails = "Account Details"
    case changePassword = "Change Password"
}

enum AccountManagementOptionsViaStartUp: String, CaseIterable {
    //case startupAgreements = "Startup Agreements"
    case accountVerification = "Account Verification"
    case lastLogin = "Last Login"
    case deleteAccount = "Delete Account"
    case logout = "Logout"
}

enum SavedOptions: String, CaseIterable {
    case share = "Shares"
    case stream = "Streams"
    case vault = "Vaults"
    case user = "Users"
    
    var interfaceTitleValue: String {
        switch self {
        case .share: return "Saved Shares"
        case .stream: return "Saved Streams"
        case .vault: return "Saved Streams"
        default: return ""
        }
    }
    
    var type: String {
        switch self {
        case .share: return "share"
        case .stream: return "stream"
        case .vault: return "vault"
        case .user: return "user"
        }
    }
}

enum SideMenuOptions: String, CaseIterable {
    case home = "Home"
    case name = "Name"
    //case inbox = "Inbox"
    //case member = "Member"
    //case financialAdvisors = "Financial Advisors"
    //case startups = "Startups"
    //case smallBusiness = "Small Business"
    //case investorVC = "Investor/ VC"
    case exchange = "Exchange"
    case ecosystem = "Ecosystem"
    //case insurance = "Insurance"
}

enum NameSubMenus: String, CaseIterable {
    case profile = "Profile"
    case inbox = "Inbox"
    case notifications = "Notifications"
    //case dashboard = "Dashboard"
    //case analytics = "Analytics"
}

enum OtherSubMenus: String, CaseIterable {
    case member = "Member"
    case financialAdvisors = "Financial Advisors"
    case startups = "Startups"
    case smallBusiness = "Small Business"
    case investorVC = "Investor/ VC"
}

enum SharedOptions: String {
    case lastLogin = "Last Login"
    case deleteAccount = "Delete Account"
    case logout = "Logout"
    case accountVerification = "Account Verification"
}

enum OTPFor: String {
    case forgot = "1"
    case changeEmail = "2"
    case verification = "3"
}

enum VisibilityMode: String {
    case publicMode = "public"
    case privateMode = "private"
    
    static func isPublic(status: Bool) -> String {
        if status {
            return self.publicMode.rawValue
        } else {
            return self.privateMode.rawValue
        }
    }
}

enum Categories: String, CaseIterable {
    case members = "Members"
    case advisors = "Advisors"
    case startups = "Startups"
    case smallBusinesses = "Small Businesses"
    case investor = "Investor"
    case firm = "Firm"
    
    var type: String {
        switch self {
        case .members: return "general_member"
        case .advisors: return "financial_advisor"
        case .smallBusinesses: return "small_business"
        case .startups: return "startup"
        case .firm: return "financial_firm"
        case .investor: return "investor"
        }
    }
}

enum HomeSections: String, CaseIterable {
    case trendingTopic = "Trending Topic"
    case news = "News"
    case members = "Members"
    case advisors = "Advisors"
    case startups = "Startups"
    case smallBusinesses = "Small Businesses"
    case investor = "Investor"
    case firm = "Firm"
    case ads = "Ads"
    
    var type: String {
        switch self {
        case .members: return "general_member"
        case .advisors: return "financial_advisor"
        case .smallBusinesses: return "small_business"
        case .startups: return "startup"
        case .firm: return "financial_firm"
        case .investor: return "investor"
        default: return ""
        }
    }
    
    var tag: Int {
        switch self {
        case .trendingTopic: return 0
        case .news: return 1
        case .members: return 2
        case .advisors: return 3
        case .startups: return 4
        case .smallBusinesses: return 5
        case .investor: return 6
        case .firm: return 7
        case .ads: return 8
        }
    }
    
    static func getSeletedCategory(by tag: Int) -> Categories? {
        if
            let section = HomeSections.allCases.first(where: { $0.tag == tag }),
            let category = Categories(rawValue: section.rawValue) {
            return category
        } else {
            return nil
        }
    }
}

enum Symbols: String {
    case stock
    case crypto
    case undefined
    
    var title: String {
        switch self {
        case .stock: return "Stock"
        case .crypto: return "Crypto"
        case .undefined: return ""
        }
    }
    
    static func title(for rawValue: String) -> String {
        return Symbols(rawValue: rawValue)?.title ?? ""
    }
}

enum PostKeys {
    case like
    case save
    case comment
    case rating
    case commentCount
    case deletePost
    case reportedPost
    case reshare
    case isFeatured
}

enum CalendarEventTypes: String {
    case scheduled_lives = "scheduled_lives"
    case general_events_by_admin = "general_events_by_admin"
    case own_events = "own_events"
    case other_user_scheduled_lives = "other_user_scheduled_lives"
    
    var typeColor: UIColor {
        switch self {
        case .scheduled_lives: return UIColor(named: "#7D51F9") ?? .systemPurple
        case .general_events_by_admin: return UIColor(named: "#AB8BC3") ?? .systemPurple
        case .own_events: return UIColor(named: "#00B050") ?? .systemGreen
        case .other_user_scheduled_lives: return UIColor(named: "#7F7F7F") ?? .lightGray
        }
    }
}

enum DocumentVerified: String {
    case verified = "approved"
    case rejected = "declined"
    case inReview = "in_review"
    case reject = "reject"
    
    var title: String {
        switch self {
        case .verified: return "Verified"
        case .rejected, .reject: return "Verify yourself"
        case .inReview: return "In review"
        }
    }
}

enum ValidationResult {
    case success
    case failure(String)
}

enum PushNotificationTypes: String {
    case customer = "customer"
    case follower = "follower"
    case live_stream = "live_stream"
    case message = "message"
    case share = "share"
    case share_comment = "share_comment"
    case stream_comment = "stream_comment"
    case vault_comment = "vault_comment"
    case SHARE_LIKE = "share_like"
    case STREAM_LIKE = "stream_like"
    case RESHARE = "reshare"
    case RATINGS_USER = "ratings_user"
    case RATINGS_SHARE = "ratings_share"
    case RATINGS_STREAM = "ratings_stream"
    case RATINGS_Vault = "ratings_vault"
}

enum PurchaseTypes: String {
    case ONE_TIME = "one_time"
    case RECURRING = "recurring"
    
    var title: String {
        switch self {
        case .ONE_TIME: return "One Time Subscription"
        case .RECURRING:  return "Monthly Premium subscription"
        }
    }
}
