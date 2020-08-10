//
//  GistListViewController+TableViewExt.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

extension GistsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.gists.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.gists.count - 20 {
            presenter.loadGists()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "GistListTableCell", for: indexPath) as? GistsListTableViewCell) else { return UITableViewCell() }

        cell.configure(userName: presenter.prepareDataString(presenter.gists[indexPath.item].owner?.login),
                       gistName:  presenter.prepareDataString(presenter.gists[indexPath.item].searchDescription))

        if let avatarUrl = presenter.gists[indexPath.item].owner?.avatarURL {
            presenter.loadAvatar(urlString: avatarUrl, for: indexPath)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // id for commits test: "03163e7295fad76b6e7781235647d158"
        let vc = GistViewController()
        vc.presenter.gistId = presenter.gists[indexPath.item].id
        vc.presenter.loadGist()

        navigationController?.show(vc, sender: nil)
    }
}
