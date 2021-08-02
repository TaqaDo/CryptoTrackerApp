//
//  HomeViewLayout.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import UIKit
import SnapKit

class HomeViewLayout: UIView {

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
    
    lazy var dbButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "archivebox.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 80 / 2
        button.clipsToBounds = true
        return button
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
        addSubview(dbButton)
    }

    private func addViewConstraints() {
        dbButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(safeArea.bottom).inset(20)
            make.size.equalTo(80)
        }
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
            dbButton.isHidden = true
        } else {
            indicator.stopAnimating()
            cryptoTableView.isHidden = false
            dbButton.isHidden = false
        }
    }
}
