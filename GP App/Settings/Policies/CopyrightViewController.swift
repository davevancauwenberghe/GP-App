//
//  CopyrightViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//

import UIKit

class CopyrightViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        title = "Copyright"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34), // Adjust the font size as needed
            .foregroundColor: UIColor.label // Use .label for automatic Dark Mode support
        ]
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let copyrightLabel = UILabel()
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.text = """
        All photos appearing on this app, unless noted otherwise, are the exclusive property of Ghent Photography and are protected under Belgian and International Copyright laws.

        Duplication, processing, distribution, manipulation, or any form of commercialization of such material shall require the prior written consent of Ghent Photography. These copyright laws impose substantial penalties for infringement, and violators will be prosecuted to the full extent of the law.
        All images are copyrighted © Ghent Photography.

        You may share and distribute the photos of Ghent Photography, provided that the Ghent Photography logo is still displayed on the photos. This logo should not be removed, altered, or obscured in any way. By sharing the photos, you agree to maintain the logo's visibility as an acknowledgment of Ghent Photography's ownership.

        For information about reproduction rights, for any of the images contained on this site, please contact us through hello@ghentphotography.be.

        Use of this app constitutes acceptance with the above copyright notice and all terms and conditions presented here.


        """
        copyrightLabel.numberOfLines = 0
        contentView.addSubview(copyrightLabel)

        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // ContentView constraints
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Copyright label constraints
            copyrightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            copyrightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            copyrightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            copyrightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }

}
