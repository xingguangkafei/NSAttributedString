//
//  TextEffectViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 22/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class TextEffectViewController: SuperViewController {

    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "TextEffect"
        self.labelTop.constant = UIApplication.shared.statusBarFrame.height + 44 + 5
        initLabel()
        initTableView()
    }
    
    func initLabel(){
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: nil)
        label.attributedText = attrStr
    }
    
    func initTableView(){
        hildTableViewExtraCellLineHidden(tableView: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func refreshLabel(){
        // 模拟器没有测出来什么...
        let dict = [NSAttributedStringKey.textEffect:NSAttributedString.TextEffectStyle.letterpressStyle]
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: dict)
        label.attributedText = attrStr
    }
}
extension TextEffectViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        cell?.textLabel?.text = "NSAttributedString.TextEffectStyle.letterpressStyle"
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension TextEffectViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel()
    }
}






