//
//  ImagesViewController.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImagesViewController: UITableViewController {
    
    var dataSource: UITableViewDiffableDataSource<Section, Item>! = nil
    
    private var viewModel: ImagesViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

// MARK: - Setup View:
extension ImagesViewController {
    
    func setupView() {
        
        viewModel = ImagesViewModel()
        setupTableView()
        createDataSource()
        createInitialSnapshot()
    }
    
    func setupTableView() {
        
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableView.automaticDimension
        tableView.prefetchDataSource = self
        
    }
    
}

// MARK: - Table View Diffable Data Source:
extension ImagesViewController : AlertDisplayer {
    
    func createDataSource() {
        
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) { [weak self]
            (tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? in
            
            guard let self = self else {
                return nil
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
            
            let cellViewModel = self.viewModel.cellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            
            ImageLoader.shared.downloadImage(withURL: item.url, forItem: item) { (result) in
                switch result {
                case .success((let fetchedItem, let fetchedImage)):
                    if let image = fetchedImage, image != fetchedItem.image {
                        var updatedSnapshot = self.dataSource.snapshot()
                        if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
                            let item = self.viewModel.items[datasourceIndex]
                            item.image = image
                            updatedSnapshot.reloadItems([item])
                            self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
                        }
                    }
                case .failure(let error):
                    self.displayAlert(with: "", message: error.description)
                }
            }
            
            return cell
        }
        
        self.dataSource.defaultRowAnimation = .fade
        
    }
    
    func createInitialSnapshot() {
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(viewModel.items)
        self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        
    }
    
}

// MARK: - UITableView Data Source Prefetching:
extension ImagesViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        let lastRow = IndexPath(row: viewModel.lastRowIndex, section: 0)
        if viewModel.numberOfRows < 100 && indexPaths.contains(lastRow) {
            
            viewModel.endIndex += 1
            var updatedSnapshot = self.dataSource.snapshot()
            let lastNumber = viewModel.lastNumber
            updatedSnapshot.appendItems([lastNumber])
            self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
            
        }

    }

}

// MARK: - Actions:
extension ImagesViewController {
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        var titleString = "Идёт загрузка..."
        let oldFirstNumber = viewModel.firstNumber
        
        if viewModel.numberOfRows <= 95 {
            viewModel.startIndex -= 5
            
            var updatedSnapshot = self.dataSource.snapshot()
            let firstFiveNumbers = viewModel.firstFiveNumbers
            updatedSnapshot.insertItems(firstFiveNumbers, beforeItem: oldFirstNumber)
            
            self.dataSource.apply(updatedSnapshot, animatingDifferences: true)
            
        } else {
            titleString = "Нет данных ..."
        }
        let title = NSAttributedString(string: titleString)
        sender.attributedTitle = title
    }
    
}
