//
//  ImageViewController.swift
//  EmailValidation
//
//  Created by Naren Datta Raparthi on 13/08/18.
//  Copyright © 2018 DEV. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var downloadImage: UIImageView!
    var Arrfetchdata:[[String:String]] = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.jsondata()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func jsondata()  {
        let url = URL(string : "http://www.json-generator.com/api/json/get/cfZidKpScy?indent=2")
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
                    self.Arrfetchdata = try JSONSerialization.jsonObject(with: Data!, options: .mutableLeaves) as! [[String:String]]
                    
                    print(self.Arrfetchdata[0]["urlImage"] ?? "")
                     self.downloadImage.imageFromServer(urlString: self.Arrfetchdata[0]["urlImage"]!)
                }
                catch{
                    print("Error")
                }
            }
        }
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
