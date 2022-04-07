//
//  OnbordingViewController.swift
//  FackChek
//
//  Created by Sinda Arous on 7/4/2022.
//

import UIKit

class OnbordingViewController: UIViewController {
    //var
       var currentPage = 0 {
           didSet{
               pageControl.currentPage = currentPage
               if currentPage  == slides.count - 1{
                   nextBtn.setTitle("Get Started", for: .normal)
               }else{
                   nextBtn.setTitle("Next", for: .normal)
               }
           }
       }
       var slides : [OnboardingSlide] = []
       
       //widgets
       @IBOutlet weak var CollectionView: UICollectionView!
       @IBOutlet weak var pageControl: UIPageControl!
       @IBOutlet weak var nextBtn: UIButton!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           slides = [OnboardingSlide(title: "titre", description: "description", image:   #imageLiteral(resourceName: "shutterstock_1036271818"))   ,OnboardingSlide(title: "titre 2", description: "description 2", image: #imageLiteral(resourceName: "who-flagging-misinformatione822ebc3aaa9f3ba3aa219cb9e6236f9bf2928378c2adc99b3d41fbbdfd20e98")),OnboardingSlide(title: "titre3", description: "description3", image: #imageLiteral(resourceName: "istockphoto-1214704364-612x612"))]
       }
       
       //ibAction
       @IBAction func NextBtnAction(_ sender: UIButton) {
           if currentPage == slides.count - 1{
               let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
               controller.modalPresentationStyle = .fullScreen
               controller.modalTransitionStyle = .flipHorizontal
               present(controller, animated: true, completion: nil)
           }else{
           currentPage += 1
           let indexPath = IndexPath(item: currentPage, section: 0)
           CollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
           }
       }

   }

   extension OnbordingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return slides.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
           cell.setup(slides[indexPath.row])
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: CollectionView.frame.width, height: collectionView.frame.height)
       }
       
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let width = scrollView.frame.width
           currentPage = Int(scrollView.contentOffset.x/width)
           
       }

}
