//
//  SettingsViewController.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 18.10.2021.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet var settingTableView: UITableView!
    private var coreBanner = [Banner]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.dataSource = self
        settingTableView.delegate = self
        settingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "setting_cell")
        
        getAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAll()
    }
    
    func getAll(){
        do {
            coreBanner = try context.fetch(Banner.fetchRequest())
            print("Model: \(coreBanner.count)")
            DispatchQueue.main.async {
                self.settingTableView.reloadData()
            }
        }catch{
            
        }
    }
    
    func updateBanner(item: Banner, newState: Bool){
        item.active = newState
        do {
            try context.save()
        }catch{
            
        }
    }
    
    @objc func toggle(_ sender: UISwitch){
        print("Toggle: \(sender.tag)")
        let currentBanner = coreBanner[sender.tag]
        print("Current Banner: \(currentBanner)")
        updateBanner(item: currentBanner, newState: sender.isOn)
    }
    
}

extension SettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coreBanner.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bannerModel = coreBanner[indexPath.row]
        let cellBanner = settingTableView.dequeueReusableCell(withIdentifier: "setting_cell", for: indexPath)
        cellBanner.textLabel?.text = bannerModel.name
        let switchObj = UISwitch(frame: CGRect(x:1, y: 1, width: 20, height: 20))
        switchObj.isOn = bannerModel.active
        switchObj.tag = indexPath.row
        switchObj.addTarget(self, action: #selector(self.toggle(_:)), for: .valueChanged)
        cellBanner.accessoryView = switchObj
        return cellBanner
    }
}

extension SettingsViewController: UITableViewDelegate{
    
}
