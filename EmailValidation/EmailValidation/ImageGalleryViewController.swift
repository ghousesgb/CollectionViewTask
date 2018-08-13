//
//  ImageGalleryViewController.swift
//  EmailValidation
//
//  Created by Ghouse Basha Shaik on 13/08/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    var imageArray = [[String:AnyObject]]()
    var rowIndex = 0
    
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image Gallery"
        updateUI()
    }
    @IBAction func previousButtonAction(_ sender: UIButton) {
        rowIndex -= 1
        if rowIndex < 0 {
            rowIndex = imageArray.count - 1
        }
        updateUI()
    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        rowIndex += 1
        if rowIndex >= imageArray.count {
            rowIndex = 0
        }
        updateUI()
    }
    
    func updateUI() {
        if let titleId = imageArray[rowIndex]["id"] as? Int, let name =  imageArray[rowIndex]["title"] as? String {
            imageNameLabel.text = "\(titleId). \(name)"
        }
        if let imageThumbnail = imageArray[rowIndex]["thumbnailUrl"] as? String {
            imageView.imageFromServer(urlString: imageThumbnail)
        }
    }
}
