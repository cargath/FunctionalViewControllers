//
//  AppDelegate.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 20.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

func tableViewController<A>(render: (UITableViewCell, A) -> UITableViewCell) -> ViewController<[A], A> {

    return ViewController(create: { (items: [A], callback: A -> ()) -> UIViewController in
        let myTableViewController = MyViewController()
        myTableViewController.items = items.map { Box($0) }
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

class MyViewController: UITableViewController {

    var items: NSArray = []
    var callback: AnyObject -> () = { _ in () }
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

/*
class MyViewController: UIViewController {

    override func viewDidLoad() {
        navigationController?.toolbarHidden = false
        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "S", style: .Plain, target: self, action: #selector(MyViewController.silver)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "G", style: .Plain, target: self, action: #selector(MyViewController.gold)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "SG", style: .Plain, target: self, action: #selector(MyViewController.spaceGrey)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "RG", style: .Plain, target: self, action: #selector(MyViewController.roseGold)),
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        ]
    }

    func silver() {

    }

    func gold() {

    }

    func spaceGrey() {

    }

    func roseGold() {

    }

}
*/

struct Album {
    let name: String
}

struct Artist {
    let name : String
    let additionalInformation : String
    let albums: [Album]
}

let artists : [Artist] = [
    Artist(name: "JS Bach", additionalInformation: "Some more info", albums: [Album(name: "The Art of Fugue")]),
    Artist(name: "Simeon Ten Holt", additionalInformation: "Bla bla", albums: [])
]

let chooseArtist: ViewController<[Artist], Artist> = tableViewController { cell, artist in
    cell.textLabel!.text = artist.name
    return cell
}

let chooseAlbum: ViewController<[Album], Album> = tableViewController { cell, album in
    cell.textLabel?.text = album.name
    return cell
}


class ColorViewController: UIViewController {

    let color: Color

    init(color: Color) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("foobar")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color.UIColor
    }

}

enum Color {
    case Silver(string: String)
    case SpaceGrey(int: Int)
    case Gold
    case RoseGold
}

extension Color {
    var UIColor: UIKit.UIColor {
        switch self {
            case .Silver: return .lightGrayColor()
            case .SpaceGrey: return .darkGrayColor()
            case .Gold: return .yellowColor()
            case .RoseGold: return .redColor()
        }
    }
}

extension Color: CustomStringConvertible {
    var description: String {
        switch self {
            case .Silver: return "Silver"
            case .SpaceGrey: return "SpaceGrey"
            case .Gold: return "Gold"
            case .RoseGold: return "RoseGold"
        }
    }
}

let colors: [Color] = [.Silver(string: "Foobar"), .SpaceGrey(int: 42), .Gold, .RoseGold]

let chooseColor: ViewController<[Color], Color> = tableViewController { cell, color in
    cell.textLabel?.text = color.description
    return cell
}

let color2Other: ViewController<Color, String> = ViewController { (color: Color, callback: String -> Void) -> UIViewController in
    switch color {
        case let .Silver(string): return chooseColor.run(colors, finish: { print($0) })
        case let .SpaceGrey(int): return chooseArtist.run(artists, finish: { print($0) })
        case .Gold: return ColorViewController(color: color)
        case .RoseGold: return ColorViewController(color: color)
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        window?.rootViewController = NavigationController(rootViewController: chooseColor)
            //.map({ $0.albums })
            //.bind(chooseAlbum)
            //.run(artists, finish: { print("Selected \($0.name)")})
            .bind(color2Other)
            //.run(colors, finish: { print("Selected \($0.description)")})
            .run(colors, finish: { print($0) })

        window?.makeKeyAndVisible()

        return true
    }

}
