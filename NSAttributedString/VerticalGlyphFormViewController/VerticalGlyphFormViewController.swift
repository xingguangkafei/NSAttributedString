//
//  VerticalGlyphFormViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 23/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class VerticalGlyphFormViewController: SuperViewController {
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let ObliquenessArray:[Float] = [0,1]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "VerticalGlyphForm"
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
        // 文档里写的设置完，这个值就会显示横向的文字排版或者竖向的文字排版，但是竖向的值设置后，运行起来却是只有标点符号换成竖向的，可能还需要设置其他属性
        let dict = [NSAttributedStringKey.verticalGlyphForm:index]
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: dict)
        label.attributedText = attrStr
    }
}
extension VerticalGlyphFormViewController:UITableViewDataSource{
    
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

extension VerticalGlyphFormViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(index: self.ObliquenessArray[indexPath.row])
    }
}
