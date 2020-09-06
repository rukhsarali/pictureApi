//
//  DetailViewController.swift
//  pictureApi
//
//  Created by Rukhsar on 04/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var imageViewDetail : PictureApi?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 6
        scrollView.delegate = self
        imageView.load(url: imageViewDetail!.url)
    }
}
//MARK: - scrollView method
extension DetailViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
