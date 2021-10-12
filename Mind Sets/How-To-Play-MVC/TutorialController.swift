//
//  TutorialController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 6/8/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class TutorialController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Properties
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.prevButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.nextButtonTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainOrange, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.isUserInteractionEnabled = false
        pc.currentPage = 0
        pc.numberOfPages = Constants.pages.count
        pc.currentPageIndicatorTintColor = UIColor.mainOrange
        pc.pageIndicatorTintColor = UIColor.mainOrange.withAlphaComponent(0.5)
        return pc
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
    
    
    // MARK: - Lifecycle
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        print("page = \(pageControl.currentPage)")
        print(x, view.frame.width, pageControl.currentPage )
        
        if pageControl.currentPage == Constants.pages.count-1 {
            nextButton.setTitle(Constants.playButtonTitle, for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        } else {
            nextButton.setTitle(Constants.nextButtonTitle, for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        //MARK: use this if i want to check the frames of the views!
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath as IndexPath) as! PageCell
        
        let page = Constants.pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    // MARK: - Helpers
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        print("page = \(nextIndex)")
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if pageControl.currentPage == Constants.pages.count-1 {
            nextButton.setTitle(Constants.playButtonTitle, for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        } else {
            nextButton.setTitle(Constants.nextButtonTitle, for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, Constants.pages.count-1)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if let title = nextButton.currentTitle {
            if title == Constants.playButtonTitle {
                startGame()
            }
        }
        
        
        if pageControl.currentPage == Constants.pages.count-1 {
            nextButton.setTitle(Constants.playButtonTitle, for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        } else {
            nextButton.setTitle(Constants.nextButtonTitle, for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    private func startGame() {
        let storyboard = UIStoryboard(name: "Main" , bundle: nil)
        let gameScreen = storyboard.instantiateViewController(withIdentifier: "gameScreenView") as! GameScreenViewController

        UIApplication.shared.windows.first?.rootViewController = gameScreen
        UIApplication.shared.windows.first?.makeKeyAndVisible()
//        let nav = UINavigationController(rootViewController: gameScreen)
//        nav.modalPresentationStyle = .fullScreen
//        nav.modalTransitionStyle = .crossDissolve
//        nav.setNavigationBarHidden(true, animated: false)
//        self.present(nav, animated: true, completion: nil)
    }
    
    private func setupLayout() {
        view.addSubview(titleTextView)

        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .equalSpacing
        bottomControlsStackView.axis = .horizontal
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            titleTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    deinit {
        print("DEINIT: \(self.description)")
    }
    
}

