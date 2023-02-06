//
//  CocktailsListCell.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit

final class CocktailsListCell: UITableViewCell {
    static let identifier = "CocktailsListCell"
    
    //MARK: - Subviews
    
    private let cocktailImageView = UIImageView()
    private let cocktailTitleLabel = UILabel()
    private let cocktailDetailLabel = UILabel()
    private let cocktailTagsLabel = UILabel()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        return stackView
    }()

    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupSubviews()
        accessoryType = .disclosureIndicator
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    //MARK: - Setup subviews
    
    func configure(with model: CocktailListViewModel) {
        if let imageURL = model.imageUrl {
            ImagesDownloaderService.shared.fetchImage(from: imageURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.cocktailImageView.image = image
                }
            }
        }
        cocktailTitleLabel.text = model.title
        cocktailDetailLabel.text = model.description
        cocktailTagsLabel.text = model.tags
    }

    private func setupSubviews() {
        cocktailDetailLabel.numberOfLines = 3
        cocktailTitleLabel.textColor = .black
        cocktailDetailLabel.textColor = .gray
        cocktailTitleLabel.font = .systemFont(ofSize: 19, weight: .semibold)
        cocktailTagsLabel.textColor = .lightGray
        cocktailImageView.layer.cornerRadius = 12
        cocktailImageView.layer.masksToBounds = true
    }

    private func addSubviews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cocktailImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)
        contentView.addSubview(cocktailImageView)
        stackView.addArrangedSubview(cocktailTitleLabel)
        stackView.addArrangedSubview(cocktailDetailLabel)
        stackView.addArrangedSubview(cocktailTagsLabel)

        NSLayoutConstraint.activate([
            cocktailImageView.heightAnchor.constraint(equalToConstant: 100),
            cocktailImageView.widthAnchor.constraint(equalToConstant: 100),
            cocktailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            cocktailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cocktailImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: cocktailImageView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15),
        ])
    }
}
