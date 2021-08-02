//
//  HomeViewController.swift
//  CoinMarketApp
//
//  Created by talgar osmonov on 27/7/21.
//
//

import UIKit

final class HomeViewController: UIViewController {

    //MARK: - properties

    private let searchController = UISearchController(searchResultsController: nil)
    var output: HomeViewOutput?
    private lazy var contentView = HomeViewLayout()

    private var viewModels = [CryptoViewModel]() {
        didSet {
            contentView.cryptoTableView.reloadData()
        }
    }
    private var searchViewModels = [CryptoViewModel]() {
        didSet {
            contentView.cryptoTableView.reloadData()
        }
    }
    

    //MARK: - lyfecycle

    override func loadView() {
        super.loadView()
        delegates()
        buttonTargets()
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureSearchController()
        fetchCryptos()
    }
    
    //MARK: - Requests
    
    private func fetchCryptos() {
        contentView.loadingIndicator(type: true)
        output?.fetchCryptos()
    }
    
    private func searchForCryptos(text: String) {
        contentView.loadingIndicator(type: true)
        output?.searchForCryptos(text: text)
    }
    
    //MARK: - UI Actions
    
    @objc func dbButtonTap() {
        output?.navigateToSaved()
    }

    //MARK: - Helper Methods

    private func delegates() {
        contentView.cryptoTableView.delegate = self
        contentView.cryptoTableView.dataSource = self
    }
    
    private func buttonTargets() {
        contentView.dbButton.addTarget(self, action: #selector(dbButtonTap), for: .touchUpInside)
    }

    //MARK: - Configure

    private func configureNavBar() {
        navigationItem.title = Localization.appName
    }

    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation =  false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for crypto"
        searchController.searchBar.endEditing(true)
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

//MARK: - HomeViewInput

extension HomeViewController: HomeViewInput {
    func noConnection() {
        contentView.loadingIndicator(type: false)
        output?.showNoConnectionAllert()
    }
    
    func saveToDBError() {
        contentView.loadingIndicator(type: false)
        output?.showSaveDBErrorAllert()
    }
    
    func searchForNotFound() {
        contentView.loadingIndicator(type: false)
    }
    
    func searchForCryptoResult(data: CryptoViewModel) {
        searchViewModels.removeAll()
        contentView.loadingIndicator(type: false)
        self.searchViewModels.append(data)
    }
    
    func fetchCryptoResult(data: [CryptoViewModel]) {
        contentView.loadingIndicator(type: false)
        self.viewModels = data
    }
}

//MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? searchViewModels.count : viewModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = searchController.isActive ? searchViewModels[indexPath.row] : viewModels[indexPath.row]
        let cell = tableView.dequeueCell(cellType: CryptoCell<CryptoView>.self, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.containerView.setupData(viewModel: viewModel)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UISearchResultsUpdating

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text else {return}
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if searchText != "" {
            searchForCryptos(text: text.lowercased())
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        contentView.cryptoTableView.reloadData()
    }
}
