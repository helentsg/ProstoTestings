//
//  ImagesViewController.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImagesViewController: UITableViewController {
    
    var dataSource: UITableViewDiffableDataSource<Section, Item>! = nil
    
    private var viewModel: ImagesViewModelProtocol! {
        didSet {
            
        }
    }
    
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
extension ImagesViewController {
    
    func createDataSource() {
        
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
           
            let cellViewModel = self.viewModel.cellViewModel(at: indexPath)
            cell.viewModel = cellViewModel
            
            return cell
        }
        
        self.dataSource.defaultRowAnimation = .fade
        
    }
    
    func createInitialSnapshot() {
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(viewModel.imageObjects)
        self.dataSource.apply(initialSnapshot, animatingDifferences: true)
        
    }
    
    
}

// MARK: - UITableView Data Source Prefetching:
extension ImagesViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        let lastRow = IndexPath(row: viewModel.lastRowIndex, section: 0)
        if viewModel.numberOfRows < 100 && indexPaths.contains(lastRow) {
            viewModel.endIndex += 1
            
        }

    }

}

// MARK: - Actions:
extension ImagesViewController {
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        var titleString = "Идёт загрузка..."
        if viewModel.numberOfRows <= 95 {
            viewModel.startIndex -= 5
        } else {
            titleString = "Нет данных ..."
        }
        let title = NSAttributedString(string: titleString)
        sender.attributedTitle = title
    }
    
}
