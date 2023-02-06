//
//  CocktailsDetailViewController.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit

final class CocktailsDetailViewController: UIViewController {
    // MARK: - Subviews

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionTextView = UITextView()

    // MARK: - Properties

    private let viewModel: CocktailsDetailViewModel

    // MARK: - init

    init(viewModel: CocktailsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupSubviews()
        fillTexts()
    }

    // MARK: - Setup UI

    private func addSubviews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionTextView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 3),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }

    private func setupSubviews() {
        view.backgroundColor = .white
        titleLabel.font = .systemFont(ofSize: 21, weight: .semibold)
        titleLabel.textColor = .black
        descriptionTextView.textColor = .gray
        descriptionTextView.isEditable = false
        descriptionTextView.textContainerInset = .zero
        descriptionTextView.font = .systemFont(ofSize: 17)
        descriptionTextView.textContainer.lineFragmentPadding = 0

        if let imageURL = viewModel.imageURL {
            ImagesDownloaderService.shared.fetchImage(from: imageURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }

    private func fillTexts() {
        titleLabel.text = viewModel.title
        descriptionTextView.text = viewModel.description
    }
}
