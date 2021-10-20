//
//  AddItemViewController.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 18.10.2021.
//

import UIKit

class AddItemViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet var uiView: UIView!
    @IBOutlet var textField: UITextField!
    private var uiColor: String = ""
    private var colors = ["white": "#ffffff", "yellow": "#ffff00", "blue" : "#0000ff"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiView.layer.cornerRadius = 8.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func whiteBtn(){
        uiView.backgroundColor = Utils.hexStringToUIColor(hex: colors["white"]!)
        uiColor = colors["white"]!
    }
    
    @IBAction func yellowBtn(){
        uiView.backgroundColor = Utils.hexStringToUIColor(hex: colors["yellow"]!)
        uiColor = colors["yellow"]!
    }
    
    @IBAction func blueBtn(){
        uiView.backgroundColor = Utils.hexStringToUIColor(hex: colors["blue"]!)
        uiColor = colors["blue"]!
    }
    
    @IBAction func addBanner(){
        let bannerName = textField.text!
        let bannerColor = uiColor
        createItemBanner(name: bannerName, color: bannerColor, active: false)
    }
    
    func createItemBanner(name: String, color: String, active: Bool){
        let newBanner = Banner(context: context)
        newBanner.name = name
        newBanner.color = color
        newBanner.active = active
        do{
            try context.save()
            print("Banner was saved")
        }catch{
            
        }
    }
    
}
