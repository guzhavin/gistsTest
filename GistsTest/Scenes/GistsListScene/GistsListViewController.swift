//
//  GistsListViewController.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 06.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import UIKit

class GistsListViewController: UIViewController {

    var presenter: GistsListPresenter = GistsListPresenter()

    var usersTopCollectionView: UICollectionView = {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        flowLayout.itemSize = .init(width: 80, height: 70)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0

        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(UserInTopCollectionViewCell.self, forCellWithReuseIdentifier: "UserCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    var contentTableView: UITableView = {
        $0.register(GistsListTableViewCell.self, forCellReuseIdentifier: "TableCell")
        $0.tableFooterView = UIView()
        $0.rowHeight = UITableView.automaticDimension
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UITableView())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        contentTableView.delegate = self
        contentTableView.dataSource = self

        usersTopCollectionView.dataSource = self
        usersTopCollectionView.delegate = self

        setupViews()
        setupConstraints()

        presenter.viewDelegate = self
        presenter.loadGists()
    }

    func setupViews() {
        view.addSubview(usersTopCollectionView)
        view.addSubview(contentTableView)
    }

    func setupConstraints() {
        usersTopCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(70)
        }
        contentTableView.snp.makeConstraints {
            $0.top.equalTo(usersTopCollectionView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
