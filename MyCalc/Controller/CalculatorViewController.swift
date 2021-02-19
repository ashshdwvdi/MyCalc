//
//  ViewController.swift
//  MyCalc
//
//  Created by Ashish Dwivedi on 14/02/21.
//

import UIKit

class CalculatorViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private static let calculatorCellID = "CalculatorCollectionViewCellIdentifier"
    private static let calculatorResultTextCellID = "CalculatorResultTextCollectionViewCellID"
    private static let sectionMargin: CGFloat = 5
    private static let doubleMargin: CGFloat = 2 * sectionMargin
    private static let spacingBetweenCells: CGFloat = 16
    private static let numberOfItemsPerRow: CGFloat = 4
    
    private let viewModel: CalculatorViewModel
    
    // MARK: - Initialization
    
    init(with viewModel: CalculatorViewModel) {
        self.viewModel = viewModel
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 5, left: 0, bottom: 5, right: 0)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CalculatorButtonCollectionViewCell.self, forCellWithReuseIdentifier: Self.calculatorCellID)
        self.collectionView.register(CalculatorResultTextCollectionViewCell.self, forCellWithReuseIdentifier: Self.calculatorResultTextCellID)
    }
    
    override func reloadData() {
        UIView.performWithoutAnimation {
            self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
        }
    }
    
    // MARK: - Overridden methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.viewModel.calculatorRows.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.calculatorRows[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = self.viewModel.getRows(at: indexPath)
        switch row {
        case .answer:
            return self.getInputCell(at: indexPath)
        default:
            return self.getButtonCell(at: indexPath, withToken: row)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.handleTap(on: self.viewModel.getRows(at: indexPath))
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = self.viewModel.getRows(at: indexPath)
        switch row {
        case .answer:
            return CGSize(width: self.collectionView.frame.width, height: self.answerTextHeight())
        default:
            return CGSize(width: self.calculatorButtonWidth(), height: self.calculatorButtonWidth())
        }
    }
    
    // MARK: - Private methods
    
    private func calculatorButtonWidth() -> CGFloat {
        let numberOfItemsPerRow: CGFloat = Self.numberOfItemsPerRow
        let spacingBetweenCells: CGFloat = Self.spacingBetweenCells
        let sectionMargin = Self.doubleMargin
        let totalSpacing = sectionMargin + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (self.collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return width
    }
    
    private func answerTextHeight() -> CGFloat {
        let rows = CGFloat(self.collectionView.numberOfSections)
        let rowHeight = rows * self.calculatorButtonWidth()
        let spacing = rows * Self.sectionMargin
        let buttonsViewHeight = rowHeight + (2 * spacing) 
        return UIScreen.main.bounds.height - buttonsViewHeight - 20
    }
    
    private func getInputCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: Self.calculatorResultTextCellID, for: indexPath) as! CalculatorResultTextCollectionViewCell
        cell.set(operationString: self.viewModel.getResultText())
        return cell
    }
    
    private func getButtonCell(at indexPath: IndexPath, withToken token: CalculatorToken) -> UICollectionViewCell  {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: Self.calculatorCellID, for: indexPath) as! CalculatorButtonCollectionViewCell
        cell.set(for: token)
        cell.layer.cornerRadius = self.calculatorButtonWidth() / 2
        cell.layer.masksToBounds = true
        return cell
    }
}

