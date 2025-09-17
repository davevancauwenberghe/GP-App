//
//  SettingsViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//
//  Staying alive on the Git connection - 30/11/2024 and received on 30/11
//

import UIKit

class SettingsViewController: UITableViewController {

    let sections = ["General", "Appearance", "About GP App", "Contact", "Policies"]
    let generalOptions = ["Push notifications"]
    let appearanceOptions = ["App icon", "Dark mode"]
    let aboutOptions = ["Our story", "Release notes", "Thank you", "TestFlight"]
    let policiesOptions = ["Privacy policy", "Copyright", "Photo quality"]

    private var hasPerformedExplosionAnimation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        tableView.tableFooterView = UIView()
    }

    private func setupHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 160))

        // Add the AppIconImageView
        let appIconImageView = UIImageView(image: UIImage(named: "AppIcon"))
        appIconImageView.translatesAutoresizingMaskIntoConstraints = false
        appIconImageView.contentMode = .scaleAspectFill
        appIconImageView.layer.cornerRadius = 24
        appIconImageView.clipsToBounds = true
        headerView.addSubview(appIconImageView)

        let versionLabel = UILabel()
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.text = "© Dave Van Cauwenberghe - v1.7"
        versionLabel.textAlignment = .center
        versionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        versionLabel.textColor = .darkGray
        headerView.addSubview(versionLabel)

        NSLayoutConstraint.activate([
            // AppIconImageView constraints
            appIconImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            appIconImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            appIconImageView.widthAnchor.constraint(equalToConstant: 100),
            appIconImageView.heightAnchor.constraint(equalTo: appIconImageView.widthAnchor),

            // Version label constraints
            versionLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            versionLabel.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 8),
        ])

        tableView.tableHeaderView = headerView

        // Add tap gesture recognizer to the AppIconImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(appIconImageViewTapped))
        appIconImageView.addGestureRecognizer(tapGesture)
        appIconImageView.isUserInteractionEnabled = true
    }

    // MARK: - Tap Gesture Recognizer Action

    @objc private func appIconImageViewTapped() {
        // Perform your animation or action here for the Easter egg
        // For example, you can use UIView animations to scale or rotate the image
        UIView.animate(withDuration: 0.5, animations: {
            // Add a rotation animation
            self.tableView.tableHeaderView?.subviews.first?.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                // Remove the rotation animation
                self.tableView.tableHeaderView?.subviews.first?.transform = .identity
            }
        }

        // Add a floating animation
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            // Move the image view slightly up and down
            self.tableView.tableHeaderView?.subviews.first?.transform = CGAffineTransform(translationX: 0, y: -10)
        }, completion: nil)

        // After 5 seconds, trigger the explosion animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.performExplosionAnimation()
        }
    }

    private func performExplosionAnimation() {
        guard let appIconImageView = tableView.tableHeaderView?.subviews.first as? UIImageView else {
            return
        }

        // Create a feedback generator for impact style
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.prepare()

        // Trigger the vibration
        feedbackGenerator.impactOccurred()

        // Disable the floating animation during the explosion
        appIconImageView.layer.removeAllAnimations()

        if !hasPerformedExplosionAnimation {
            hasPerformedExplosionAnimation = true

            // Fade out the other sections during the explosion
            for section in 0..<tableView.numberOfSections {
                if section != 1 { // Skip the "Appearance" section (optional)
                    for row in 0..<tableView.numberOfRows(inSection: section) {
                        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                            UIView.animate(withDuration: 0.5) {
                                cell.alpha = 0.0
                            }
                        }
                    }
                }
            }

            // Animate the explosion effect
            UIView.animate(withDuration: 0.15, animations: {
                appIconImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }) { _ in
                UIView.animate(withDuration: 0.15, animations: {
                    appIconImageView.transform = CGAffineTransform(scaleX: 3, y: 3)
                    appIconImageView.alpha = 0.0
                }) { _ in
                    // After the explosion, reset the image view to its normal state
                    UIView.animate(withDuration: 0.15, animations: {
                        appIconImageView.transform = .identity
                        appIconImageView.alpha = 1.0
                    }) { _ in
                        // Fade in the other sections after the explosion
                        for section in 0..<self.tableView.numberOfSections {
                            if section != 1 { // Skip the "Appearance" section (optional)
                                for row in 0..<self.tableView.numberOfRows(inSection: section) {
                                    if let cell = self.tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                                        UIView.animate(withDuration: 0.5) {
                                            cell.alpha = 1.0
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return generalOptions.count
        case 1:
            return appearanceOptions.count
        case 2:
            return aboutOptions.count
        case 3:
            return 1 // There's only one row in the "Contact" section
        case 4:
            return policiesOptions.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsViewCell

        switch indexPath.section {
        case 0:
            cell.iconImageView.image = UIImage(systemName: "bell.badge.fill")
            cell.titleLabel.text = generalOptions[indexPath.row]
        case 1:
            if indexPath.row == 1 {
                // Change the symbol for "Dark Mode" to a moon.fill
                cell.iconImageView.image = UIImage(systemName: "moon.fill")
                cell.titleLabel.text = "Dark mode"
            } else if indexPath.row == 0 {
                // Use an app icon symbol instead of gear for "App Icon"
                cell.iconImageView.image = UIImage(systemName: "app.badge")
                cell.titleLabel.text = "App icon"
            }
        case 2:
            switch indexPath.row {
            case 0: // Add this case for "Our Story"
                cell.iconImageView.image = UIImage(systemName: "book.fill")
                cell.titleLabel.text = aboutOptions[indexPath.row]
            case 1:
                cell.iconImageView.image = UIImage(systemName: "doc.text.fill")
                cell.titleLabel.text = aboutOptions[indexPath.row]
            case 2:
                cell.iconImageView.image = UIImage(systemName: "heart.fill")
                cell.titleLabel.text = aboutOptions[indexPath.row]
            case 3:
                cell.iconImageView.image = UIImage(systemName: "person.crop.circle.badge.plus")
                cell.titleLabel.text = aboutOptions[indexPath.row]
            default:
                break
            }
        case 3:
            cell.iconImageView.image = UIImage(systemName: "antenna.radiowaves.left.and.right")
            cell.titleLabel.text = "Let's connect"
        case 4:
            switch indexPath.row {
            case 0:
                cell.iconImageView.image = UIImage(systemName: "hand.raised.circle.fill")
                cell.titleLabel.text = policiesOptions[indexPath.row]
            case 1:
                cell.iconImageView.image = UIImage(systemName: "doc.richtext.fill")
                cell.titleLabel.text = policiesOptions[indexPath.row]
            case 2:
                cell.iconImageView.image = UIImage(systemName: "photo.fill")
                cell.titleLabel.text = policiesOptions[indexPath.row]
            default:
                break
            }
        default:
            break
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 1 && indexPath.row == 1 { // "Dark mode" button tapped
            let darkModeVC = DarkModeViewController()
            navigationController?.pushViewController(darkModeVC, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 1 { // "Release notes" button tapped
            let releaseNotesVC = ReleaseNotesViewController()
            navigationController?.pushViewController(releaseNotesVC, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 3 { // "TestFlight" button tapped
            if let url = URL(string: "https://testflight.apple.com/join/EyTo5acT") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if indexPath.section == 3 && indexPath.row == 0 { // "Let's connect" button tapped
            let contactVC = ContactViewController() // Replace with the actual view controller
            navigationController?.pushViewController(contactVC, animated: true)
        } else if indexPath.section == 4 && indexPath.row == 0 { // "Privacy Policy" button tapped
            let privacyPolicyVC = PrivacyPolicyViewController()
            navigationController?.pushViewController(privacyPolicyVC, animated: true)
        } else if indexPath.section == 4 && indexPath.row == 1 { // "Copyright" button tapped
            let copyrightVC = CopyrightViewController()
            navigationController?.pushViewController(copyrightVC, animated: true)
        } else if indexPath.section == 4 && indexPath.row == 2 { // "Photo Quality" button tapped
            let photoQualityVC = PhotoQualityViewController()
            navigationController?.pushViewController(photoQualityVC, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 2 { // "Thank You" button tapped
            let thankYouVC = ThankYouViewController()
            navigationController?.pushViewController(thankYouVC, animated: true)
        } else if indexPath.section == 0 && indexPath.row == 0 { // "Push Notifications" button tapped
            openAppNotificationSettings()
        } else if indexPath.section == 1 && indexPath.row == 0 { // "App Icon" button tapped
            // Handle the App Icon button action by navigating to AppIconViewController
            let appIconVC = IconChangeViewController()
            navigationController?.pushViewController(appIconVC, animated: true)
        } else if indexPath.section == 2 && indexPath.row == 0 { // "Our Story" button tapped
            let ourStoryVC = OurStoryViewController()
            navigationController?.pushViewController(ourStoryVC, animated: true)
        }
        
        // Add haptic feedback for the button press
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }

    private func openAppNotificationSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
}
