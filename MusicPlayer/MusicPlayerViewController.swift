//
//  MusicPlayerViewController.swift
//  MusicPlayer
//
//  Created by Janarthan Subburaj on 28/12/20.
//

import UIKit
import AVFoundation

class MusicPlayerViewController: UIViewController {

   
    @IBOutlet var PlaceHold: UIView!
    var Position:Int = 0
    var songs:[Song] =  []
    var player:AVAudioPlayer?
    
    private let MusicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleNameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    private let artistNameLabel: UILabel = {
        let artistName = UILabel()
        artistName.textAlignment = .center
        artistName.numberOfLines = 0
        return artistName
    }()
    
    private let albumNameLabel: UILabel = {
        let albumName = UILabel()
        albumName.textAlignment = .center
        albumName.numberOfLines = 0
        return albumName
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if PlaceHold.subviews.count == 0{
            PlayerPlayConfig()
        }
    }
    func PlayerPlayConfig(){
        let Song = songs[Position]
        let URL_String = Bundle.main.path(forResource: Song.TrackName, ofType: ".mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard URL_String == URL_String else{return}
            player = try AVAudioPlayer(contentsOf: URL(string: URL_String!)!)
            guard player == player else {
                return
            }
            player!.play()
        }
        catch{
            print("Error Occur")
        }
        MusicImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: PlaceHold.frame.size.width-20,
                                      height: PlaceHold.frame.size.width-20)
        MusicImageView.image = UIImage(named: Song.ImageName)
        PlaceHold.addSubview(MusicImageView)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let player = player{
            player.stop()
        }
    }
}
