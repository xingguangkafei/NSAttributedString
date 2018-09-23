//
//  LigatureViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 19/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class LigatureViewController: SuperViewController {
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let ligatureArray:[Int] = [0,1]
    let pinyin = "A solitary carriage to the frontiers bound,An envoy with no retinue around,A drifting leaf from proud Cathy,With geese back north on a hordish day.A smoke hangs straight on the desert vast,A sun sits round on the endless stream.A horseman bows by a fortress passed:\"The general’s at the north extreme!\""
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "Ligature"
        self.labelTop.constant = UIApplication.shared.statusBarFrame.height + 44
        initLabel()
        initTableView()
    }
    
    func initLabel(){
        let attrStr = NSMutableAttributedString.init(string: self.titleStr + pinyin, attributes: nil)
        label.attributedText = attrStr
    }
    
    func initTableView(){
        hildTableViewExtraCellLineHidden(tableView: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func refreshLabel(index:Int){
        /*
         ligature n. 绷带；绳索；连字；连接物
         就是有的挨着的两个字母连在一起 fl  → ﬂ ，模拟器不支持这种样式显示
         */
        let dict = [NSAttributedStringKey.ligature:index]
        
        let attrStr = NSMutableAttributedString.init(string: self.titleStr + pinyin, attributes: dict)
        label.attributedText = attrStr
    }
}
extension LigatureViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ligatureArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        switch indexPath.row {
        case 0:
         cell?.textLabel?.text = "关闭连字功能"
        break
        case 1:
        cell?.textLabel?.text = "开启连字功能"
        default:
            cell?.textLabel?.text = ""
        }
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension LigatureViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(index: self.ligatureArray[indexPath.row])
    }
}




