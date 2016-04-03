//
//  MoreUIViewController.swift
//  Babylonian
//
//  Created by Ted on 2016/3/17.
//  Copyright © 2016年 Eric Smith. All rights reserved.
//


import UIKit

class MoreUIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlet Properties
    @IBOutlet weak var tblExpandable: UITableView!
    
    
    // MARK: Variables
    
    let sections = ["Account", "Privacy"]
    
    let items = [["Display Name", "Profile Photo", "E-mail", "Password"],
                 ["Show Location", "Connected to FB", "Connected to Twitter"]
                ]
    let cellIdentifier = "tableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureTableView()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTableView() {
        tblExpandable.delegate = self
        tblExpandable.dataSource = self
        //tblExpandable.tableFooterView = UIView(frame: CGRectZero)
        
        tblExpandable.registerNib(UINib(nibName: "LabelCell", bundle: nil), forCellReuseIdentifier: "idLabelCell")
        tblExpandable.registerNib(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        tblExpandable.registerNib(UINib(nibName: "TextfieldCell", bundle: nil), forCellReuseIdentifier: "idCellTextfield")
        tblExpandable.registerNib(UINib(nibName: "DatePickerCell", bundle: nil), forCellReuseIdentifier: "idCellDatePicker")
        tblExpandable.registerNib(UINib(nibName: "SwitchCell", bundle: nil), forCellReuseIdentifier: "idCellSwitch")
        tblExpandable.registerNib(UINib(nibName: "ValuePickerCell", bundle: nil), forCellReuseIdentifier: "idCellValuePicker")
        tblExpandable.registerNib(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "idCellSlider")
    }
    
    // MARK: UITableView Delegate and Datasource Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("idLabelCell", forIndexPath: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 50.0
    }
    
    /*
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }*/
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ts", sender: self)
    }
    
    @IBAction func logoutPressed(sender: AnyObject) {
        DataService.dataService.BASE_REF.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
    }
}


