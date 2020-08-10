//
//  GistListViewController+CollectionViewExt.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

extension GistsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let userCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath as IndexPath) as? UserInTopCollectionViewCell) else { return UICollectionViewCell() }
        userCell.configure(name: presenter.amazingTen[indexPath.item].name)
        if let avatarUrl = presenter.amazingTen[indexPath.item].avatarUrl {
            AvatarManager.shared.getImage(urlString: avatarUrl, completion: { image in
                userCell.setAvatar(image: image)
            })
        }
        return userCell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.amazingTen.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UserGistsViewController()
        vc.presenter.userName = presenter.amazingTen[indexPath.item].name
        navigationController?.show(vc, sender: nil)
    }
}
