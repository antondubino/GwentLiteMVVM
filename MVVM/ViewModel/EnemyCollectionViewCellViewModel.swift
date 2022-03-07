//
//  EnemyCollectionViewCellViewModel.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import Foundation

class EnemyCollectionViewCellViewModel: EnemyCollectionViewCellViewModelType {
    
    private var warrior: Warrior
    
    var name: String {
        return warrior.name
    }
    
    var force: String {
        return String(describing: warrior.force)
    }
    
    init(warrior: Warrior) {
        self.warrior = warrior
    }
}
