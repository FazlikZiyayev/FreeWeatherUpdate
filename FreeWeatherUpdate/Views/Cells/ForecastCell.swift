//
//  ForecastCell.swift
//  FreeWeatherUpdate
//
//  Created by Fazlik Ziyaev on 12/04/24.
//

import UIKit


class ForecastCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentView.layer.backgroundColor = UIColor.black.cgColor
        setup_titleLabel()
    }
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.3) {
            if highlighted {
                // Apply plain appearance when highlighted
                self.contentView.alpha = 0.5 // Decrease opacity when highlighted
            } else {
                // Revert to normal appearance
                self.contentView.alpha = 1.0 // Restore normal opacity
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure(withTitle title: String) {
        titleLabel.text = title
    }
    
    
    func setup_titleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
