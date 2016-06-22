//
//  TableViewController.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 22.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

public class Box<T> {
    public let unbox: T
    public init(_ value: T) { self.unbox = value }
}

class TableViewController: UITableViewController {

    var items: NSArray = []
    var callback: AnyObject -> Void = { _ in }
    var configureCell: (UITableViewCell, AnyObject) -> UITableViewCell = { $0.0 }

    override func viewDidLoad() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return configureCell(tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath), items[indexPath.row])
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        callback(items[indexPath.row])
    }
    
}

extension TableViewController {

    static func tableViewController<A>(render: (UITableViewCell, A) -> UITableViewCell) -> Screen<[A], A> {
        return Screen<[A], A>(create: { (items: [A], callback: A -> Void) -> UIViewController in
            let myTableViewController = TableViewController()
            myTableViewController.items = items.map { item in
                Box(item)
            }
            myTableViewController.configureCell = { cell, obj in
                if let boxed = obj as? Box<A> {
                    return render(cell, boxed.unbox)
                }
                return cell
            }
            myTableViewController.callback = { x in
                if let boxed = x as? Box<A> {
                    callback(boxed.unbox)
                }
            }
            return myTableViewController
        })
    }

}
