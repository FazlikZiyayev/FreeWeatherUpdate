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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        
        return label
    }()
    
    
    var rightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        contentView.layer.backgroundColor = UIColor.black.cgColor
        
        setup_titleLabel()
        setup_rightLabel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        UIView.animate(withDuration: 0.3) {
            if highlighted {
                self.contentView.alpha = 0.5
            } else {
                self.contentView.alpha = 1.0
            }
        }
    }
    
    
    
    func configure(withTitle title: String, withDesc desc: String) {
        titleLabel.text = title
        rightLabel.text = desc
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
    
    
    func setup_rightLabel() {
        contentView.addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            rightLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            rightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            rightLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
}
