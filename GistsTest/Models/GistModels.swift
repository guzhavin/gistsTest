// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let search = try? newJSONDecoder().decode(Search.self, from: jsonData)

import Foundation

// MARK: - Gist
struct Gist: Codable {
    var url: String?
    var forksURL: String?
    var commitsURL: String?
    var id: String?
    var nodeID: String?
    var gitPullURL: String?
    var gitPushURL: String?
    var htmlURL: String?
    var files: [String: File]?
    var searchPublic: Bool?
    var createdAt: Date?
    var updatedAt: Date?
    var searchDescription: String?
    var comments: Int?
    var user: JSONNull?
    var commentsURL: String?
    var owner: Owner?
    var truncated: Bool?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case forksURL = "forks_url"
        case commitsURL = "commits_url"
        case id = "id"
        case nodeID = "node_id"
        case gitPullURL = "git_pull_url"
        case gitPushURL = "git_push_url"
        case htmlURL = "html_url"
        case files = "files"
        case searchPublic = "public"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case searchDescription = "description"
        case comments = "comments"
        case user = "user"
        case commentsURL = "comments_url"
        case owner = "owner"
        case truncated = "truncated"
    }
}

// MARK: - File
struct File: Codable {
    var filename: String?
    var type: String?
    var language: String?
    var rawURL: String?
    var size: Int?

    enum CodingKeys: String, CodingKey {
        case filename = "filename"
        case type = "type"
        case language = "language"
        case rawURL = "raw_url"
        case size = "size"
    }
}

// MARK: - Owner
struct Owner: Codable {
    var login: String?
    var id: Int?
    var nodeID: String?
    var avatarURL: String?
    var gravatarID: String?
    var url: String?
    var htmlURL: String?
    var followersURL: String?
    var followingURL: String?
    var gistsURL: String?
    var starredURL: String?
    var subscriptionsURL: String?
    var organizationsURL: String?
    var reposURL: String?
    var eventsURL: String?
    var receivedEventsURL: String?
    var type: String?
    var siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login = "login"
        case id = "id"
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url = "url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type = "type"
        case siteAdmin = "site_admin"
    }
}

typealias Gists = [Gist]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
