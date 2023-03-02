//
//  ViewController.swift
//  jsondecoderuser2_3
//
//  Created by Mac on 02/03/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var UsersTableView: UITableView!
    var useres = [Users]()
    var jesonDecoder : JSONDecoder?
    override func viewDidLoad() {
        super.viewDidLoad()
        UsersTableView.delegate = self
        UsersTableView.dataSource = self
    let uinibName = UINib(nibName: "UsersTableViewCell", bundle: nil)
        self.UsersTableView.register(uinibName, forCellReuseIdentifier: "UsersTableViewCell")
        
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request){ data, response, error in
        print(data)
        print(response)
            if(error == nil){
                do{
    self.jesonDecoder = JSONDecoder()
    let jesonResponse = try self.jesonDecoder?.decode([Users].self, from: data!)
                    self.useres = jesonResponse!
    }catch{
       print("error")
                }
            }
            
            DispatchQueue.main.async {
            self.UsersTableView.reloadData()
        }
        }.resume()
    }


}

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return useres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UsersTableViewCell = self.UsersTableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        let eachuser = useres[indexPath.row]
        UsersTableViewCell.idLabel.text = String(eachuser.id)
        UsersTableViewCell.nameLabel.text = eachuser.name
        UsersTableViewCell.cityLabel.text = eachuser.city
        UsersTableViewCell.latLabel.text = eachuser.lat
        UsersTableViewCell.lngLabel.text = eachuser.lng
        
    return UsersTableViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

