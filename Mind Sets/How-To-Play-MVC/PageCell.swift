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
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.descriptionTitle, attributes:
                                                            [NSAttributedString.Key.font: Constants.descriptionTitleFont
                                                            ])
            
            attributedText.append(NSMutableAttributedString(string: "\n\(unwrappedPage.descriptionBody)", attributes:
                                                                [NSAttributedString.Key.font: Constants.descriptionFont,
                                                                 NSAttributedString.Key.foregroundColor : UIColor.gray
                                                                ]))
            
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
    
    let titleTextView: UITextView = {
        let title = UITextView()
        title.backgroundColor = UIColor.white
        title.text = Constants.rulesTitle
        title.textColor = UIColor.black
        title.font = Constants.titleFont
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.isEditable = false
        title.isUserInteractionEnabled = false
        title.isScrollEnabled = false
        return title
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
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
        topImageContainerView.addSubview(titleTextView)
        
        self.addSubview(topImageContainerView)
        self.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            topImageContainerView.topAnchor.constraint(equalTo: topAnchor),
            topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            titleTextView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            titleTextView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor),
            titleTextView.trailingAnchor.constraint(equalTo: topImageContainerView.trailingAnchor),
            
            //myImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor),
            myImageView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor, constant: 10),
            myImageView.trailingAnchor.constraint(equalTo: topImageContainerView.trailingAnchor, constant: -10),
            myImageView.bottomAnchor.constraint(greaterThanOrEqualTo: topImageContainerView.bottomAnchor, constant: 8),
            myImageView.topAnchor.constraint(greaterThanOrEqualTo: titleTextView.bottomAnchor, constant: 20),
            myImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7),
            
            descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20),
            descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
