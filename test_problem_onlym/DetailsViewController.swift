//
//  DetailsViewController.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 18.10.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var uiView: UIView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var textLabel: UILabel!
    
    var banenrImage: String = ""
    var articleTitle = ""
    var articleText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.adjustsFontSizeToFitWidth = false
        textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        textLabel.numberOfLines = 0
        
        titleLable.text = articleTitle
        uiView.backgroundColor = Utils.hexStringToUIColor(hex: banenrImage)
        textLabel.text = articleText
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
