//
//  GistPresenter.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 08.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

protocol GistViewDelegate: class {
    var gistTableView: UITableView { get set }
}

class GistPresenter {
    var viewDelegate: GistViewDelegate?
    var gistId: String? {
        didSet {
            loadGist()
        }
    }

    private var gist: GistFull? {
        didSet {
            headerInfo.ownerName = prepareDataString(gist?.owner?.login)
            headerInfo.gistName = prepareDataString(gist?.searchDescription)
            if let url = gist?.owner?.avatarURL {
                AvatarManager.shared.getImage(urlString: url, completion: { [weak self] image in
                    self?.headerInfo.avatar = image
                })
            }
            gist?.files.forEach { file in
                filesInfo.append((file.value.filename, file.value.content))
            }
            viewDelegate?.gistTableView.reloadData()
        }
    }

    private var gistCommits: [Commit]? {
        didSet {
            gistCommits?.forEach { commit in
                let userName = prepareDataString(commit.user?.login)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
                var dateString = "Unknown date"
                if let date = commit.committedAt {
                    dateString = dateFormatter.string(from: date)
                }
                let addCount = prepareDataString(commit.changeStatus?.additions.flatMap(String.init))
                let delCount = prepareDataString(commit.changeStatus?.deletions.flatMap(String.init))

                commitsInfo.append((userName: userName,
                                    avatar: commit.user?.avatarURL,
                                    date: dateString,
                                    addCount: addCount,
                                    delCount: delCount))
            }
            viewDelegate?.gistTableView.reloadSections([2], with: .automatic)
        }
    }

    var headerInfo: (ownerName: String, avatar: UIImage?, gistName: String) = ("", nil, "")
    var filesInfo: [(fileName: String?, body: String?)] = []
    var commitsInfo: [(userName: String, avatar: String?, date: String, addCount: String, delCount: String)] = []

    func prepareDataString(_ string: String?) -> String {
        if let string = string {
            return string.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 ? string : "Unknown"
        }
        return "Unknown"
    }

    func loadGist() {
        guard let gistId = gistId else { return }
        let urlString = "https://api.github.com/gists/\(gistId)"

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        let content = self.parseGist(json: data)
                        self.gist = content
                    }
                }
            }
        }
    }

    func parseGist(json: Data) -> GistFull? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try? decoder.decode(GistFull.self, from: json)
    }

    func loadCommits() {
        guard let gistId = gistId else { return }
        let urlString = "https://api.github.com/gists/\(gistId)/commits"

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        let content = self.parseCommits(json: data)
                        self.gistCommits = content
                    }
                }
            }
        }
    }

    func parseCommits(json: Data) -> [Commit]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try? decoder.decode([Commit].self, from: json) 
    }
    
}
