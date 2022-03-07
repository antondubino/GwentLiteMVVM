//
//  PlayerCollectionViewCell.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forceLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.superview?.layer.cornerRadius = 10
        layer.frame.size = CGSize(width: 100, height: 170)
    }
    
    weak var viewModel: PlayerCollectionViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            nameLabel.text = viewModel.name
            forceLabel.text = viewModel.force
        }
    }
}
