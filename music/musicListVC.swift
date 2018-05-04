//
//  musicListVC.swift
//  music
//
//  Created by ev_mac18 on 14/04/18.
//  Copyright © 2018 ev_mac18. All rights reserved.
//

import UIKit
import MediaPlayer
class musicListVC: UITableViewController {
var musicListDict = NSMutableDictionary()
var mediaItemCollection = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        MPMediaLibrary.requestAuthorization({ (aurth) in
            print(aurth)
            let myPlaylistQuery = MPMediaQuery.playlists()
            let playlists = myPlaylistQuery.collections
            print(playlists)
            for playlist in playlists! {
                print(playlist.value(forProperty: MPMediaPlaylistPropertyName)!)
                
                let songList = NSMutableArray()
                let songs = playlist.items
                self.mediaItemCollection.add(songs)
                for song in songs {
                    let songTitle = song.value(forProperty: MPMediaItemPropertyTitle)
                    print("\t\t", songTitle!)
                    songList.add(song)
                }
                
                self.musicListDict.setValue(songList, forKey: playlist.value(forProperty: MPMediaPlaylistPropertyName)! as! String)
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (self.musicListDict.allKeys).count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let playList = (self.musicListDict.allKeys)[section] as! String
        let songList = self.musicListDict.value(forKey: playList) as! NSMutableArray
        return songList.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicHeaderCell") as!  MusicHeaderCell
        cell.playListLbl.text = (self.musicListDict.allKeys)[section] as! String
        return cell.contentView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicDetailCell", for: indexPath) as!  MusicDetailCell
        let playList = (self.musicListDict.allKeys)[indexPath.section] as! String
        let songList = self.musicListDict.value(forKey: playList) as! NSMutableArray
        cell.songTitleLbl.text = (songList[indexPath.row] as! MPMediaItem).value(forProperty: MPMediaItemPropertyTitle) as! String
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //ViewController.media = mediaItemCollection[indexPath.section]
        let playList = (self.musicListDict.allKeys)[indexPath.section] as! String
        let songList = self.musicListDict.value(forKey: playList) as! NSMutableArray
//        var playQueue = MPMediaItemCollection(items: self.mediaItemCollection[indexPath.section] as! [MPMediaItem])
//        let songs = playQueue.items // Get all songs
//        for sng in songs { // Look for song
//            if String(describing: sng.value(forProperty: MPMediaItemPropertyTitle)!) == (songList[indexPath.row] as! MPMediaItem).value(forProperty: MPMediaItemPropertyTitle) as! String { // If you found it
//                //MPMusicPlayerController.systemMusicPlayer().setQueue(with: sng) // Set it
//                viewController.mp.setQueue(with: sng)//setQueue(with: sng)
//                break
//            }
        
        //viewController.mp.setQueue(with: MPMediaItemCollection(items: self.mediaItemCollection[indexPath.section] as! [MPMediaItem]))
        viewController.mp.nowPlayingItem = songList[indexPath.row] as! MPMediaItem
        //setQueue(with: songList[indexPath.row] as! MPMediaItem)
        self.present(viewController, animated: true, completion: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
