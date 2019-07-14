//
//  ArticleDetailViewController.swift
//  NYTimesMostPopular
//
//  Created by FAISAL KHALID on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import UIKit
import ImageSlideshow
class ArticleDetailViewController: UIViewController {

    var article:Article?
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var slider: ImageSlideshow!
    @IBOutlet weak var abstract: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSliderImages()
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.abstract.text = self.article!.abstract
            self.newsTitle.text = self.article!.title
        
        }
    }
    

    func loadSliderImages(){
        var sliderImages:[ImageSource] = []
        for imageObj in article!.media[0].mediaMetadata {
            if let image =  NYTimesWebClient.loadThumbnailFromURL(urlString: imageObj.url) {
                sliderImages.append(ImageSource(image: image))
            }
        }
        
        DispatchQueue.main.async {
            self.slider.setImageInputs(sliderImages)
            self.slider.pageControl.currentPageIndicatorTintColor = UIColor.orange
             self.slider.pageControl.pageIndicatorTintColor = UIColor.white
            self.slider.contentScaleMode = .scaleToFill

        }
    }

    @IBAction func readMoreBtnClicked(_ sender: Any) {
        
        guard let url = URL(string: article!.url) else { return }
        UIApplication.shared.open(url)
        
    }
}
