//
//  ViewController.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 18.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet var tableView: UITableView!
    private var bannerModels = [BannerJson]()
    private var articleModels = [ArticleJson]()
    private var coreArticle = [Article]()
    private var coreBanner = [Banner]()
    @IBOutlet var uiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        uiView.layer.cornerRadius = 8.0
        uiView.layer.borderColor = UIColor.black.cgColor
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapSettings))
        
        if(isEmptyModel()){
            print("cached data")
            getAll()
        }else{
            getData()
        }
        
    }
    
    func deleteObjects(){
        if(coreArticle.isEmpty){
            return
        }else{
            coreArticle.forEach { article in
                context.delete(article)
            }
            do {
                try context.save()
                getAll()
            }catch{
                
            }
        }
        
    }
    
    func isEmptyModel() -> Bool{
        do{
            coreArticle = try context.fetch(Article.fetchRequest())
            if(coreArticle.count < 1){
                print("model is empty")
                return false
            }else{
                print("Model count: \(coreArticle.count)")
                return true
            }
        }catch{
            return false
        }
    }
    
    @IBAction func deleting(){
        deleteObjects()
    }
    
    
    @objc func didTapSettings(){
        let storeboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storeboard.instantiateViewController(withIdentifier: "settings_vc")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapAdd(){
        let storeboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storeboard.instantiateViewController(withIdentifier: "new_item_vc")
        navigationController?.pushViewController(viewController, animated: true)
    }

    
    func getData(){
        guard let url = URL(string: "https://onlym.ru/api_test/test.json") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let jsonResult = try JSONDecoder().decode(OnlymJSON.self, from: data)
                print("Json result: \(jsonResult.articles.count)")
                
                self.createActicles(articles: jsonResult.articles)
                self.createBanners(banners: jsonResult.banners)
                
                DispatchQueue.main.async {
                    self.uiView.backgroundColor = Utils.hexStringToUIColor(hex: jsonResult.banners.first!.color)
                }
            }catch{
                print("Json error: \(error)")
            }
        }
        task.resume()
    }
    
    func createActicles(articles: [ArticleJson]){
        print("create articles")
        articles.forEach { article in
            createActicleItem(title: article.title, text: article.text)
        }
    }
    
    func createBanners(banners: [BannerJson]){
        print("create banners")
        banners.forEach{banner in
            createItemBanner(name: banner.name, color: banner.color, active: banner.active)}
        
    }
    
    func createItemBanner(name: String, color: String, active: Bool){
        let newBanner = Banner(context: context)
        newBanner.name = name
        newBanner.color = color
        newBanner.active = active
        do{
            try context.save()
            print("Banner was saved")
            getAll()
        }catch{
            
        }
    }
    
    func createActicleItem(title: String, text: String){
        let newArticle = Article(context: context)
        newArticle.title = title
        newArticle.text = text
        do{
            try context.save()
            print("Data was saved")
            getAll()
        }catch{
            
        }
    }
    
    func getAll(){
        do {
            coreArticle = try context.fetch(Article.fetchRequest())
            coreBanner = try context.fetch(Banner.fetchRequest())
            print("Model: \(coreArticle.count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.firstBannerColor(banner: self.coreBanner)
            }
        }catch{
            
        }
    }
    
    func firstBannerColor(banner: [Banner]){
        if(banner.count > 0){
            let itemBanner = banner.last
            self.uiView.backgroundColor = Utils.hexStringToUIColor(hex: itemBanner!.color!)
            
        }else{
            return
        }
    }
    
}

extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me! \(indexPath.row)")
    }
}

extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coreArticle.count
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let item = coreArticle[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = coreArticle[indexPath.row]
        let cellArticle = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cellArticle.textLabel?.text = model.title
        return cellArticle
    }
}

