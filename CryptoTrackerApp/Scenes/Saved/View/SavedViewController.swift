//
//  SavedViewController.swift
//  CryptoMadTracker
//
//  Created by talgar osmonov on 28/7/21.
//  
//

import UIKit

final class SavedViewController: UIViewController {
    
    //MARK: - properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    var output: SavedViewOutput?
    private lazy var contentView = SavedViewLayout()
    
    private var viewModels = [CryptoViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.contentView.cryptoTableView.reloadData()
            }
        }
    }
    
    
    //MARK: - lyfecycle
    
    override func loadView() {
        super.loadView()
        delegates()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        fetchCryptosFromDB()
    }
    
    //MARK: - Requests
    
    private func fetchCryptosFromDB() {
        output?.fetchCryptosFromDB()
    }
    
    //MARK: - Helper Methods
    
    private func delegates() {
        contentView.cryptoTableView.delegate = self
        contentView.cryptoTableView.dataSource = self
    }
    
    //MARK: - Configure
    
    private func configureNavBar() {
        navigationItem.title = Localization.savedData
    }
    
}

//MARK: - HomeViewInput

extension SavedViewController: SavedViewInput {
    func fetchCryptoResult(data: [CryptoViewModel]) {
        viewModels = data
    }
}

//MARK: - UITableViewDataSource

extension SavedViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell = tableView.dequeueCell(cellType: CryptoCell<CryptoView>.self, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.containerView.setupData(viewModel: viewModel)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension SavedViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

