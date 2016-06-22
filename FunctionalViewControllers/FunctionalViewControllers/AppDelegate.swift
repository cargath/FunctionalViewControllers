//
//  AppDelegate.swift
//  FunctionalViewControllers
//
//  Created by Carsten Könemann on 20.06.16.
//  Copyright © 2016 cargath. All rights reserved.
//

import UIKit

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

let chooseArtist: Screen<[Artist], Artist> = TableViewController.tableViewController { cell, artist in
    cell.textLabel!.text = artist.name
    return cell
}

let chooseAlbum: Screen<[Album], Album> = TableViewController.tableViewController { cell, album in
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
    case SpaceGrey(artists: [Artist])
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

let colors: [Color] = [.Silver(string: "Foobar"), .SpaceGrey(artists: artists), .Gold, .RoseGold]

let chooseColor: Screen<[Color], Color> = TableViewController.tableViewController { cell, color in
    cell.textLabel?.text = color.description
    return cell
}

let color2Other: Screen<Color, String> = Screen { (color: Color, callback: String -> Void) -> UIViewController in
    switch color {
        case let .Silver(string): return chooseColor.run(colors)
        case let .SpaceGrey(artists): return chooseArtist.run(artists)
        case .Gold: return ColorViewController(color: color)
        case .RoseGold: return ColorViewController(color: color)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        window?.rootViewController = Router(rootViewController: chooseColor)
            //.map({ $0.albums })
            //.bind(chooseAlbum)
            //.run(artists, finish: { print("Selected \($0.name)")})
            .bind(color2Other)
            .run(colors)

        window?.makeKeyAndVisible()

        return true
    }

}
