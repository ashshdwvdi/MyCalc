//
//  CalculatorButtonCollectionViewCell.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 16/02/21.
//

import UIKit

class CalculatorButtonCollectionViewCell: UICollectionViewCell {
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.contentView.addSubview(self.numberLabel)
        self.numberLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.numberLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.numberLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.numberLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.numberLabel.text = ""
        self.backgroundColor = .clear
    }
    
    // MARK: - Public methods
    
    func set(for token: CalculatorToken) {
        self.numberLabel.text = token.stringValue
        switch token {
        case .ac:
            self.backgroundColor = .lightGray
        case _ where token.isOperand:
            self.backgroundColor = .orange
        default:
            self.backgroundColor = .darkGray
        }
    }
}

