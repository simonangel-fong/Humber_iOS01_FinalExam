//
//  TableViewController.swift
//  final exam
//
//  Created by Simon Fong on 15/12/2023.
// Name: Wenhao Fang
//

import UIKit

class TableViewController: UITableViewController {
    
    let NOTI_NAME_JSON = "NOTI_NAME_JSON"
    let url_json = "https://raw.githubusercontent.com/RaniaArbash/GOT_Data/main/GOT.json"
    
    let appModel = (UIApplication.shared.delegate as! AppDelegate).appModel
    
    var characterList:[characterData] = [characterData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register an observer to call getJson function
        NotificationCenter.default.addObserver(
            self, // the current vc as observer
            selector: #selector(getJson), // the function to execute after a post
            name: Notification.Name(NOTI_NAME_JSON),// the name of notification
            object: nil)
        
        APIManager.shared.fetchData(
            urlStr: url_json, notificationName: NOTI_NAME_JSON)
        print("load")
        
    }
    
    @objc
    func getJson(notification: Notification){
        if let errMsg = notification.userInfo?["error"]{
            print("error")
            print(errMsg)
            
        }
        
        if let data = notification.userInfo?["success"]{
            print("success")
            let jsonData = appModel.decodeJson(data: data as! Data)
            self.characterList = jsonData
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterList.count
    }
    
    /// function to set height of table
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100.0;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tbCell
        
        cell.actor.text = self.characterList[indexPath.row].actorName
        cell.character.text = self.characterList[indexPath.row].characterName
        if let goodUrl = self.characterList[indexPath.row].characterImageThumb{
            loadImg(urlStr: goodUrl,imgV: cell.imageView!)
        }
        
        
        return cell
    }
    
    func loadImg (urlStr:String, imgV:UIImageView){
        let queue = DispatchQueue.init(label: "myQ")
        queue.async {
            do{
                let urlObj = URL(string:urlStr)
                // download data from the url, which taks time
                let imageData = try Data(contentsOf: urlObj!)
                
                /// access items and send data back to the main thread after the bg thread finished
                DispatchQueue.main.async {
                    imgV.image = UIImage(data:imageData)
                    
                }
            }catch{
                print("error")
            }
        }
    }
    
    
}
