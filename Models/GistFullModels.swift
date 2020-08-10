//
//  GistFullModels.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 09.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation

struct GistFull: Codable {
    var url: String?
    var forksURL: String?
    var commitsURL: String?
    var id: String?
    var nodeID: String?
    var gitPullURL: String?
    var gitPushURL: String?
    var htmlURL: String?
    var files: [String: GistFile]
    var searchPublic: Bool?
    var createdAt: Date?
    var updatedAt: Date?
    var searchDescription: String?
    var comments: Int?
    var user: JSONNull?
    var commentsURL: String?
    var owner: Owner?
    var forks: [Fork]?
    var history: [Commit]?
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
        case forks = "forks"
        case history = "history"
        case truncated = "truncated"
    }
}

// MARK: - GistFile
struct GistFile: Codable {
    var filename: String?
    var type: String?
    var language: String?
    var rawURL: String?
    var size: Int?
    var truncated: Bool?
    var content: String?

    enum CodingKeys: String, CodingKey {
        case filename = "filename"
        case type = "type"
        case language = "language"
        case rawURL = "raw_url"
        case size = "size"
        case truncated = "truncated"
        case content = "content"
    }
}

// MARK: - Fork
struct Fork: Codable {
    var url: String?
    var user: Owner?
    var id: String?
    var createdAt: Date?
    var updatedAt: Date?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case user = "user"
        case id = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - Commit
struct Commit: Codable {
    var user: Owner?
    var version: String?
    var committedAt: Date?
    var changeStatus: ChangeStatus?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case version = "version"
        case committedAt = "committed_at"
        case changeStatus = "change_status"
        case url = "url"
    }
}

// MARK: - ChangeStatus
struct ChangeStatus: Codable {
    var total: Int?
    var additions: Int?
    var deletions: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case additions = "additions"
        case deletions = "deletions"
    }
}
