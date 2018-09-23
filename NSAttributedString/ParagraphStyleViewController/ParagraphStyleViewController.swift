//
//  ParagraphStyleViewController.swift
//  NSAttributedString
//
//  Created by frank.Zhang on 19/01/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class ParagraphStyleViewController: SuperViewController {

    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let paragraphStyleArray: [String] = ["lineSpacing:行间距","paragraphSpacing:段间距","alignment:对齐方式","firstLineHeadIndent:首行缩进","headIndent：整体缩进(首行除外)左边整体的缩进","tailIndent:尾缩进,右边整体的缩进","lineBreakMode:显示不完的时候省略方式","minimumLineHeight：最小行高","maximumLineHeight：最大行高","baseWritingDirection:书写方向","lineHeightMultiple：想要调整行距，可以透过搭配使用 lineHeightMultiple 更改行距倍数","paragraphSpacingBefore：段落头部空白","hyphenationFactor：启用断字功能","tabStops:制表符模式","defaultTabInterval：默认Tab宽度","allowsDefaultTighteningForTruncation：允许默认的收截断收紧功能","addTabStop:添加制表符"," removeTabStop：移除制表符","setParagraphStyle：设置分段落格式"]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        self.title = "BoldSystemFont"
        self.labelTop.constant = UIApplication.shared.statusBarFrame.height + 44
        initLabel()
        initTableView()
    }
    
    func initLabel(){
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: nil)
        label.attributedText = attrStr
    }
    
    func refreshLabel(index:Int){
        let style = NSMutableParagraphStyle.init()
        switch index {
        case 0: // 行间距
            style.lineSpacing = 20.0
            break
        case 1:// 段落间距
            style.paragraphSpacing = 20.0
            break
        case 2:// 文字水平居左居中居右
            style.alignment = .right
            break
        case 3:// 首行缩进距离
            style.firstLineHeadIndent = 20.0
            break
        case 4: // 除首行不缩进外，别的行都缩进，这个值是别的行缩进的距离
            style.headIndent = 20.0
            break
        case 5: // 尾缩进，右边整体缩进的距离，模拟器的显示好像有问题
            style.tailIndent = 10.0
            break
        case 6: // 换行模式
            style.lineBreakMode = .byWordWrapping
            break
        case 7: // 最小的行高
            style.minimumLineHeight = 10
            break
        case 8: // 最大行高
            style.maximumLineHeight = 20
            break
        case 9: // 书写方向，这个实在是看着难受啊
            style.baseWritingDirection = .rightToLeft
            break
        case 10: // 行间距倍数
            style.lineHeightMultiple = 3.0
            break
        case 11: // 段部top处的空白距离
            style.paragraphSpacingBefore = 20.0
            break
            /*
             n. 因素；要素；[物] 因数；代理人
             vi. 做代理商
             vt. 把…作为因素计入；代理经营；把…分解成
             断字参数，没看出影响
             */
        case 12: // hyphenation n. 用连字符号连接；断字； Factor：
            style.hyphenationFactor = 20.0
            break
        case 13: // 制表符模式；没看出什么不一样的地方
            let decimalTab = NSTextTab.init(textAlignment: .right, location: 5, options: [:])
            let percentTab = NSTextTab.init(textAlignment: .left, location: 20, options: [:])
            style.tabStops = [decimalTab,percentTab]
            break
        case 14: // 默认制表符宽度
            style.defaultTabInterval = .infinity*2
            break
        case 15: // 允许默认的 收紧截断功能
            style.allowsDefaultTighteningForTruncation = true
            break
        case 16: // 添加一个制表符；模拟器没有效果
            let decimalTab = NSTextTab.init(textAlignment: .right, location: 5, options: [:])
            style.addTabStop(decimalTab)
            break
        case 17: //
            let decimalTab = NSTextTab.init(textAlignment: .right, location: 5, options: [:])
            style.removeTabStop(decimalTab)
            break
        case 18: // 设置行间距
            let newStyle = NSMutableParagraphStyle.init()
            newStyle.lineSpacing = 30
            style.setParagraphStyle(newStyle)
            break
        default:
            break
        }
        let dict = [NSAttributedStringKey.paragraphStyle:style]
        let attrStr = NSMutableAttributedString.init(string: self.titleStr, attributes: dict)
        label.attributedText = attrStr
    }
    func initTableView(){
        hildTableViewExtraCellLineHidden(tableView: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ParagraphStyleViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paragraphStyleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style:.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 2.0))
        cell?.textLabel?.text = self.paragraphStyleArray[indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
}

extension ParagraphStyleViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshLabel(index:indexPath.row)
    }
}


