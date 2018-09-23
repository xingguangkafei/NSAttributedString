//
//  AttachmentViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 22/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class AttachmentViewController: SuperViewController {

    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var attachArray:[String] = ["contents","fileType","image","bounds","fileWrapper"]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "Attachment"
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
    
    func refreshLabel(index:Int){
        // NSTextAttachment 可以带很多种属性，图片，文件...等等
        let attach = NSTextAttachment.init()
        switch index {
        case 0:
            attach.contents = Data.init(base64Encoded: "zhangfangtao", options: .ignoreUnknownCharacters)
            attach.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            let insertAttachStr = NSAttributedString.init(attachment: attach)
            let attrStr = NSMutableAttributedString.init(string: self.titleStr)
            attrStr.insert(insertAttachStr, at: 6)
            label.attributedText = attrStr
            break
        case 1:
            attach.fileType = "txt"
            attach.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            let attrStr = NSMutableAttributedString.init(string: self.titleStr)
            label.attributedText = attrStr
            break
        case 2:
            attach.image = UIImage.init(named: "icon")
            attach.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            let imageStr = NSAttributedString.init(attachment: attach)
            let attrStr = NSMutableAttributedString.init(string: self.titleStr)
            attrStr.insert(imageStr, at: 6)
            label.attributedText = attrStr
            break
        case 3:
            attach.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            let attrStr = NSMutableAttributedString.init(string: self.titleStr)
            label.attributedText = attrStr
            break
        case 4:
            // wrapper n. 包装材料；[包装] 包装纸；书皮
            let filewrapper = FileWrapper.init(symbolicLinkWithDestinationURL: URL.init(string: "www.baidu.com")!)
            attach.fileWrapper = filewrapper
            attach.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
            let attrStr = NSMutableAttributedString.init(string: self.titleStr)
            label.attributedText = attrStr
        default:
            break
        }
        
        
    }
}
extension AttachmentViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attachArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        cell?.textLabel?.text = self.attachArray[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension AttachmentViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(index: indexPath.row)
    }
}
