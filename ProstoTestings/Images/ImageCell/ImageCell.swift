//
//  ImageCell.swift
//  ProstoTestings
//
//  Created by  Елена on 23.01.2021.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var placeholderImageView : UIImageView!
    @IBOutlet weak var titleLabel           : UILabel!
    @IBOutlet weak var activityIndicator    : UIActivityIndicatorView!
    
    var viewModel: ImageCellViewModelProtocol! {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        placeholderImageView.image = nil
        
    }
    
}

//MARK:- Cell Configuration:
extension ImageCell {
    
    func configureCell() {
        titleLabel.text = "# \(viewModel.number)"
        activityIndicator.startAnimating()
        viewModel.downloadImage {[weak self] (result) in
            self?.activityIndicator.stopAnimating()
            switch result {
            case .success(let image):
                self?.placeholderImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK:- Setup Cell:
extension ImageCell {
    
    func setupCell() {
        
        placeholderImageView.layer.cornerRadius = 16
        
    }
    
}
