//
//  SavedLayoutView.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//

import UIKit
import SnapKit

class SavedViewLayout: UIView {

    //MARK: - Views

    lazy var cryptoTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(CryptoCell<CryptoView>.self)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        backgroundColor = .white
        addSubviews()
        addViewConstraints()
    }

    private func addSubviews() {
        addSubview(cryptoTableView)
        addSubview(indicator)
    }

    private func addViewConstraints() {
        cryptoTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadingIndicator(type: Bool) {
        if type == true {
            indicator.startAnimating()
            cryptoTableView.isHidden = true
        } else {
            indicator.stopAnimating()
            cryptoTableView.isHidden = false
        }
    }
}

