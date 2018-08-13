//
//  ImageGalleryViewController.swift
//  EmailValidation
//
//  Created by Ghouse Basha Shaik on 13/08/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit

class ImageGalleryViewController: UIViewController {
    var imageArray = [[String:String]]()
    var rowIndex = 0
    
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageNameLabel.text = imageArray[rowIndex]["name"]
        imageView.imageFromServer(urlString: imageArray[rowIndex]["urlImage"]!)
    }
}
