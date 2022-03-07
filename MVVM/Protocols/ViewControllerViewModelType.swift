//
//  ViewControllerViewModel.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import Foundation

protocol ViewControllerViewModelType {

    var roundCount: Dynamic<Int> { get }
    var playerPass: Dynamic<Int> { get }
    var enemyRandomPass: Dynamic<Int> { get }
    var playerPoints: Dynamic<Int> { get }
    var enemyPoints: Dynamic<Int> { get }
    var playerWinnersCount: Dynamic<Int> { get }
    var enemyWinnersCount: Dynamic<Int> { get }
    var infoText: Dynamic<String> { get }
    
    func createWarriors()
    func createDeck()
    func distributeThreeCards()
    func playerIsPassed()
    func playerWinnerRound()
    func enemyWinnerRound()
    func draw()
    func winner()
    func definitionOfVictory()
    func enemyMove()
    func playerMove()
    func playerNumberOfRows() -> Int
    func enemyNumberOfRows() -> Int
    func playerCollectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> PlayerCollectionViewCellViewModelType?
    func enemyCollectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> EnemyCollectionViewCellViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    
}
