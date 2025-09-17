//
//  DarkModeViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 04/08/2023.
//

import UIKit

class DarkModeViewController: UITableViewController {

    private let darkModeKey = "DarkModeEnabled"
    private let useSystemAppearanceKey = "AppUsesSystemAppearance"

    let options = ["Use System Appearance", "Enable Dark mode", "Enable Light mode"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        tableView.tableFooterView = UIView()
        updateSwitchesBasedOnUserPreference()
    }

    private func setupNavigationBar() {
        title = "Dark mode"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.register(DarkModeTableViewCell.self, forCellReuseIdentifier: DarkModeTableViewCell.reuseIdentifier)
    }

    private func updateSwitchesBasedOnUserPreference() {
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: darkModeKey)
        let usesSystemAppearance = UserDefaults.standard.bool(forKey: useSystemAppearanceKey)

        let systemAppearanceSwitch = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DarkModeTableViewCell
        systemAppearanceSwitch?.switchControl.isOn = usesSystemAppearance

        let darkModeSwitch = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? DarkModeTableViewCell
        darkModeSwitch?.switchControl.isOn = isDarkModeEnabled && !usesSystemAppearance

        let lightModeSwitch = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? DarkModeTableViewCell
        lightModeSwitch?.switchControl.isOn = !isDarkModeEnabled && !usesSystemAppearance
        
        setAppWideDarkMode(isDarkModeEnabled)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateSwitchesBasedOnUserPreference()
    }

    private func setAppWideDarkMode(_ enabled: Bool) {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    let useSystemAppearance = UserDefaults.standard.bool(forKey: useSystemAppearanceKey)
                    window.overrideUserInterfaceStyle = useSystemAppearance ? .unspecified : (enabled ? .dark : .light)
                }
            }
        }
    }
}

// MARK: - TableView DataSource and Delegate

extension DarkModeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeTableViewCell.reuseIdentifier, for: indexPath) as! DarkModeTableViewCell

        cell.titleLabel.text = options[indexPath.row]

        cell.iconImageView.image = UIImage(systemName: indexPath.row == 0 ? "gear" : (indexPath.row == 1 ? "moon.fill" : "sun.max.fill"))

        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: darkModeKey)
        let usesSystemAppearance = UserDefaults.standard.bool(forKey: useSystemAppearanceKey)
        cell.switchControl.isOn = indexPath.row == 0 ? usesSystemAppearance : (indexPath.row == 1 ? isDarkModeEnabled && !usesSystemAppearance : !isDarkModeEnabled && !usesSystemAppearance)

        cell.switchValueChanged = { [weak self] isOn in
            self?.switchValueChanged(isOn, cell: cell, at: indexPath)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row >= options.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    private func switchValueChanged(_ isOn: Bool, cell: DarkModeTableViewCell, at indexPath: IndexPath) {
        if indexPath.row == 0 {
            UserDefaults.standard.set(isOn, forKey: useSystemAppearanceKey)
            if isOn {
                UserDefaults.standard.set(traitCollection.userInterfaceStyle == .dark, forKey: darkModeKey)
            }
        } else if indexPath.row == 1 {
            UserDefaults.standard.set(false, forKey: useSystemAppearanceKey)
            UserDefaults.standard.set(isOn, forKey: darkModeKey)
        } else if indexPath.row == 2 {
            UserDefaults.standard.set(false, forKey: useSystemAppearanceKey)
            UserDefaults.standard.set(!isOn, forKey: darkModeKey)
        }
        updateSwitchesBasedOnUserPreference()
    }
}
