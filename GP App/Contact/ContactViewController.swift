//
//  ContactViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 10/08/2023.
//

import UIKit

class ContactViewController: UITableViewController {

    let sections = ["Our socials", "Discord", "GitHub", "E-mail"]
    let socialOptions = ["Facebook", "Messenger", "Instagram"]
    let discordOptions = ["Ghent Photography"]
    let githubOptions = ["GP App"]
    let emailOptions = ["hello@ghentphotography.be"]

    private var hasPerformedExplosionAnimation = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Let's Connect"
        
        tableView.tableFooterView = UIView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return socialOptions.count
        case 1:
            return discordOptions.count
        case 2:
            return githubOptions.count
        case 3:
            return emailOptions.count
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
        let cell = ContactViewCell(style: .default, reuseIdentifier: "ContactViewCell")
        
        switch indexPath.section {
        case 0:
            let socialOption = socialOptions[indexPath.row]
            if let iconImage = iconForSocialOption(socialOption) {
                cell.configure(iconImage: iconImage, title: socialOption)
            }
        case 1:
            if let image = UIImage(systemName: "gamecontroller.fill") {
                cell.configure(iconImage: image, title: discordOptions[indexPath.row])
            }
        case 2:
            if let image = UIImage(systemName: "arrow.right.square.fill") {
                cell.configure(iconImage: image, title: githubOptions[indexPath.row])
            }
        case 3:
            if let image = UIImage(systemName: "envelope.fill") {
                cell.configure(iconImage: image, title: emailOptions[indexPath.row])
            }
        default:
            break
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.section {
        case 0:
            let socialOption = socialOptions[indexPath.row]
            openURLForSocialOption(socialOption)
        case 1:
            if let url = URL(string: "https://discord.gg/jaYeKGvUr8") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 2:
            if let url = URL(string: "https://github.com/appledavevc/GP-App") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 3:
            if let url = URL(string: "mailto:hello@ghentphotography.be") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            break
        }
    }

    // Function to return the appropriate icon image for a social option
    private func iconForSocialOption(_ option: String) -> UIImage? {
        switch option {
        case "Facebook":
            return UIImage(systemName: "person.2.fill") // You can replace this with a custom image
        case "Messenger":
            return UIImage(systemName: "bolt.horizontal.circle.fill")
        case "Instagram":
            return UIImage(systemName: "camera.fill")
        default:
            return nil
        }
    }
    
    // Function to open URLs for social options
    private func openURLForSocialOption(_ option: String) {
        var url: URL?
        switch option {
        case "Facebook":
            url = URL(string: "https://www.facebook.com/ghentphotographygp/")
        case "Messenger":
            url = URL(string: "http://m.me/ghentphotographygp")
        case "Instagram":
            url = URL(string: "https://www.instagram.com/ghent_photography/")
        default:
            break
        }

        if let url = url {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
