//
//  GistViewController.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 08.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import UIKit

class GistViewController: UIViewController, GistViewDelegate {

    let presenter: GistPresenter = GistPresenter()

    var gistTableView: UITableView = {
        $0.register(GistsListTableViewCell.self, forCellReuseIdentifier: "OwnerInfoCell")
        $0.register(GistFileTableViewCell.self, forCellReuseIdentifier: "FileCell")
        $0.register(GistCommitTableViewCell.self, forCellReuseIdentifier: "CommitCell")
        $0.tableFooterView = UIView()
        $0.rowHeight = UITableView.automaticDimension
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UITableView())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDelegate = self
        gistTableView.delegate = self
        gistTableView.dataSource = self
        setupViews()
        setupConstraints()
        presenter.loadGist()
        presenter.loadCommits()
    }

    func setupViews() {
        view.addSubview(gistTableView)
    }

    func setupConstraints() {
        gistTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
