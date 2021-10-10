//
//  HowToPlayViewController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 6/8/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class HowToPlayViewController: UIViewController {
    
    //for to keep vieDiDLoad fucntion more clean!
    let myImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "slide1.png"))
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
        title.isScrollEnabled = false
        return title
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Deck", attributes:
            [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)
        ])
        
        attributedText.append(NSMutableAttributedString(string: "\n\n\nA deck consists of 81 unique cards", attributes:
        [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18),
         NSAttributedString.Key.foregroundColor : UIColor.gray
        ]))
        textView.attributedText = attributedText

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.gray, for: .normal)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainOrange, for: .normal)
        
        return button
    }()
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 6
        pc.currentPageIndicatorTintColor = UIColor.mainOrange
        pc.pageIndicatorTintColor = UIColor.mainOrange.withAlphaComponent(0.5)
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupBottomControlls()
    }
    
    private func setupBottomControlls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        bottomControlsStackView.axis = .horizontal
        
        bottomControlsStackView.backgroundColor = UIColor.red
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 1),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()
        //topImageContainerView.backgroundColor = UIColor.green
        view.addSubview(topImageContainerView)
        view.addSubview(descriptionTextView)
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(myImageView)
        topImageContainerView.addSubview(titleTextView)
        
        // initialize a safe area variable
        //let guide = view.safeAreaLayoutGuide

        titleTextView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo: topImageContainerView.leadingAnchor).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: topImageContainerView.trailingAnchor).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: myImageView.topAnchor).isActive = true
        
        myImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        //myImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        myImageView.bottomAnchor.constraint(greaterThanOrEqualTo: topImageContainerView.bottomAnchor, constant: 8).isActive = true
        myImageView.topAnchor.constraint(greaterThanOrEqualTo: titleTextView.bottomAnchor, constant: 8).isActive = true
        myImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.7).isActive = true

        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    

}
