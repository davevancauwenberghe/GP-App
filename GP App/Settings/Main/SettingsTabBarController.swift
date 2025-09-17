//
//  SettingsTabBarController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 11/08/2023.
//

import UIKit

class SettingsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the navigation title to "Settings" with large title style
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Retrieve the storyboard instance
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the SettingsViewController from storyboard using its identifier
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
        
        // Set the view controller for the tab bar
        viewControllers = [settingsVC]
        
        // Customize tab bar appearance if needed
        tabBar.tintColor = .systemBlue
    }
}
