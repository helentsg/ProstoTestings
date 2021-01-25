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
        
        viewModel.downloadImage(withURL: viewModel.url, forCell: self) {[weak self] (result) in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
            switch result {
            case .success((let fetchedCell, let fetchedImage)):
                if let imageCell = fetchedCell as? ImageCell,
                   imageCell.tag == self.viewModel.number,
                   let image = fetchedImage,
                   image != self.placeholderImageView.image {
                    self.placeholderImageView.image = image
                }
            case .failure(let error):
                print(error.description)
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
