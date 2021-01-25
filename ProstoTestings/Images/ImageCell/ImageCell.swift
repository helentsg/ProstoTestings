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
        placeholderImageView.image = viewModel.image
        viewModel.image == nil ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        
    }
    
}

//MARK:- Setup Cell:
extension ImageCell {
    
    func setupCell() {
        
        
        placeholderImageView.layer.cornerRadius = 16
        
    }
    
}
