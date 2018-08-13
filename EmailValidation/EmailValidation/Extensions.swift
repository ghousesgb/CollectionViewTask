//
//  Extensions.swift
//  EmailValidation
//
//  Created by Ghouse Basha Shaik on 13/08/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageFromServer(urlString: String) {
        let url = NSURL(string: urlString)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url as URL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
