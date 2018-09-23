//
//  UnderlineColorViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 22/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class UnderlineColorViewController: SuperViewController {

    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    let colorArray:[UIColor] = [UIColor.red,UIColor.orange,UIColor.yellow,UIColor.green,UIColor.cyan,UIColor.blue,UIColor.purple]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "UnderlineColor"
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
    
    func refreshLabel(color:UIColor){
        // 下划线 不是0就代表，有下划线
        let dict = [NSAttributedStringKey.underlineStyle:1,NSAttributedStringKey.underlineColor:color] as [NSAttributedStringKey : Any]
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: dict)
        label.attributedText = attrStr
    }
}
extension UnderlineColorViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.colorArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        cell?.textLabel?.text = "\(self.colorArray[indexPath.row].description)"
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension UnderlineColorViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(color: self.colorArray[indexPath.row])
    }
}
