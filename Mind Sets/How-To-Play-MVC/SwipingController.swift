//
//  SwipingController.swift
//  Mind Sets
//
//  Created by Maria Yelfimova on 6/8/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
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
    
    let pages = [
        Page(image: "how-to-1-1000", descriptionTitle: "Deck", descriptionBody: "A deck consists of 81 unique cards"),
        Page(image: "how-to-2-1000", descriptionTitle: "Features", descriptionBody: "Each card has 4 varying features: shape, number of shapes, shading, color"),
        Page(image: "how-to-3-1000", descriptionTitle: "Set Rules", descriptionBody: "3 cards must have their features either completely different or the same for all\nAll different: number of shapes, colors, shadings\nAll same: shapes"),
        Page(image: "how-to-4-1000", descriptionTitle: "This is a valid set", descriptionBody: "All same: shapes, color\nAll different: number of shapes, shadings"),
        Page(image: "how-to-5-1000", descriptionTitle: "This is not a valid set", descriptionBody: "All same: shapes\nAll different: color\nNeither the same or different: number of shapes, shading\n(which is a mistake)"),
        Page(image: "how-to-6", descriptionTitle: "Scoring", descriptionBody: "• each Set you get +5 points\n•each Hint you pay -3 points\n•each Deal you get 3 more cards\n to the Deck and a pay -1 point"),
    ]
    
    let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        print("page = \(nextIndex)")
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if pageControl.currentPage == pages.count-1 {
            nextButton.setTitle("PLAY", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        } else {
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(UIColor.mainOrange, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count-1)
        pageControl.currentPage = nextIndex
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        if let title = nextButton.currentTitle {
                if title == "PLAY" {
                    let storyboard = UIStoryboard(name: "Main" , bundle: nil)
                    let logoScreen = storyboard.instantiateViewController(withIdentifier: "logoScreen") as! GifAnimationController
                    logoScreen.modalTransitionStyle = .crossDissolve
                    logoScreen.modalPresentationStyle = .fullScreen
                    self.present(logoScreen, animated: true, completion: nil)
                }
            }
      
    
        if pageControl.currentPage == pages.count-1 {
            nextButton.setTitle("PLAY", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        } else {
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }

    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        print("page = \(pageControl.currentPage)")
        print(x, view.frame.width, pageControl.currentPage )
        
        if pageControl.currentPage == pages.count-1 {
            nextButton.setTitle("PLAY", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        } else {
            nextButton.setTitle("NEXT", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.isUserInteractionEnabled = false
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor.mainOrange
        pc.pageIndicatorTintColor = UIColor.mainOrange.withAlphaComponent(0.5)
        return pc
    }()
    
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
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControlls()
        
        //MARK: use this if i want to check the frames of the views!
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell + at the end casting to the View class of each slide (in this case it's PageCell)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath as IndexPath) as! PageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

