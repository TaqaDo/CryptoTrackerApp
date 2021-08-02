//
//  CryptoView.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 27/7/21.
//

import UIKit

class CryptoView: UIView {

    //MARK: - Views

    private lazy var priceStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemPrice, itemPercentage])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()

    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [itemName, priceStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        return stack
    }()

    private lazy var itemSymbol: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()

    private lazy var itemName: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()

    private lazy var itemPrice: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()

    private lazy var itemPercentage: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.sizeToFit()
        return label
    }()

    //MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    private func configure() {
        addSubviews()
        addViewConstraints()
    }

    private func addSubviews() {
        addSubview(labelStack)
        addSubview(itemSymbol)
    }

    private func addViewConstraints() {
        itemSymbol.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
        labelStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(viewModel: CryptoViewModel) {
        itemName.text = viewModel.name
        itemSymbol.text = viewModel.symbol
        itemPrice.text = "$" + String(Double(round(1000*viewModel.price)/1000))
        itemPercentage.text = "(" + String(Double(round(1000*viewModel.percentChange)/1000)) + "%)"
        itemPercentage.textColor = viewModel.percentChange < 0.0 ? .red : .green
        layoutIfNeeded()
    }

}
