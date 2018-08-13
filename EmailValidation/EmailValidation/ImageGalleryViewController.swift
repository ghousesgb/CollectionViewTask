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
        imageNameLabel.text = imageArray[rowIndex]["title"] as! String
        imageView.imageFromServer(urlString: imageArray[rowIndex]["thumbnailUrl"] as! String)
    }
}
