//
//  ReleaseNotesViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//

import UIKit

class ReleaseNotesViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let releaseNotesTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false // Disable scrolling on the text view itself
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .label // Set the text color to system label color (works with Dark Mode)
        textView.backgroundColor = .systemBackground // Set the background color to system background color (works with Dark Mode)
        return textView
    }()

    private let releaseNotesText = """
    
    v1.7 (xx/xx/xxxx - Build 49 - xx)

    - x
    
    v1.6.2 (19/09/2024 - Build 46-48)

    - iOS 18 support added
    - Minor UI improvements
    - Minor bug fixes

    v1.6.1 (04/02/2024 - Build 45)

    - Apple Vision Pro support
    
    v1.6 (01/02/2024 - Build 44)

    - Portfolio update
    - Our story added
    - New AppBackground added
    
    v1.6 (08/10/2023 - Build 43)

    - Debugging new alternate app icons code
    - Update dark mode settings
    - VoiceOver optimalisations
    - iOS 15 support fixed
    - Bug fixes

    v1.6 (08/10/2023 - Build 36-42)

    - New alternate app icons code
    - Bug fixes
    
    v1.5.5 (18/09/2023)

    - iOS 17 optimalisations
    - New symbols in Let’s connect
    - Minor bug fixes
    
    v1.5.4 (14/09/2023)

    - All InfoViews have been added
    - Minor bug fixes
    
    v1.5.3 (13/08/2023)

    - New Home (Initial View Controller)
    - Moved “The Vault”
    - Updated “The Vault” UI
    - Moved “Let’s connect” to Settings
    - Moved “About us” to Settings
    - As requested, added VoiceOver to new “Home” (Hopefully it works, couldn’t test)
    
    v1.5.2 (09/08/2023 - Build 31)

    - Hotfix in “New” FeaturedDetailViewController
    
    v1.5.2 (05/08/2023 - Build 30)

    - Release notes updated

    v1.5.2 (05/08/2023 - Build 29)

    - “About us” renamed to “Our story”
    - More information about Ghent Photography added
    - New UI in “Our story”
    - Additional information added to all photos
    - Minor Swift-code clean-up

    v1.5.2 (05/08/2023 - Build 28)

    - Updated “Home” ViewController
    - New “Settings” ViewController
    - Dark Mode settings introduced in-app
    - Disclaimers renamed to Policies and moved to Settings
    - Easter egg added somewhere in the app
    - Push notifications shortcut integrated in the app
    - Constraint fixes through Portfolio
    - Minor bug fixes
    
    v1.5.1 (01/08/2023 - Build 27)

    - Constraints and ViewCells updates
    - Additional information added in Featured

    v1.5.1 (01/08/2023 - Build 26)

    - “The Vault” has been added to the Portfolio
    - Additional information has been added to “The Vault”
    - Photo database has been updated
    - “The Vault Entry” has been added to the Portfolio
    - Constraints updates on all ViewControllers in Portfolio
    - CollectionView has received new dimensions and will be deployed on other VC’s soon

    v1.5.1 (31/07/2023 - Build 25)

    - “The Vault” has been added to the Portfolio
    - “The Vault” has to be unlocked first! :)

    v1.5.1 (30/07/2023)

    - “More information” buttons added in all DetailViewControllers in Portfolio
    - Dark mode introduced in more UI
    - More content added to the photo database and coded into the Portfolio
    - ViewCells have been tweaked to show photos correctly
    - More information has been added to the first five photos in Featured
    - Minor bug fixes

    v1.5 (28/07/2023)

    - Updated photo database
    - “New” View Controller in Portfolio added and functional
    - “Landscape” View Controller in Portfolio added and functional
    - “Portrait” View Controller in Portfolio added and functional
    - Save to Photo album including code has been removed
    - AppIcons and info.plist change added
    - Minor UI tweaks in tab bar controllers

    v1.4.3 (26/07/2023 - Build 22)

    - Save to Photo album added
    - Featured photos added and connected

    v1.4.3 (26/07/2023 - Build 21)

    - Featured view controller has been fixed
    - ShowDetail has been fixed
    - Removed AV code from ContactViewController
    - Added new AppBackground for ContactViewController
    - Added button icons

    v1.4.3 (26/07/2023 - Build 20)

    - Updated ContactViewController Swift file
    - Added updated constraints to Contact buttons and labels
    - Added Image
    - Removal of unused Swift files
    - Updated Thank you view controller

    v1.4.2 (25/07/2023)

    - New and functional contact page added
    - Updated LaunchScreen
    - Removed unused controller view controllers

    v1.4.1 (24/07/2023)

    - Featured has been connected to the database
    - Constraints needs to be fixed
    - FeaturedShowDetail has been added to the photos
    - All-new App Icon and Launch Screen
    - Minor bug fixes on Welcome view controller

    v1.4 (23/07/2023)

    - Welcome view controller development has been completed
    - New thumbs have been added to the main menu
    - Full auto-alignment on all devices
    - Landscape mode disabled until new launch screen has been designed
    - Added navigation throughout the app
    - Minor bug fixes

    v1.3.2 (21/07/2023)

    - Photo database added
    - New Welcome Screen v1, doesn’t fit on iPad yet
    - Portfolio and About Us should be clickable
    - Minor bug fixes

    v1.3.1 (20/07/2023)

    - Added missing purpose string in info.plist
    - Added about us with infographic

    v1.3 (20/07/2023)

    - Push notifications added and functional!!!
    - Thank you page added
    - Settings page added
    - Updated App Icon & Launch Screen
    - Minor bug fixes

    v1.2.3 (17/07/2023)

    - Added release notes
    - Added featured photos in backend

    v1.2.2 (16/07/2023)

    - Removed all WebViews
    - Portfolio native (Database still needs to be connected)
    - New native contact page
    - New disclaimers page
    - Homepage is currently a placeholder
    - Changed orange to GP Logo Hex

    v1.2.1 (15/07/2023)

    - Bug fix: Auto-alignment of "Privacy policy"

    v1.2 (15/07/2023)

    - Native "Portfolio
    - Native "Disclaimers

    v1.1.4 (14/07/2023)

    - Privacy policy, minor UI fixes

    v1.1.3 (14/07/2023)

    - Bug fix: Updated attributed text in Privacy Policy
    - Bug fix: Privacy policy outlet to contact

    v1.1.2 (13/07/2023)

    - Contact outlet to Privacy Policy
    - Auto align privacy policy
    - Facebook button not working
    - New app homepage without menu in WebView

    v1.1.1 (12/07/2023)

    - Further rollout of the new menu across the app
    - Enhanced “Updates” WebViewUI
    - Places to visit list postponed and code removed from project
    - Local notification code and removed from project
    - Removed contact form from “Contacts” View Controller
    - Bug fix: Contact page auto-aligned
    - Bug fix: Outlets connected
    - Bug fix: No view in “About us” View Controller
    - Bug fix: Navigation Controller aligned on iPad

    v1.1 (11/07/2023)

    - NEW: Menu bar for several view controllers (Actually very enthusiastic about this one!)
    - Added “Places to visit” list (Non functional for the moment)
    - Fixed version view in “Thank You” view controller and moved to Privacy Policy
    - Added privacy policy on the App Store Connect page
    - Added native privacy policy in app
    - No Privacy policy text in Dark Mode
    - Navigation controller not aligned on iPad (yet)

    v1.0.3 (10/07/2023)

    - Temporary App Icon with “New” Label
    - Minor UI changes
    - Version number added in “Thank you” view controller

    v1.0.2 (09/07/2023)

    - Added Thank You view controller with a direct link from Main View Controller
    - Temporarily disabled auto-rotation on iPad due to auto-align issues
    - New version and build number management

    v1.0.1 (08/07/2023)

    - Minor UI optimalisations

    v1.0 (08/07/2023)

    - Added WebViews to display the website a test
    - Added UIKit into several Swift files
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        title = "Release Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34), // Adjust the font size as needed
            .foregroundColor: UIColor.label // Use .label for automatic Dark Mode support
        ]
    }
    
    private func setupViews() {
        title = "Release Notes"
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(releaseNotesTextView)

        // Add constraints for the scroll view to fill the view
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Add constraints for the text view to fill the scroll view and adjust its width to the view
        NSLayoutConstraint.activate([
            releaseNotesTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            releaseNotesTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            releaseNotesTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            releaseNotesTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            releaseNotesTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40) // Adjust the constant as needed
        ])

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Adjust the line spacing as needed

        let versionNumberAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20), // Adjust the font size as needed
            .foregroundColor: UIColor.label, // Use .label for automatic Dark Mode support
            .paragraphStyle: paragraphStyle
        ]

        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17), // Adjust the font size as needed
            .foregroundColor: UIColor.label, // Use .label for automatic Dark Mode support
            .paragraphStyle: paragraphStyle
        ]

        let formattedText = NSMutableAttributedString()
        let releaseNotesLines = releaseNotesText.components(separatedBy: "\n")

        for line in releaseNotesLines {
            if line.hasPrefix("v") {
                // Apply version number attributes
                let versionNumber = line.prefix(while: { $0 != "\n" })
                let versionLine = NSMutableAttributedString(string: String(versionNumber), attributes: versionNumberAttributes)
                formattedText.append(versionLine)

                // Add a newline after the version number
                formattedText.append(NSAttributedString(string: "\n", attributes: regularAttributes))
            } else {
                // Apply regular attributes
                let regularLine = NSAttributedString(string: line, attributes: regularAttributes)
                formattedText.append(regularLine)

                // Add a newline after the regular line
                formattedText.append(NSAttributedString(string: "\n", attributes: regularAttributes))
            }
        }

        // Apply the formatted text to the UITextView
        releaseNotesTextView.attributedText = formattedText
    }
}
