//
//  GistViewController+TableViewExt.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

extension GistViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return presenter.filesInfo.count
        case 2:
            return presenter.commitsInfo.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Info"
        case 1:
            return "Files"
        case 2:
            return "Commits"
        default:
            return "Other"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerInfoCell", for: indexPath) as? GistsListTableViewCell {
                cell.configure(userName: presenter.headerInfo.ownerName, gistName: presenter.headerInfo.gistName)
                cell.setAvatar(image: presenter.headerInfo.avatar)

                return cell
            } else { return UITableViewCell() }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath) as? GistFileTableViewCell {
                cell.configure(fileName: presenter.filesInfo[indexPath.item].fileName,
                               content: presenter.filesInfo[indexPath.item].body)

                return cell
            } else { return UITableViewCell() }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CommitCell", for: indexPath) as? GistCommitTableViewCell {
                cell.configure(userName: presenter.commitsInfo[indexPath.item].userName,
                               gistDate:  presenter.commitsInfo[indexPath.item].date,
                               addCount:  presenter.commitsInfo[indexPath.item].addCount,
                               delCount:  presenter.commitsInfo[indexPath.item].delCount)

                if let urlString = presenter.commitsInfo[indexPath.item].avatar {
                    AvatarManager.shared.getImage(urlString: urlString) { image in
                        cell.setAvatar(image: image)
                    }
                }

                return cell
            } else { return UITableViewCell() }
        default:
            return UITableViewCell()
        }
    }
}
