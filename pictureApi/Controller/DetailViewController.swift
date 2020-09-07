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
        scrollView.backgroundColor = UIColor.black
    }
}
//MARK: - scrollView method
extension DetailViewController: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if let image = imageView.image {
            let ratioW = imageView.frame.width / image.size.width
            let ratioH = imageView.frame.width / image.size.width
            let ratio = ratioW < ratioH ? ratioW : ratioH
            let newWidth = image.size.width * ratio
            let newHeight = image.size.height * ratio
            let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
            let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
            let conditionTop = newHeight*scrollView.zoomScale > imageView.frame.height
            let top = 0.5 * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
            scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
        }
        else{
            scrollView.contentInset = .zero
        }
    }
}
