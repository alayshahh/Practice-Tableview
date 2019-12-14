//
//  ViewController.swift
//  Practice
//
//  Created by Alay Shah on 12/6/19.
//  Copyright © 2019 Alay Shah. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    let tableView = UITableView()
    let cellID = "CELLID"
    var twoDNames =  [
        ExpandableNames(isExpanded: true, names: [Contact(isFavorited: false, name:"Alay"), Contact(isFavorited: false, name:"Bill"), Contact(isFavorited: false, name:"Zack"),Contact(isFavorited: false, name:"Steve"), Contact(isFavorited: false, name:"Jack")]),
        ExpandableNames(isExpanded: true, names: [Contact(isFavorited: false, name:"Bob"), Contact(isFavorited: false, name:"John"), Contact(isFavorited: false, name:"Anoop"), Contact(isFavorited: false, name:"Ars"), Contact(isFavorited: false, name:"Pintu"), Contact(isFavorited: false, name:"Bhailu")]),
        ExpandableNames(isExpanded: true, names:  [Contact(isFavorited: false, name:"Xteve") ,Contact(isFavorited: false, name:"Wangu")]),
        ExpandableNames(isExpanded: true, names: [Contact(isFavorited: false, name:"Alay"), Contact(isFavorited: false, name:"Bill"), Contact(isFavorited: false, name:"Zack"),Contact(isFavorited: false, name:"Steve"), Contact(isFavorited: false, name:"Jack")])
    ]
    
    private func fetchContacts(){
        let store = CNContactStore()
        store.requestAccess(for: <#T##CNEntityType#>, completionHandler: <#T##(Bool, Error?) -> Void#>)
    }
    var showIndexPaths = false
   
    
    func favorited( cell: UITableViewCell){
        let indexPathC = tableView.indexPath(for: cell)
        let contact = twoDNames[indexPathC!.section].names[indexPathC!.row]
        let hasFavorited = contact.isFavorited
        twoDNames[indexPathC!.section].names[indexPathC!.row].isFavorited = !hasFavorited
        tableView.reloadRows(at: [indexPathC!], with: .fade)
    }
    
    
    
    
    @objc func handleShowIndexPath() {
        print("Attempting to load index path animation ...")
        var indexPathsToReload = [IndexPath]()
        for inx in twoDNames.indices{
            if !twoDNames[inx].isExpanded{
                continue
            }
            for index in twoDNames[inx].names.indices{
                let indexPath = IndexPath(row:index, section: inx)
                indexPathsToReload.append(indexPath)
            }
        }
        showIndexPaths = !showIndexPaths
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.left : .right
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchContacts()
        navigationItem.title="Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellID)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Index Path", style: .plain, target: self, action: #selector(handleShowIndexPath))
        // Do any additional setup after loading the view.
    }
    func setUpTableView (){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( twoDNames[section].isExpanded){
            return twoDNames[section].names.count
        } else{ return 0
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ContactCell
        cell.link = self
        let name = twoDNames[indexPath.section].names[indexPath.row].name
        cell.accessoryView?.tintColor = twoDNames[indexPath.section].names[indexPath.row].isFavorited ? UIColor.systemYellow : UIColor.gray
        cell.textLabel?.text = showIndexPaths ? "\(name) Section:\(indexPath.section) Row:\(indexPath.row)" : name
        return cell
       }
    
    
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return twoDNames.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Collapse", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.tag = section
        button.addTarget(self, action: #selector(closeHeaders), for: .touchUpInside)
        return button
        
    }
    @objc func closeHeaders (button: UIButton){
        print("Closing Header")
        var iP = [IndexPath]()
        for inx in twoDNames[button.tag].names.indices{
            let indexPath = IndexPath(row: inx, section: button.tag)
            iP.append(indexPath)
        }
        twoDNames[button.tag].isExpanded = !twoDNames[button.tag].isExpanded;
        button.setTitle(twoDNames[button.tag].isExpanded ? "Collapse":"Expand" , for: .normal)
        if (twoDNames[button.tag].isExpanded){
            tableView.insertRows(at: iP, with: .fade)
            
        }else{
            tableView.deleteRows(at: iP, with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
       

}

