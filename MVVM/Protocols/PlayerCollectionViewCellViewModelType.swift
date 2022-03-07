//
//  PlayerCollectionViewCellViewModelType.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import Foundation

protocol PlayerCollectionViewCellViewModelType: AnyObject {
    var name: String { get }
    var force: String { get }
}
