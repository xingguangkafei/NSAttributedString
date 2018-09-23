//
//  ExpansionViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 23/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class ExpansionViewController: SuperViewController {
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let ObliquenessArray:[Float] = [-5.0,-3.0,-1.0,0.0,1.0,3.0,5.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "ExpansionView"
        self.labelTop.constant = UIApplication.shared.statusBarFrame.height + 44
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
    
    func refreshLabel(index:Float){
        // expansion 膨胀； 会改变字体大小，横向的竖向的，只是大小会变形
        let dict = [NSAttributedStringKey.expansion:index]
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: dict)
        label.attributedText = attrStr
    }
}
extension ExpansionViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ObliquenessArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        cell?.textLabel?.text = "\(self.ObliquenessArray[indexPath.row].description)"
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension ExpansionViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(index: self.ObliquenessArray[indexPath.row])
    }
}
