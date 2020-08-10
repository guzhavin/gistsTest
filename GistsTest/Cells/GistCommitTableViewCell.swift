//
//  GistCommitTableViewCell.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 09.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

class GistCommitTableViewCell: UITableViewCell {
    private var userAvatarImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UIImageView())

    private var userNameLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UILabel())

    private var gistDataLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UILabel())

    private var addCountLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textColor = .green
        $0.font = UIFont.boldSystemFont(ofSize: 16)

        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private var delCountLabel: UILabel = {
        $0.numberOfLines = 1
        $0.textColor = .red
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UILabel())


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.addSubview(userAvatarImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(gistDataLabel)
        contentView.addSubview(addCountLabel)
        contentView.addSubview(delCountLabel)
    }

    func setupConstraints() {
        userAvatarImageView.snp.remakeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(8)
            $0.size.equalTo(20)
        }
        userNameLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalTo(userAvatarImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
        gistDataLabel.snp.remakeConstraints {
            $0.top.equalTo(userAvatarImageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
        }
        addCountLabel.snp.remakeConstraints {
            $0.top.equalTo(gistDataLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
        }
        delCountLabel.snp.remakeConstraints {
            $0.top.equalTo(addCountLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }

    func configure(userName: String?, gistDate: String?, addCount: String, delCount: String) {
        userNameLabel.text = userName
        gistDataLabel.text = gistDate
        addCountLabel.text = addCount
        delCountLabel.text = delCount
    }

    func setAvatar(image: UIImage?) {
        userAvatarImageView.image = image
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        userAvatarImageView.image = nil
        userNameLabel.text = nil
        gistDataLabel.text = nil
        addCountLabel.text = nil
        delCountLabel.text = nil
    }
}

