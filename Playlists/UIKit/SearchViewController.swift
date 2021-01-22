//
//  ViewController.swift
//  PlaylistsUIKit
//
//  Created by Kaleb Page on 12/17/20.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    
    var tableView = UITableView()
    var songs: [Song] = [] 
    //Song(name: "Say It Ain't So", artist: "Weezer", uiimage: UIImage(named: "weezer") ?? UIImage(), image: Image("AMV1"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        
        tableView.register(SongTableViewCell.self, forCellReuseIdentifier: "SongCell")
        view.addSubview(tableView)
    }
    
    
    //MARK: Table View Setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell") else {
            return UITableViewCell()
        }
        
         let song = songs[indexPath.row]
        
         cell.textLabel?.text = "\(song.attributes.artistName) - \(song.attributes.name)"
        
    
        return cell
    }
}

