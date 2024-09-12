import Foundation

struct ApiResponse: Codable {
    let uuid: String
    let status: String
    let progress: Float
    let url: String?
    let gif_url: String?
}

