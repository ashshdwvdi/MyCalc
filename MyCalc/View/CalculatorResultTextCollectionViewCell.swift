//
//  CalculatorResultTextCollectionViewCell.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 16/02/21.
//

import UIKit

class CalculatorResultTextCollectionViewCell: UICollectionViewCell {
    
    private let resultTextview: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 50)
        textView.textColor = .white
        textView.textAlignment = .right
        textView.isScrollEnabled = false
        textView.backgroundColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var textViewHeightConstraint: NSLayoutConstraint = {
        let constraint = self.resultTextview.heightAnchor.constraint(equalToConstant: 0)
        constraint.priority = .defaultHigh
        return constraint
    }()
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.resultTextview)
        self.resultTextview.sizeToFit()
        self.resultTextview.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.resultTextview.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        self.resultTextview.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let targetSize = CGSize(width: self.resultTextview.frame.width, height: CGFloat(MAXFLOAT))
        textViewHeightConstraint.constant = self.resultTextview.sizeThatFits(targetSize).height
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.resultTextview.text = ""
    }
    
    // MARK: - Public methods
    
    func set(operationString: String?) {
        self.resultTextview.text = operationString
    }
}
