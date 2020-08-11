//
//  UserGists+TableViewExt.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

extension UserGistsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.gists.count
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.fetchIfNeeded(item: indexPath.item)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: "GistListTableCell", for: indexPath) as? GistsListTableViewCell) else { return UITableViewCell() }

        cell.configure(model: presenter.gistsContent[indexPath.item])

        if let avatarUrl = presenter.gists[indexPath.item].owner?.avatarURL {
            presenter.loadOwnerImage(string: avatarUrl, for: indexPath)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.routeToGistScene(item: indexPath.item)
    }
}
