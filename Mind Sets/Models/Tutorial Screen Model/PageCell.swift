//
//  PageCell.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 6/8/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    var page: Page? {
        didSet{
            
            guard let unwrappedPage = page else {return}
            myImageView.image = UIImage(named: unwrappedPage.image)
            
            descriptionTitleView.attributedText = NSMutableAttributedString(string: unwrappedPage.descriptionTitle, attributes: [NSAttributedString.Key.font: Constants.descriptionTitleFont])
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.descriptionBody, attributes: [NSAttributedString.Key.font: Constants.descriptionFont, NSAttributedString.Key.foregroundColor : UIColor.gray])
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionTitleView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    
    // MARK: - Helpers
    
    private func setupLayout() {
        self.backgroundColor = UIColor.white
        
        let topImageContainerView = UIView()
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.addSubview(myImageView)
        
        self.addSubview(topImageContainerView)
        self.addSubview(descriptionTitleView)
        self.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            myImageView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor, constant: 10),
            myImageView.trailingAnchor.constraint(equalTo: topImageContainerView.trailingAnchor, constant: -10),
            myImageView.bottomAnchor.constraint(greaterThanOrEqualTo: topImageContainerView.bottomAnchor, constant: 8),
            myImageView.topAnchor.constraint(greaterThanOrEqualTo: topImageContainerView.topAnchor, constant: 20),
            myImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7),
            
            descriptionTitleView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20),
            descriptionTitleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionTitleView.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleView.bottomAnchor, constant: 5),
            descriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
