//
//  DynamicViewController.swift
//  EmailValidation
//
//  Created by Ghouse Basha Shaik on 13/08/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit

class DynamicImageCell : UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

class DynamicViewController: UIViewController {

    @IBOutlet weak var rowsTextField: UITextField!
    @IBOutlet weak var columnsTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageArray = [[String:AnyObject]]()
    fileprivate var rows: Int = 2
    fileprivate var columns: Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        //self.view.addGestureRecognizer(tapGesture)
        rowsTextField.text = "\(rows)"
        columnsTextField.text = "\(columns)"
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.jsondata()
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    fileprivate func validateRowsAndColumns() -> Bool {
        guard let rows = rowsTextField.text, rows.count > 0 else { return false }
        guard let columns = columnsTextField.text, columns.count > 0 else { return false }
        self.rows = Int(rows)!
        self.columns = Int(columns)!
        return true
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if validateRowsAndColumns() {
            collectionView.reloadData()
        }else {
            let alertController = UIAlertController(title: "Alert", message: "Kindly mention Both Rows and Colums", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageGallerySegue" {
            let indexPath = sender as! IndexPath
            let imageGalleryVC = segue.destination as! ImageGalleryViewController
            imageGalleryVC.imageArray = imageArray
            imageGalleryVC.rowIndex = indexPath.row
        }
    }
}

extension DynamicViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if rows * columns <= imageArray.count {
            return rows * columns
        }
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! DynamicImageCell
        cell.backgroundColor = UIColor.white
        cell.imageView.imageFromServer(urlString: self.imageArray[indexPath.row]["thumbnailUrl"]as! String)
        return cell
    }
}

extension DynamicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "imageGallerySegue", sender: indexPath)
    }
}

extension DynamicViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)
        let widthForOneItem = widthAvailbleForAllItems / CGFloat(columns) - flowLayout.minimumInteritemSpacing
        return CGSize(width: CGFloat(widthForOneItem), height: (flowLayout.itemSize.height))
    }
}

extension DynamicViewController {
    func jsondata()  {
        let url = URL(string : "http://jsonplaceholder.typicode.com/photos")
        var request = URLRequest(url: url!)
        request.httpMethod="GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request)
        { (Data,URLResponse,Error) in
            
            if(Error != nil)
            {
                print("Error")
            }
            else{
                do{
                    self.imageArray = try JSONSerialization.jsonObject(with: Data!, options: .mutableLeaves) as! [[String:AnyObject]]
                    self.collectionView.reloadData()
                }
                catch{
                    print("Error")
                }
            }
        }
        task.resume()
    }
}

