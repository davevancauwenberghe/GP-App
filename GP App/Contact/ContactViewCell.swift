//
//  ContactViewCell.swift
//  GP App
//
//  Created by Dave Van Cauwenberghe on 10/08/2023.
//

import UIKit

class ContactViewCell: UITableViewCell {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(chevronImageView)
        
        // Configure constraints for iconImageView
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // Configure constraints for titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -16)
        ])
        
        // Configure constraints for chevronImageView
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
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
    
    // Public method to set the cell's content
    func configure(iconImage: UIImage?, title: String) {
        iconImageView.image = iconImage
        titleLabel.text = title
    }
}
