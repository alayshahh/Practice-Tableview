//
//  ContactCell.swift
//  Practice
//
//  Created by Alay Shah on 12/6/19.
//  Copyright © 2019 Alay Shah. All rights reserved.
//

import UIKit
class ContactCell: UITableViewCell{
    
    var link : ViewController?
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .systemTeal
        let starButton = UIButton(type: .system)
//        starButton.setTitle("SOME", for: .normal)
        starButton.setImage(UIImage.init(named: "staryello.png"), for: .normal)
        
        starButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        starButton.tintColor = .darkGray
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        accessoryView = starButton
    }
    @objc func handleMarkAsFavorite(){
        link?.favorited(cell: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

