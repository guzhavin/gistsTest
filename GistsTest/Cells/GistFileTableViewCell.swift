//
//  GistFileTableViewCell.swift
//  GistsTest
//
//  Created by Aleksandr Guzhavin on 09.08.2020.
//  Copyright © 2020 Guzh. All rights reserved.
//

import Foundation
import UIKit

class GistFileTableViewCell: UITableViewCell {
    private var fileNameLabel: UILabel = {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false

        return $0
    }(UILabel())

    private var fileTextView: UITextView = {
        $0.isScrollEnabled = false
        $0.isEditable = false

        return $0
    }(UITextView())

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
        contentView.addSubview(fileNameLabel)
        contentView.addSubview(fileTextView)
    }

    func setupConstraints() {
        fileNameLabel.snp.remakeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        fileTextView.snp.remakeConstraints {
            $0.top.equalTo(fileNameLabel.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-8)
            $0.height.equalTo(0)
        }
    }

    func updateFilteTextViewHeight() {
        let sizeToFitIn = CGSize(width: UIScreen.main.bounds.width - 32, height: CGFloat(MAXFLOAT))
        let newSize = fileTextView.sizeThatFits(sizeToFitIn)

        fileTextView.snp.updateConstraints {
            $0.height.equalTo(newSize.height)
        }
    }

    func configure(fileName: String?, content: String?) {
        fileNameLabel.text = fileName
        fileTextView.text = content
        updateFilteTextViewHeight()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        fileNameLabel.text = nil
        fileTextView.text = nil
        updateFilteTextViewHeight()
    }
}
