//
//  IconChangeViewController.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 07/10/2023.
//

import UIKit

class IconChangeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let iconNames: [String?] = [nil, "AppIcon1", "AppIcon2", "AppIcon3"]

    let iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AppIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 48
        imageView.clipsToBounds = true
        return imageView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Select an icon below to change the app's icon."
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    let revertButton: UIButton = UIButton(type: .system)

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRevertButton()
        setupUI()
        
        self.title = "App Icon"

        iconImageView.isAccessibilityElement = true
        iconImageView.accessibilityLabel = "Current App Icon"
        iconImageView.accessibilityHint = "Image showing the current app icon."

        collectionView.delegate = self
        collectionView.dataSource = self

        if let savedIconName = UserDefaults.standard.string(forKey: "selectedIconName") {
            iconImageView.image = UIImage(named: savedIconName) ?? UIImage(named: "AppIcon")
        }
    }
    
    private func setupRevertButton() {
        revertButton.setTitle("Revert to default app icon", for: .normal)
        revertButton.setTitleColor(.red, for: .normal)  // Text color to red
        revertButton.addTarget(self, action: #selector(revertIcon), for: .touchUpInside)
        revertButton.translatesAutoresizingMaskIntoConstraints = false
        revertButton.accessibilityLabel = "Revert to Default Icon"
        revertButton.accessibilityHint = "Double-tap to revert to the default app icon."
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(iconImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(revertButton)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 150),
            iconImageView.heightAnchor.constraint(equalToConstant: 150),
            
            descriptionLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            revertButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            revertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func revertIcon() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        changeIcon(to: nil)
    }
    
    private func changeIcon(to name: String?) {
        guard UIApplication.shared.supportsAlternateIcons else {
            print("App does not support alternate icons.")
            return
        }
        
        UIApplication.shared.setAlternateIconName(name) { [weak self] error in
            let generator = UINotificationFeedbackGenerator()
            
            if let error = error {
                print("App icon failed to change due to: \(error.localizedDescription)")
                generator.notificationOccurred(.error)
            } else {
                print("App icon changed successfully!")
                self?.iconImageView.image = UIImage(named: name ?? "AppIcon")
                UserDefaults.standard.setValue(name, forKey: "selectedIconName")
                generator.notificationOccurred(.success)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        iconImageView.image = UIImage(named: iconNames[indexPath.row] ?? "AppIcon")
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = 24
        iconImageView.clipsToBounds = true
        
        cell.contentView.subviews.forEach({ $0.removeFromSuperview() })
        cell.contentView.addSubview(iconImageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        changeIcon(to: iconNames[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = 100 * iconNames.count
        let totalSpacingWidth = 10 * (iconNames.count - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
}
