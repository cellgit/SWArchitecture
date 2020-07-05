//
//  HotkeyCell.swift
//  SWArchitecture
//
//  Created by Alan on 2019/9/20.
//  Copyright © 2019 liuhongli. All rights reserved.
//

import UIKit

class HotkeyCell: UITableViewCell {
    let radius: CGFloat = 5
    
    open var model = HotkeyModel() {
        didSet {
            self.titleLabel.text = model.hotkey
            self.subtitleLabel.text = model.function
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        if self.traitCollection.userInterfaceStyle == .dark {
            // User Interface is Dark
            containerView.backgroundColor = .secondarySystemBackground
        } else {
            // User Interface is Light
            containerView.backgroundColor = .white
        }
        
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = false   // true, 有圆角没阴影, false有圆角有阴影
        let sColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)  // 和table背景色一致,看不出阴影,可换成其它颜色
//        let sColor = UIColor.magenta
        let size1 = CGSize(width: 0, height: 0)
        self.setShadow(view: containerView, sColor: sColor, offset: size1, opacity: 0.08, radius: radius)
    }
    
}

extension HotkeyCell {
    func setShadow(view: UIView,
                   sColor: UIColor,
                   offset: CGSize,
                   opacity:Float,
                   radius:CGFloat) {
        //设置阴影颜色
        view.layer.shadowColor = sColor.cgColor
        //设置透明度
        view.layer.shadowOpacity = opacity
        //设置阴影半径
        view.layer.shadowRadius = radius
        //设置阴影偏移量
        view.layer.shadowOffset = offset
    }
}
