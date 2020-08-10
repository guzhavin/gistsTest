//
//  GistListViewController+ViewDelegateExt.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

extension GistsListViewController: GistsListViewDelegate {
    func setImageForCell(at indexPath: IndexPath, image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            (self?.contentTableView.cellForRow(at: indexPath) as? GistsListTableViewCell)?.setAvatar(image: image)
        }
    }
}
