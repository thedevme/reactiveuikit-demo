//
//  SecondViewController.swift
//  ReactiveKitDemo
//
//  Created by Craig Clayton on 7/19/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit

class TableExampleController: UIViewController {
    
    var arrData = CollectionProperty<[String]>([])
    var count = 0
    let textCellIdentifier = "TextCell"
 
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTimer()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        tableView.rDataSource.forwardTo = self
        
        arrData.bindTo(tableView) { [weak self] indexPath, dataSource, collectionView in
            guard let weakSelf = self else { return UITableViewCell() }
            
            let cell = weakSelf.tableView.dequeueReusableCellWithIdentifier(weakSelf.textCellIdentifier, forIndexPath: indexPath)
            let row = indexPath.row
            cell.textLabel?.text = weakSelf.arrData[row]
            
            return cell
        }
    }
    
    func createTimer() {
        let timer = NSTimer(timeInterval: 3, target: self, selector: #selector(BasicExampleController.updateData), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func updateData() {
        let data = ["Cam Newton", "Tom Brady", "J. J. Watt", "Antonio Brown", "Adrian Peterson", "Aaron Rodgers", "Luke Kuechly", "Julio Jones", "Rob Gronkowski", "Odell Beckham Jr.", "Josh Norman", "Carson Palmer", "Khalil Mack", "Aaron Donald", "Von Miller", "A.J. Green", "Russell Wilson", "Patrick Peterson", "DeAndre Hopkins", "Richard Sherman", "", "", "", "", "", "", "", ""]
    
        if count < data.count { arrData.append(data[count]) }
        count += 1
    }
}

