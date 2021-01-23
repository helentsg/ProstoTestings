//
//  ImagesViewController.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImagesViewController: UITableViewController {
    
    private var startIndex = 0 {
        didSet {
            array = Array(startIndex ..< endIndex)
        }
    }
    private var endIndex = 20 {
        didSet {
            array = Array(startIndex ..< endIndex)
        }
    }
    private var array = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

    
// MARK: - Table view data source
extension ImagesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return array.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
        let index = indexPath.row
        let showNumber = array[index] + 1
        cell.configure(with: showNumber)
        return cell
        
    }

}

// MARK: - Setup View:
extension ImagesViewController {
    
    func setupView() {
        
        tableView.estimatedRowHeight = 125
        tableView.rowHeight = UITableView.automaticDimension
        tableView.prefetchDataSource = self
        array = Array(0..<20)
        tableView.reloadData()
        
    }
    
}

// MARK: - UITableView Data Source Prefetching:
extension ImagesViewController: UITableViewDataSourcePrefetching, AlertDisplayer {
    
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    
    let lastRow = IndexPath(row: array.count - 1, section: 0)
    if array.count < 100 && indexPaths.contains(lastRow) {
        endIndex += 1
        let indexPath = IndexPath(row: array.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .fade)
    }
    
  }

}

// MARK: - Actions:
extension ImagesViewController {
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        var titleString = "Идёт загрузка..."
        if array.count <= 95 {
            startIndex -= 5
            let indexPaths = Array(0..<5).map({ IndexPath(row:$0, section: 0) })
            tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            titleString = "Нет данных ..."
        }
        let title = NSAttributedString(string: titleString)
        sender.attributedTitle = title
    }
    
}
