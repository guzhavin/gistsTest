//
//  UserGistsViewController.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 10.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

class UserGistsViewController: UIViewController {

    var presenter: UserGistsPresenter = UserGistsPresenter()

    var userInfoStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 4
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UIStackView())

    var contentTableView: UITableView = {
        $0.register(GistsListTableViewCell.self, forCellReuseIdentifier: "GistListTableCell")
        $0.tableFooterView = UIView()
        $0.rowHeight = UITableView.automaticDimension
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UITableView())

    var avatarImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UIImageView())

    var locationLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.lineBreakMode = .byTruncatingTail
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0

    }(UILabel())

    var emailLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.lineBreakMode = .byTruncatingTail
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0

    }(UILabel())

    var bioLabel: UILabel = {
        $0.numberOfLines = 3
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.lineBreakMode = .byTruncatingTail
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0

    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(userInfoStackView)
        view.addSubview(contentTableView)

        userInfoStackView.addArrangedSubview(avatarImageView)
        userInfoStackView.addArrangedSubview(locationLabel)
        userInfoStackView.addArrangedSubview(emailLabel)
        userInfoStackView.addArrangedSubview(bioLabel)

        userInfoStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(4)
            $0.left.right.equalToSuperview().inset(16)
        }

        contentTableView.snp.makeConstraints {
            $0.top.equalTo(userInfoStackView.snp.bottom).offset(4)
            $0.left.right.bottom.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(80)
        }

        contentTableView.delegate = self
        contentTableView.dataSource = self

        presenter.viewDelegate = self

        presenter.loadGists()
        presenter.loadUserInfo()
    }
}
