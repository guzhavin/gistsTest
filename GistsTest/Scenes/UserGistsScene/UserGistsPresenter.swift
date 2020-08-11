//
//  GistsListByUserPresenter.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

protocol UserGistsViewDelegate: class {
    var contentTableView: UITableView { get set }
    func setUserContent(location: String, email: String, bio: String)
    func setUserAvatar(image: UIImage?)
    func setImageForCell(at: IndexPath, image: UIImage?)

}

class UserGistsPresenter {
    private var currentLoadedPage: Int = 0

    var gists: Gists = [] {
        didSet {
            gistsContent = gists.map { GistsListTableViewCellModel(userName: prepareDataString($0.owner?.login),
                                                                   gistName: prepareDataString($0.searchDescription)) }
            DispatchQueue.main.async {
                self.viewDelegate?.contentTableView.reloadData()
            }
        }
    }

    var user: User? {
        didSet {
            viewDelegate?.setUserContent(location: prepareDataString(user?.location),
                                         email: prepareDataString(user?.email),
                                         bio: prepareDataString(user?.bio))

            if let avatarUrl = user?.avatarURL {
                loadUserAvatar(string: avatarUrl)
            }
        }
    }

    var gistsContent: [GistsListTableViewCellModel] = []

    var userName: String?

    weak var viewDelegate: UserGistsViewDelegate?

    func loadGists() {
        guard let userName = userName else { return }
        currentLoadedPage += 1
        let urlString = "https://api.github.com/users/\(userName)/gists?per_page=50&page=\(currentLoadedPage)"

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        let content = self?.parseGists(json: data)
                        self?.gists.append(contentsOf: content!)
                    }
                }
            }
        }
    }

    func parseGists(json: Data) -> Gists {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return (try? decoder.decode(Gists.self, from: json)) ?? []
    }

    func loadUserInfo() {
        guard let userName = userName else { return }
        let urlString = "https://api.github.com/users/\(userName)"

        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        let content = self?.parseUser(json: data)
                        self?.user = content
                    }
                }
            }
        }
    }

    func parseUser(json: Data) -> User? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try? decoder.decode(User.self, from: json)
    }

    func loadUserAvatar(string: String) {
        AvatarManager.shared.getImage(urlString: string) { [weak self] image in
            DispatchQueue.main.async {
                self?.viewDelegate?.setUserAvatar(image: image)
            }
        }
    }

    func loadOwnerImage(string: String, for indexPath: IndexPath) {
        AvatarManager.shared.getImage(urlString: string) { [weak self] image in
            DispatchQueue.main.async {
                self?.viewDelegate?.setImageForCell(at: indexPath, image: image)
            }
        }
    }

    func prepareDataString(_ string: String?) -> String {
        if let string = string {
            return string.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 ? string : "Unknown"
        }
        return "Unknown"
    }

    func fetchIfNeeded(item: Int) {
        if item == gists.count - 20 {
            loadGists()
        }
    }

    func routeToGistScene(item: Int) {
        let vc = GistViewController()
        vc.presenter.gistId = gists[item].id
        vc.presenter.loadGist()

        (viewDelegate as? UIViewController)?.navigationController?.show(vc, sender: nil)
    }
}
