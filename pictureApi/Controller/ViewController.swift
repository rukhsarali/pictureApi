//
//  ViewController.swift
//  pictureApi
//
//  Created by Rukhsar on 28/08/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pictureApiRequest = PictureApiRequest()
    var pictureRec = [PictureApi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
}
//MARK: - load Data
extension ViewController {
    func loadData() {
        pictureApiRequest.performRequest{[weak self] pictures in
            switch pictures {
            case .failure(let error):
                print(error)
            case .success(let pictureGet):
                self?.pictureRec = pictureGet
                // print(self?.pictureRec[0].url)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: - tableView Delegate
extension ViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureRec.count //pictureRec.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailView", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.imageViewDetail = pictureRec[(tableView.indexPathForSelectedRow?.row)!]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomizeTableViewCell
        let url =  URL(string: pictureRec[indexPath.row].thumbnailUrl)
        cell.cellLabel.text = pictureRec[indexPath.row].title
        cell.cellImageView.sd_setImage(with: url, placeholderImage: nil, options: SDWebImageOptions.highPriority, context: nil, progress: nil) { (Image, Error, Cache, Url) in
            if let error = Error {
                print("Error occur during downloading image\(error)")
            }else {
                print("success")
            }
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6324253375, green: 0.7843137255, blue: 0.9803921569, alpha: 1)
        cell.backgroundColor = #colorLiteral(red: 0.9458476027, green: 1, blue: 1, alpha: 1)
        return cell
    }
    //for animate tableViewCell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity , 0 , 50 , 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

