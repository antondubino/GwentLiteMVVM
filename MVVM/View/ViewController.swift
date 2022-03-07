//
//  ViewController.swift
//  MVVM
//
//  Created by Антон Дубино on 09.12.2021.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerDeckCollectionView: UICollectionView!
    @IBOutlet weak var enemyDeckCollectionView: UICollectionView!
    @IBOutlet weak var playerScore: UILabel!
    @IBOutlet weak var enemyScore: UILabel!
    @IBOutlet weak var playerWinnersInRounds: UILabel!
    @IBOutlet weak var enemyWinnersInRounds: UILabel!
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var passButton: UIButton!
    
    var viewModel: ViewControllerViewModelType? = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerDeckCollectionView.delegate = self
        playerDeckCollectionView.dataSource = self
        enemyDeckCollectionView.delegate = self
        enemyDeckCollectionView.dataSource = self
        self.playerDeckCollectionView.register(UINib(nibName: "PlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerDeck")
        self.enemyDeckCollectionView.register(UINib(nibName: "EnemyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EnemyDeck")
        viewModel?.createWarriors()
        viewModel?.createDeck()
        bind()
    }
   
//MARK: Button pass
    
    @IBAction func playerPass(_ sender: Any) {
        viewModel?.playerIsPassed()
        reloadData()
    }
  
//MARK: CollectionView.reloadData()
    
    func reloadData() {
        playerDeckCollectionView.reloadData()
        enemyDeckCollectionView.reloadData()
    }

//MARK: Bind labels
    
    func bind() {
        guard let viewModel = viewModel else { return }
        viewModel.playerPoints >>> { self.playerScore.text = "\($0)"
            self.reloadData()
        }
        viewModel.enemyPoints >>> { self.enemyScore.text = "\($0)"
            self.reloadData()
        }
        viewModel.playerWinnersCount >>> { self.playerWinnersInRounds.text = "\($0)"
            self.reloadData()
        }
        viewModel.enemyWinnersCount >>> { self.enemyWinnersInRounds.text = "\($0)"
            self.reloadData()
        }
        viewModel.roundCount >>> { self.round.text = "\($0)"
            self.reloadData()
        }
        viewModel.infoText >>> { self.info.text = $0
            self.reloadData()
        }
    }
}

//MARK: UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == playerDeckCollectionView {
            return viewModel?.playerNumberOfRows() ?? 0
        } else if collectionView == enemyDeckCollectionView {
            return viewModel?.enemyNumberOfRows() ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == playerDeckCollectionView {
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerDeck", for: indexPath) as? PlayerCollectionViewCell
            guard let collectionViewCell = cell1, let viewModel = viewModel else { return UICollectionViewCell() }
            let cellViewModel = viewModel.playerCollectionViewCellViewModel(forIndexPath: indexPath)
            collectionViewCell.viewModel = cellViewModel
            return collectionViewCell
        } else if collectionView == enemyDeckCollectionView {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "EnemyDeck", for: indexPath) as? EnemyCollectionViewCell
            guard let collectionViewCell = cell2, let viewModel = viewModel else { return UICollectionViewCell() }
            let cellViewModel = viewModel.enemyCollectionViewCellViewModel(forIndexPath: indexPath)
            collectionViewCell.viewModel = cellViewModel
            return collectionViewCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        reloadData()
    }
    
}
