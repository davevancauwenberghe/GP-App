//
//  PhotoQualityViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//

import UIKit

class PhotoQualityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        title = "Photo Quality"
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

        let photoQualityLabel = UILabel()
        photoQualityLabel.translatesAutoresizingMaskIntoConstraints = false
        photoQualityLabel.text = """
        In order to optimise loading times, and database size: Photos rendered in-app are converted from .PNG to .JPG and are compressed by approximately 20% which could slight impact photo quality.**

        All photos are downsized from 4032 x 3024 (12MP) to 2560 x 1920 (5 MP) resolution as well. Please get in touch for full resolution.

        Thank you for using the GP app. We hope you enjoy capturing and sharing moments with our app!
        """
        photoQualityLabel.numberOfLines = 0
        contentView.addSubview(photoQualityLabel)

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

            // Photo quality label constraints
            photoQualityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            photoQualityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            photoQualityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            photoQualityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])

        // Apply bold and larger font size to specific titles
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Adjust the line spacing as needed

        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17), // Adjust the font size as needed
            .foregroundColor: UIColor.label, // Use .label for automatic Dark Mode support
            .paragraphStyle: paragraphStyle
        ]

        let largerBoldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20), // Adjust the font size as needed
            .foregroundColor: UIColor.label, // Use .label for automatic Dark Mode support
            .paragraphStyle: paragraphStyle
        ]

        let formattedText = NSMutableAttributedString(string: photoQualityLabel.text ?? "", attributes: nil)
        let photoQualityLines = photoQualityLabel.text?.components(separatedBy: "\n") ?? []

        for line in photoQualityLines {
            if line.hasPrefix("1. High Quality") {
                // Apply larger and bold attributes to the title
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(largerBoldAttributes, range: range)
            } else if line.hasPrefix("1.") || line.hasPrefix("2.") || line.hasPrefix("3.") {
                // Apply bold attributes to section titles
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(boldAttributes, range: range)
            }
        }

        // Apply the formatted text to the UITextView
        photoQualityLabel.attributedText = formattedText
    }
}
