//
//  SizeViewController.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

enum Size: Int {
    case gb16
    case gb32
    case gb64
    case gb128
}

class SizeViewController: RoutableViewController<Size> {

    init(color: Color) {
        super.init()
        tableView.backgroundColor = color.UIColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(Size)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(Size(rawValue: (indexPath as NSIndexPath).row)!)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !finish(Size(rawValue: (indexPath as NSIndexPath).row)!, output: Size(rawValue: (indexPath as NSIndexPath).row)!) {
            print("\(Size(rawValue: (indexPath as NSIndexPath).row)!)")
        }
    }
    
}
