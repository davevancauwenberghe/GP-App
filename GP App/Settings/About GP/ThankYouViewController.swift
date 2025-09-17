//
//  ThankYouViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        title = "Thank you"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34),
            .foregroundColor: UIColor.label
        ]
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        let backgroundImageView = UIImageView(image: UIImage(named: "AppBackground"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        view.sendSubviewToBack(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        let imageView = UIImageView(image: UIImage(named: "GPAppIconTW"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        let thankYouLabel = UILabel()
        thankYouLabel.text = "Thank you for downloading our app"
        thankYouLabel.font = UIFont.boldSystemFont(ofSize: 36)
        thankYouLabel.textColor = UIColor(named: "GPOrange")
        thankYouLabel.textAlignment = .center
        thankYouLabel.numberOfLines = 0
        thankYouLabel.adjustsFontForContentSizeCategory = true
        thankYouLabel.isAccessibilityElement = true
        thankYouLabel.accessibilityLabel = "Thank you for downloading our app"
        stackView.addArrangedSubview(thankYouLabel)
        
        let reviewLabel = UILabel()
        reviewLabel.text = "Please give us a positive review on the App Store"
        reviewLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        reviewLabel.textColor = .label
        reviewLabel.textAlignment = .center
        reviewLabel.adjustsFontForContentSizeCategory = true
        reviewLabel.isAccessibilityElement = true
        reviewLabel.accessibilityLabel = "Please give us a positive review on the App Store"
        stackView.addArrangedSubview(reviewLabel)
        
        let reviewButton = UIButton(type: .system)
        reviewButton.setTitle("Leave a Review", for: .normal)
        reviewButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        reviewButton.addTarget(self, action: #selector(openReviewPage), for: .touchUpInside)
        reviewButton.backgroundColor = UIColor.systemBlue
        reviewButton.setTitleColor(.white, for: .normal)
        reviewButton.layer.cornerRadius = 12
        reviewButton.isAccessibilityElement = true
        reviewButton.accessibilityLabel = "Leave a Review"
        stackView.addArrangedSubview(reviewButton)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    private func playHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    @objc private func openReviewPage() {
        playHapticFeedback()
        
        let appStoreReviewURLString = "https://apps.apple.com/us/app/gp-ghent-photography/id6451088808"
        
        guard let reviewURL = URL(string: appStoreReviewURLString) else {
            // Log an error message or alert the user if the URL is invalid.
            return
        }
        
        UIApplication.shared.open(reviewURL, options: [:], completionHandler: nil)
    }
}
