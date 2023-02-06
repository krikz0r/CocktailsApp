//
//  CenterLoader.swift
//  CocktailApp
//
//  Created by Anton on 06.02.2023.
//

import UIKit

final class CenterLoader: UIView {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .clear
        spinner.startAnimating()
    }

    func setupUI() {
        addSubview(containerView)
        containerView.addSubview(spinner)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 50),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])

        spinner.color = .white
        containerView.backgroundColor = .gray
        containerView.layer.cornerRadius = 10
    }
}
