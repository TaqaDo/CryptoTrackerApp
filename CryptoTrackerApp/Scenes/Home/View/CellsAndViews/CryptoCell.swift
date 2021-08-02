//
//  CryptoCell.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import UIKit
import SnapKit

class CryptoCell<T: UIView>: UITableViewCell {

    let containerView: T

    override init(style: CellStyle, reuseIdentifier: String?) {
        self.containerView = T(frame: .zero)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.contentView.addSubview(containerView)
        self.containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("unsuported VIew")
    }
}

