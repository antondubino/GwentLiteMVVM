//
//  ViewModel.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//

import Foundation

class ViewModel: ViewControllerViewModelType {
    
    var playerCards: [Warrior] = []
    var playerDeck: [Warrior] = []
    
    var enemyCards: [Warrior] = []
    var enemyDeck: [Warrior] = []
    
    private var selectedIndexPath: IndexPath?
    
    var roundCount = Dynamic(1)
    
    var playerPass = Dynamic(0)
    var enemyRandomPass = Dynamic(0)
    
    var playerPoints = Dynamic(0)
    var enemyPoints = Dynamic(0)
    
    var playerWinnersCount = Dynamic(0)
    var enemyWinnersCount = Dynamic(0)
    
    var infoText = Dynamic("")
    
//MARK: Create cards
    
    func createWarriors() {
        let war1 = Warrior.init(name: "Низушек", force: 1) // 10
        let war2 = Warrior.init(name: "Краснолюд", force: 2) // 5
        let war3 = Warrior.init(name: "Чародейка", force: 4) // 3
        let war4 = Warrior.init(name: "Ведьмак", force: 6) // 2
        playerCards = []
        enemyCards = []
        for _ in 1...10 {
            playerCards.append(war1)
            enemyCards.append(war1)
        }
        for _ in 1...5 {
            playerCards.append(war2)
            enemyCards.append(war2)
        }
        for _ in 1...3 {
            playerCards.append(war3)
            enemyCards.append(war3)
        }
        for _ in 1...2 {
            playerCards.append(war4)
            enemyCards.append(war4)
        }
        playerCards.shuffle()
        enemyCards.shuffle()
    }
    
//MARK: Create decks
    
    func createDeck() {
        playerDeck = []
        enemyDeck = []
        for _ in 1...5 {
            if playerDeck.count < 5 {
                playerDeck.append(playerCards[0])
                self.playerCards.remove(at: 0)
            }
            if enemyDeck.count < 5 {
                enemyDeck.append(enemyCards[0])
                self.enemyCards.remove(at: 0)
            }
        }
    }

//MARK: Distribute Three Cards
    
    func distributeThreeCards() {
        if playerCards.count >= 3 {
            for _ in 1...3 {
                playerDeck.append(playerCards[0])
                playerCards.remove(at: 0)
                }
        }
        if enemyCards.count >= 3 {
            for _ in 1...3 {
                enemyDeck.append(enemyCards[0])
                enemyCards.remove(at: 0)
                }
        }
    }

//MARK: Player pass
    
    func playerIsPassed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.infoText.value = ""
        })
        
        playerPass.value = 1
        // If the enemy also passed
        if enemyRandomPass.value == 1 {
            if playerPoints.value > enemyPoints.value {
                infoText.value = "Победа в раунде"
                playerWinnerRound()
            } else if playerPoints.value < enemyPoints.value {
                infoText.value = "Поражение в раунде"
                enemyWinnerRound()
            } else {
                infoText.value = "Ничья"
                draw()
            }
        }
        // If the enemy did not pass
        if enemyRandomPass.value != 1 {
            for _ in 0...4 {
                if !enemyDeck.isEmpty { // The enemy walks until he runs out of cards
                    enemyMove()
                }
            }
            if enemyPoints.value > playerPoints.value {
                infoText.value = "Поражение в раунде"
                enemyWinnerRound()
            } else if enemyPoints.value < playerPoints.value {
                infoText.value = "Победа в раунде"
                playerWinnerRound()
            } else {
                infoText.value = "Ничья"
                draw()
            }
        }
        definitionOfVictory()
    }
  
//MARK: Player winner round
    
    func playerWinnerRound() {
        playerPoints.value = 0
        enemyPoints.value = 0
        playerPass.value = 0
        playerWinnersCount.value += 1
        roundCount.value += 1
        distributeThreeCards()
    }
    
//MARK: Enemy winner round
    
    func enemyWinnerRound() {
        playerPoints.value = 0
        enemyPoints.value = 0
        playerPass.value = 0
        enemyWinnersCount.value += 1
        roundCount.value += 1
        enemyRandomPass.value = Int.random(in: 0...3)
        distributeThreeCards()
    }
  
//MARK: Draw round
    
    func draw() {
        playerPoints.value = 0
        enemyPoints.value = 0
        playerPass.value = 0
        roundCount.value += 1
        enemyRandomPass.value = Int.random(in: 0...3)
        distributeThreeCards()
    }
 
//MARK: Win the game
    
    func winner() {
        playerPoints.value = 0
        enemyPoints.value = 0
        playerPass.value = 0
        playerWinnersCount.value = 0
        enemyWinnersCount.value = 0
        roundCount.value = 1
        createWarriors()
        createDeck()
        enemyRandomPass.value = Int.random(in: 0...3)
    }
   
//MARK: Determine the winner
    
    func definitionOfVictory() {
        if playerWinnersCount.value == 2  {
            infoText.value = "Вы победили"
            winner()
        } else if enemyWinnersCount.value == 2 {
            infoText.value = "Вы проиграли"
            winner()
        } else if playerWinnersCount.value > enemyWinnersCount.value &&  enemyDeck.isEmpty && playerDeck.isEmpty {
            infoText.value = "Вы победили"
            winner()
        } else if playerWinnersCount.value < enemyWinnersCount.value && enemyDeck.isEmpty && playerDeck.isEmpty{
            infoText.value = "Вы проиграли"
            winner()
        }
    }
 
//MARK: Enemy move
    
    func enemyMove() {
        if enemyRandomPass.value == 1 {
            infoText.value = "Противник спасовал"
        }
        if enemyDeck.count > 0 && enemyRandomPass.value != 1 {
            let point = enemyDeck[0].force
            enemyPoints.value += point
            enemyDeck.remove(at: 0)
            
        }
    }
 
//MARK: Player move
    
    func playerMove() {
        if playerDeck.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.infoText.value = ""
            })
            let index = selectedIndexPath?.row ?? 0
            if enemyDeck.count > 0 && enemyRandomPass.value != 1{
                infoText.value = "Ваш ход \(playerDeck[index].name), ход врага \(enemyDeck[0].name)"
            } else {
                let index = selectedIndexPath?.row ?? 0
                infoText.value = "Ваш ход \(playerDeck[index].name)"
            }
            let point = playerDeck[index].force
            playerPoints.value += point
            playerDeck.remove(at: index)
            }
        }
    
    
//MARK: CollectionViewDelegate
    
    func playerNumberOfRows() -> Int {
        return playerDeck.count
    }
    
    func enemyNumberOfRows() -> Int {
        return enemyDeck.count
    }
    
    func playerCollectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> PlayerCollectionViewCellViewModelType? {
        let warrior = playerDeck[indexPath.row]
        return PlayerCollectionViewCellViewModel(warrior: warrior)
    }
    
    
    func enemyCollectionViewCellViewModel(forIndexPath indexPath: IndexPath) -> EnemyCollectionViewCellViewModelType? {
        let warrior = enemyDeck[indexPath.row]
        return EnemyCollectionViewCellViewModel(warrior: warrior)
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        playerMove()
        enemyMove()
    }
}
