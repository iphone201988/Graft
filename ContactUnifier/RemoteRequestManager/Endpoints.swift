enum Endpoints: String {
    case register = "auth/register"
    case login = "auth/login"
    case forgotPassword = "auth/forgot-password"
    case refreshToken = "auth/refresh-token"
    case profile = "auth/me"
    case logout = "auth/logout"
    case contacts = "contacts"
    case tags = "tags"
    case colors = "colors"
}

enum HttpMehtods: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum HttpBodyType: String {
    case formData
    case urlEncoded
    case rawJSON
    case binary
    case graphQL
}
