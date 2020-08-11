//
//  UserInTopCollectinViewCell.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 07.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

struct UserInTopCollectionViewCellModel {
    var name: String
}

class UserInTopCollectionViewCell: UICollectionViewCell {
    private var userAvatarImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 20
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UIImageView())

    private var userNameLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.addSubview(userAvatarImageView)
        contentView.addSubview(userNameLabel)
    }

    func setupConstraints() {
        userAvatarImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userAvatarImageView.snp.bottom).offset(4)
            $0.width.equalTo(60)
            $0.height.equalTo(18)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.bottom).inset(4)
        }
    }

    func configure(model: UserInTopCollectionViewCellModel) {
        userNameLabel.text = model.name
    }

    func setAvatar(image: UIImage?) {
        userAvatarImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        userNameLabel.text = nil
        userAvatarImageView.image = nil
    }
}
