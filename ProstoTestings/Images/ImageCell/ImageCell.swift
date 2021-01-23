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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

//MARK:- Cell Configuration:
extension ImageCell {
    
    func configure(with number: Int) {
        
        activityIndicator.startAnimating()
        titleLabel.text = "# \(number)"
        
        let imageLoader = ImageLoader(for: number)
        imageLoader.getImage { [weak self] (result) in
            self?.activityIndicator.stopAnimating()
           
            switch result {
            case .success(let image):
                self?.placeholderImageView.image = image
            case .failure(let error):
                print (error.description)
            }
            
        }
        
    }
    
}

//MARK:- Setup View:
extension ImageCell {
    
    func setupView() {
        
        placeholderImageView.layer.cornerRadius = 16
        
        
    }
    
}
