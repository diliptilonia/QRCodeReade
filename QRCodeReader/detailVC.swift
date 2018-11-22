//
//  detailVC.swift
//  QRCodeReader
//
//  Created by Dilip's Macbook Air on 20/11/18.
//  Copyright © 2018 AppCoda. All rights reserved.
//

import UIKit

class detailVC: UIViewController {

    var regiID = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
print("IN detail vc \(regiID)")
        
        let Url = String(format: "http://13.126.65.0/api/insert.php")
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = ["select":"1",
                                   "registration_id": String(regiID)]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                    if let nestedDictionary = json["data"] as? [String: Any] {
                        if let first_name: String = nestedDictionary["first_name"] as! NSString as String {
                            print(first_name)
                        }
                        if let last_name: String = nestedDictionary["last_name"] as? NSString! as! String {
                            print(last_name)
                        }
                        if let telephone: String = nestedDictionary["telephone"] as? NSString! as! String {
                            print(telephone)
                        }
                        if let mobile: String = nestedDictionary["mobile"] as? NSString! as! String {
                            print(mobile)
                        }
                        if let email: String = nestedDictionary["email"] as? NSString! as! String {
                            print(email)
                        }
                        if let image: String = (nestedDictionary["image"] as? NSString! as! String) {
                            print(image)
                        }
                    }
                }catch {
                    print(error)
                }
            }
            }.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
