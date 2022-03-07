//
//  EnemyCollectionViewCellViewModelType.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import Foundation

protocol EnemyCollectionViewCellViewModelType: AnyObject {
    var name: String { get }
    var force: String { get }
}
