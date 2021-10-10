//
//  PageCell.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 6/8/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet{
            
            guard let unwrappedPage = page else {return}
            myImageView.image = UIImage(named: unwrappedPage.image)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.descriptionTitle, attributes:
                [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)
                // NSAttributedString.Key.paragraphStyle : NSTextAlignment.center
            ])
            
            attributedText.append(NSMutableAttributedString(string: "\n\(unwrappedPage.descriptionBody)", attributes:
            [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),
             NSAttributedString.Key.foregroundColor : UIColor.gray
             // NSAttributedString.Key.paragraphStyle : NSTextAlignment.natural
            ]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        //enabling autolayout
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleTextView: UITextView = {
        let title = UITextView()
        title.text = "How To Play"
        title.font = UIFont.boldSystemFont(ofSize: 26)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.isEditable = false
        title.isUserInteractionEnabled = false
        title.isScrollEnabled = false
        return title
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()
        addSubview(topImageContainerView)
        addSubview(descriptionTextView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(myImageView)
        topImageContainerView.addSubview(titleTextView)

        titleTextView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: topImageContainerView.trailingAnchor).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: myImageView.topAnchor).isActive = true

        myImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        //myImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        myImageView.bottomAnchor.constraint(greaterThanOrEqualTo: topImageContainerView.bottomAnchor, constant: 8).isActive = true
        myImageView.topAnchor.constraint(greaterThanOrEqualTo: titleTextView.bottomAnchor, constant: 8).isActive = true
        myImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7).isActive = true

        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
