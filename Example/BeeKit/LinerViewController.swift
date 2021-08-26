//
//  LinerViewController.swift
//  BeeKit
//
//  Created by liuxc123 on 08/25/2021.
//  Copyright (c) 2021 liuxc123. All rights reserved.
//

import UIKit
import BeeKit_Swift
import SnapKit

class LinerViewController: UIViewController {

    lazy var linearView = LinearView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LinerView"
        self.view.backgroundColor = .white
        
        setup()
        setupViews()
    }

    private func setup() {
        view.addSubview(linearView)
        linearView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        linearView.layer.shadowOffset = .zero
        linearView.layer.shadowRadius = 20
        linearView.layer.shadowOpacity = 0.2
        
        linearView.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.center.equalToSuperview()
        }
    }
    
    private func setupViews() {
        let a = UIView()
        a.backgroundColor = #colorLiteral(red: 0.1607843137, green: 0.2039215686, blue: 0.3843137255, alpha: 1)
        
        a.snp.makeConstraints { (make) in
            make.height.equalTo(20)
        }
        
        let b = UIView()
        b.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.3960784314, blue: 0.5137254902, alpha: 1)
        
        b.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        let c = UIView()
        c.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.3843137255, blue: 0.3843137255, alpha: 1)
        
        c.snp.makeConstraints { (make) in
            make.height.equalTo(80)
        }
        
        let d = UIView()
        d.backgroundColor = #colorLiteral(red: 1, green: 0.9450980392, blue: 0.7568627451, alpha: 1)
        
        d.snp.makeConstraints { (make) in
            make.height.equalTo(160)
        }
        
        linearView.layout(.vertical)
        .view(a)
        .spacing(10)
        .view(b)
        .spacing(20, mode: .follow) // 设置为跟随模式 间距将跟随临近的视图显示与隐藏
        .view(c)
        .spacing(30)
        .view(d)
        .spacing(10)
        .done()
        
        // 模拟某视图隐藏
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            UIView.animate(withDuration: 2) {
                c.isHidden = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                UIView.animate(withDuration: 2) {
                    c.isHidden = false
                }
            }
        }
    }
    

}

extension LinerViewController {
    
    @objc class func catalogBreadcrumbs() -> [String] {
        return ["LinerView"]
    }
    
}
