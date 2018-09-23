//
//  StrikethroughStyleViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 19/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class StrikethroughStyleViewController: SuperViewController {

    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let StrikethroughStyleArray:[Int] = [0,1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "StrikethroughStyle"
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
    
    func refreshLabel(index:Int){
         // 删除线
        let dict = [NSAttributedStringKey.strikethroughStyle:index]
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: dict)
        label.attributedText = attrStr
    }
}
extension StrikethroughStyleViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.StrikethroughStyleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "关闭删除线功能"
            break
        case 1:
            cell?.textLabel?.text = "开启删除线功能"
        default:
            cell?.textLabel?.text = ""
        }
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension StrikethroughStyleViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(index: self.StrikethroughStyleArray[indexPath.row])
    }
}





