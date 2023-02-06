//
//  CocktailsListViewController.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit

final class CocktailsListViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: CocktailsListViewToPresenterProtocol?
    
    //MARK: - Subviews
    
    private let searchController = UISearchController()
    private let tableView = UITableView()
    private let loader = CenterLoader()
    private let emptyLabel = UILabel()

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        addSubviews()
        setupTable()
    }

    //MARK: - Setup subviews
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(loader)
        view.addSubview(emptyLabel)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        loader.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            loader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            emptyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }

    private func setupSubviews() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        view.backgroundColor = .white
        loader.isHidden = true
        emptyLabel.isHidden = false
        emptyLabel.text = "Empty cocktails list"
        emptyLabel.textAlignment = .center
        emptyLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CocktailsListCell.self, forCellReuseIdentifier: CocktailsListCell.identifier)
        tableView.separatorStyle = .none
    }
}
//MARK: - CocktailsListPresenterToViewProtocol

extension CocktailsListViewController: CocktailsListPresenterToViewProtocol {
    func startLoading() {
        DispatchQueue.main.async {
            self.loader.isHidden = false
        }
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.loader.isHidden = true
        }
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.emptyLabel.isHidden = self.presenter?.numberOfRows() != 0
        }
    }
}
//MARK: - UISearchResultsUpdating

extension CocktailsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter?.didEnterQuery(searchText)
    }
}

//MARK: -  UITableViewDelegate &  UITableViewDataSource


extension CocktailsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRows() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CocktailsListCell.identifier, for: indexPath) as? CocktailsListCell,
              let viewModel = presenter?.getCurrentCocktail(at: indexPath) else { return UITableViewCell()}
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectCocktail(at: indexPath)
    }
}
