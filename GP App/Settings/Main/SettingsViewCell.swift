//
//  SettingsViewCell.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 02/08/2023.
//

import UIKit

class SettingsViewCell: UITableViewCell {
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Set label properties to prevent truncation and adjust layout
        titleLabel.numberOfLines = 0 // Allow multiple lines
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical) // Adjust priority

        // Set the chevron image
        chevronImageView.image = UIImage(systemName: "chevron.right")

        // Adjust the constraints to center the icon vertically
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        iconContainerView.widthAnchor.constraint(equalTo: iconContainerView.heightAnchor).isActive = true
        iconContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        iconContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconContainerView.heightAnchor.constraint(equalToConstant: 24).isActive = true

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: iconContainerView.trailingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevronImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        chevronImageView.heightAnchor.constraint(equalTo: chevronImageView.widthAnchor).isActive = true
    }

    // Add floating animation to the cell
    func addFloatingAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            // Move the cell slightly up and down
            self.transform = CGAffineTransform(translationX: 0, y: -5)
        }, completion: nil)
    }
    
    // Remove floating animation from the cell
    func removeFloatingAnimation() {
        self.layer.removeAllAnimations()
        self.transform = .identity
    }
}
