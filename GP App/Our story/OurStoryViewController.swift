//
//  GhentPhotographyViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 06/08/2023.
//

import UIKit

class OurStoryViewController: UIViewController {

    // MARK: - UI Elements

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let appIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.accessibilityLabel = "App Icon"  // Added accessibility label
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Ghent Photography"
        label.font = UIFont.boldSystemFont(ofSize: 38) // Updated font size
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .gpOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityLabel = "Main title: Welcome to Ghent Photography" // Added accessibility label
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Ghent Photography, founded in May 2021. Our mission is to capture the essence of the daily life in Ghent through our lenses, offering unique perspectives that often go unnoticed by the average passer-by.\n\nGhent is a city brimming with hidden gems, and our goal is to uncover and showcase these extraordinary moments. We believe that even the seemingly ordinary scenes can hold extraordinary beauty and meaning when seen through the lens of a camera.\n\nOur dedicated team is passionate about showcasing Ghent’s charm and diversity. With an emphasis on capturing the city’s vibrant energy, we aim to transport viewers to the very heart of Ghent’s bustling streets and tranquil corners.\n\nGhent is a city that embraces exploration on foot. Its compact size allows for seamless navigation from one captivating spot to another, with no need for public transport. As avid walkers ourselves, we invite you to experience the joy of meandering through Ghent’s picturesque streets alongside us.\n\nThrough our photos, we hope to inspire both locals and visitors alike to appreciate the often overlooked beauty of Ghent’s daily life. Join us on this visual journey as we uncover the city’s secrets, one frame at a time.\n\nAt Ghent Photography, we believe that every image has a story to tell, and we are dedicated to sharing Ghent’s narrative through our lens. Explore our gallery and let our photographs transport you into the heart and soul of this remarkable city.\n\nWe look forward to capturing the essence of Ghent and sharing its beauty with you."
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "DescriptionTextColor")
        label.backgroundColor = UIColor.black.withAlphaComponent(0.1) // Add the tint here
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityLabel = "Description about Ghent Photography" // Added accessibility label
        return label
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "AppBackground3")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = "Our story"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34),
            .foregroundColor: UIColor.label
        ]
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(appIconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),

            appIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            appIconImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            appIconImageView.widthAnchor.constraint(equalToConstant: 100),
            appIconImageView.heightAnchor.constraint(equalTo: appIconImageView.widthAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30) // Adjust this constant as needed
        ])

        // Set the content mode of the background image to "scaleToFill"
        let backgroundImage = UIImage(named: "AppBackground3")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleToFill
        view.insertSubview(backgroundImageView, at: 0)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Add a subtle black shadow to the text
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        titleLabel.layer.shadowOpacity = 0.3
        titleLabel.layer.shadowRadius = 2.0

        descriptionLabel.layer.shadowColor = UIColor.black.cgColor
        descriptionLabel.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        descriptionLabel.layer.shadowOpacity = 0.3
        descriptionLabel.layer.shadowRadius = 2.0
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
