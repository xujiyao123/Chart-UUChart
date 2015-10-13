//
//  ViewController.swift
//  ChartTest
//
//  Created by 徐继垚 on 15/10/12.
//  Copyright © 2015年 徐继垚. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    
    var tableView :UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 64))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        
        return 2
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
         cell.buildChart(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 30))
        label.font = UIFont.systemFontOfSize(17)
        label.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        if section == 0 {
            label.text = "折线图"
        }else {
            label.text = "柱状图"
        }
        label.textColor = UIColor.redColor()
        label.textAlignment = .Center
        return label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

