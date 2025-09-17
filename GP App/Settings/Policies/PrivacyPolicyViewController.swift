//
//  PrivacyPolicyViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        title = "Privacy Policy"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34), // Adjust the font size as needed
            .foregroundColor: UIColor.label // Use .label for automatic Dark Mode support
        ]
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground // Set the view background color to system background color

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        let privacyPolicyLabel = UILabel()
        privacyPolicyLabel.translatesAutoresizingMaskIntoConstraints = false
        privacyPolicyLabel.text = """
        Thank you for using the Ghent Photography app and/or website. This Privacy policy explains how we collect, use, and protect your personal information when you interact with our app and website. By using our services, you agree to the collection and use of information as described in this policy.

        1. Information we collect

        1.1 Personal Information
        We do not collect or store any personally identifiable information (PII) about you unless you voluntarily provide it to us. We do not require any personal information for you to use the app or browse our website.

        1.2 Usage Information
        We may collect non-personal information about how you use our app and website. This includes information such as your device type, operating system, browser type, IP address, and the pages you visit. We collect this information to improve our services and provide a better user experience.

        1.3 Cookies and Analytics
        We use cookies on our website to gather anonymous usage data and perform analytical analysis using third-party services like Google Analytics. Cookies are small files that are stored on your device to enhance your browsing experience. These cookies do not contain personal information and are used for statistical purposes only.

        2. Use of Information

        2.1 Personal Information
        Any personal information you voluntarily provide, such as when contacting us through email or feedback forms, will be used solely for the purpose of responding to your inquiries or requests. We do not share your personal information with third parties unless required by law.

        2.2 Usage Information
        We use non-personal usage information to understand how users interact with our app and website, improve our services, and enhance the user experience. This data is aggregated and does not identify individual users.

        3. Data Security
        We implement reasonable security measures to protect the information we collect. However, please be aware that no data transmission over the internet or electronic storage is completely secure. We cannot guarantee the absolute security of your information.

        4. Third-party Links
        Our app and website may contain links to third-party websites or services. Please note that we are not responsible for the privacy practices of such third parties. We encourage you to read the privacy policies of these third-party websites before providing any personal information.

        5. Children’s privacy
        Our app and website are not intended for children under the age of 13. We do not knowingly collect personal information from children. If you are a parent or guardian and believe your child has provided us with personal information, please contact us, and we will promptly delete such information.

        6. Changes to this Privacy policy
        We reserve the right to update or modify this Privacy policy at any time. Any changes will be effective when the revised policy is posted. We encourage you to review this policy periodically to stay informed about how we collect, use, and protect your information.

        7. Contact us
        If you have any questions or concerns about this Privacy Policy, please contact us through hello@ghentphotography.be

        Thank you for your trust in Ghent Photography. We are committed to protecting your privacy and providing a secure and enjoyable experience when using our app and website.
        """
        privacyPolicyLabel.numberOfLines = 0
        privacyPolicyLabel.textColor = .label // Set the text color to system label color (works with Dark Mode)
        privacyPolicyLabel.backgroundColor = .systemBackground // Set the background color to system background color (works with Dark Mode)
        contentView.addSubview(privacyPolicyLabel)

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

            // Privacy policy label constraints
            privacyPolicyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            privacyPolicyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            privacyPolicyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            privacyPolicyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
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

        let formattedText = NSMutableAttributedString(string: privacyPolicyLabel.text ?? "", attributes: nil)
        let privacyPolicyLines = privacyPolicyLabel.text?.components(separatedBy: "\n") ?? []

        for line in privacyPolicyLines {
            if line.hasPrefix("1. Information we collect") {
                // Apply larger and bold attributes to the title
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(largerBoldAttributes, range: range)
            } else if line.hasPrefix("1.") {
                // Apply bold attributes to section titles
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(boldAttributes, range: range)
            } else if line.hasPrefix("2. Use of Information") {
                // Apply larger and bold attributes to the title
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(largerBoldAttributes, range: range)
            } else if line.hasPrefix("2.") {
                // Apply bold attributes to section titles
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(boldAttributes, range: range)
            } else if line.hasPrefix("3.") || line.hasPrefix("4.") || line.hasPrefix("5.") || line.hasPrefix("6.") || line.hasPrefix("7.") {
                // Apply bold attributes to section titles
                let range = (formattedText.string as NSString).range(of: line)
                formattedText.addAttributes(boldAttributes, range: range)
            }
        }

        // Apply the formatted text to the UITextView
        privacyPolicyLabel.attributedText = formattedText
    }
}
