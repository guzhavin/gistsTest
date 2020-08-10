//
//  GistsListPresenter.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 06.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

protocol GistsListViewDelegate: class {
    var contentTableView: UITableView { get set }
    var usersTopCollectionView: UICollectionView { get set }
    func setImageForCell(at indexPath: IndexPath, image: UIImage?)
}

class GistsListPresenter {
    private var currentLoadedPage: Int = 0
    var gists: Gists = [] {
        didSet {
            DispatchQueue.main.async {
                self.viewDelegate?.contentTableView.reloadData()
            }
        }
    }

    private var allUsersTopList: [Int: (name: String, count: Int, avatarUrl: String?)] = [:]

    var amazingTen: [(id: Int, name: String, count: Int, avatarUrl: String?)] = []

    weak var viewDelegate: GistsListViewDelegate?

    func loadGists() {
        currentLoadedPage += 1
        let urlString = "https://api.github.com/gists/public?per_page=50&page=\(currentLoadedPage)"

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        guard let content = self?.parseGists(json: data) else { return }
                        self?.gists.append(contentsOf: content)
                        self?.updateUsersTopList(data: content)
                    }
                }
            }
        }
    }

    func prepareDataString(_ string: String?) -> String {
        if let string = string {
            return string.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 ? string : "Unknown"
        }
        return "Unknown"
    }

    func parseGists(json: Data) -> Gists {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return (try? decoder.decode(Gists.self, from: json)) ?? []
    }

    func loadAvatar(urlString: String, for indexPath: IndexPath) {
        AvatarManager.shared.getImage(urlString: urlString) { [weak self] image in
            self?.viewDelegate?.setImageForCell(at: indexPath, image: image)
        }
    }

    func updateUsersTopList(data: Gists) {
        data.forEach { gist in
            if let id = gist.owner?.id, let name = gist.owner?.login {
                if allUsersTopList[id] != nil {
                    allUsersTopList[id]?.count += 1
                } else {
                    allUsersTopList[id] = (name: name, count: 1, avatarUrl: gist.owner?.avatarURL)
                }
                updateAmazingTenList(id: id)
            }
        }
        viewDelegate?.usersTopCollectionView.reloadData()
    }

    func updateAmazingTenList(id: Int) {
        guard let user = allUsersTopList[id] else { return }
        if amazingTen.isEmpty {
            amazingTen.append((id: id, name: user.name, count: 1, avatarUrl: user.avatarUrl))
        } else {
            if let index = amazingTen.firstIndex(where: { $0.id == id }) {
                amazingTen.remove(at: index)
            }
            for index in (0..<amazingTen.count) {
                if amazingTen[index].count <= user.count {
                    amazingTen.insert((id: id, name: user.name, count: user.count, avatarUrl: user.avatarUrl), at: index)
                    if amazingTen.count > 10 {
                        amazingTen.removeLast()
                    }
                    break
                }
            }
        }

    }


}
