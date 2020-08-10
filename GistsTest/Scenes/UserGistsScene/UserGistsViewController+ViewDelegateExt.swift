//
//  UserGistsViewController+ViewDelegateExt.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

extension UserGistsViewController: UserGistsViewDelegate {
    func setUserContent(location: String, email: String, bio: String) {
        locationLabel.text = location
        emailLabel.text = email
        bioLabel.text = bio
        view.layoutIfNeeded()
    }

    func setUserAvatar(image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.avatarImageView.image = image
        }
    }

    func setImageForCell(at indexPath: IndexPath, image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            guard let cell = self?.contentTableView.cellForRow(at: indexPath) as? GistsListTableViewCell else { return }
            cell.setAvatar(image: image)
        }
    }

}
