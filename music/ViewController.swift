//
//  ViewController.swift
//  music
//
//  Created by ev_mac18 on 13/04/18.
//  Copyright © 2018 ev_mac18. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController {
    let song = [MPMediaItem]()//
    let myMediaQuery = MPMediaQuery.songs()
    let mp = MPMusicPlayerController.systemMusicPlayer//systemMusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(_ sender: Any) {
        mp.play()
    }
    
    @IBAction func stop(_ sender: Any) {
        mp.pause()
    }
}

