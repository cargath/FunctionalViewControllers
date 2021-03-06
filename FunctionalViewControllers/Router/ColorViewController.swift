//
//  ColorViewController.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 24.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

enum Color: Int {
    case silver
    case spaceGrey
    case gold
    case roseGold
}

extension Color {
    var UIColor: UIKit.UIColor {
        switch self {
            case .silver: return .lightGray()
            case .spaceGrey: return .darkGray()
            case .gold: return .yellow()
            case .roseGold: return .red()
        }
    }
}

class ColorViewController: RoutableViewController<Color> {

    override init() {
        super.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count(Color)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(Color(rawValue: (indexPath as NSIndexPath).row)!)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !finish(Color(rawValue: (indexPath as NSIndexPath).row)!, output: Color(rawValue: (indexPath as NSIndexPath).row)!) {
            print("\(Color(rawValue: (indexPath as NSIndexPath).row)!)")
        }
    }
    
}
