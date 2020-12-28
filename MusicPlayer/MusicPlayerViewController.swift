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
    let PlayerPauseButton = UIButton()
    let NextButton = UIButton()
    let BackButton = UIButton()

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
            player?.volume = 0.5
            player!.play()
        }
        catch{
            print("Error Occur")
        }
        MusicImageView.frame = CGRect(x: 10,
                                      y: 20,
                                      width: PlaceHold.frame.size.width-20,
                                      height: PlaceHold.frame.size.width-20)
        MusicImageView.image = UIImage(named: Song.ImageName)
        PlaceHold.addSubview(MusicImageView)
        titleNameLabel.frame = CGRect(x: 10,
                                      y: MusicImageView.frame.size.height + 10 ,
                                      width: PlaceHold.frame.size.width-20,
                                      height: 70)
        
        artistNameLabel.frame = CGRect(x: 10,
                                      y:  MusicImageView.frame.size.height + 10 + 70,
                                      width: PlaceHold.frame.size.width-20,
                                      height: 70)
        
        albumNameLabel.frame = CGRect(x: 10,
                                      y: MusicImageView.frame.size.height + 10 + 140,
                                      width: PlaceHold.frame.size.width-20,
                                      height: 70)
        titleNameLabel.font = UIFont(name: "Helvetica-Bold", size: 18)
        titleNameLabel.text = Song.Name
        artistNameLabel.font = UIFont(name: "Helvetica", size: 16)
        artistNameLabel.text = Song.ArtistName
        albumNameLabel.font = UIFont(name: "Helvetica", size: 14)
        albumNameLabel.alpha = 0.7
        albumNameLabel.text = Song.AlbumName
        
        PlaceHold.addSubview(titleNameLabel)
        PlaceHold.addSubview(artistNameLabel)
        PlaceHold.addSubview(albumNameLabel)
        
        
        let yPosition = artistNameLabel.frame.origin.y + 140 + 40
        let Size:CGFloat = 40
        
        PlayerPauseButton.frame = CGRect(x: (PlaceHold.frame.size.width - Size) / 2.0, y: yPosition, width: Size, height: Size)
        NextButton.frame = CGRect(x: PlaceHold.frame.size.width - Size - 20, y: yPosition, width: Size, height: Size)
        BackButton.frame = CGRect(x: 20, y: yPosition, width: Size, height: Size)

        
        PlayerPauseButton.addTarget(self, action: #selector(DidPlayPauseButtonTapped), for: .touchUpInside)
        NextButton.addTarget(self, action: #selector(DidNextButtonTapped), for: .touchUpInside)
        BackButton.addTarget(self, action: #selector(DidBackButtonTapped), for: .touchUpInside)

        
        PlayerPauseButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        NextButton.setBackgroundImage(UIImage(systemName: "forward"), for: .normal)
        BackButton.setBackgroundImage(UIImage(systemName: "backward"), for: .normal)

        PlayerPauseButton.tintColor = .black
        NextButton.tintColor = .black
        BackButton.tintColor = .black
        
        PlaceHold.addSubview(PlayerPauseButton)
        PlaceHold.addSubview(NextButton)
        PlaceHold.addSubview(BackButton)


        let Slider = UISlider(frame: CGRect(x: 20,
                                            y: PlaceHold.frame.size.height-60,
                                            width: PlaceHold.frame.size.width-40,
                                            height: 50))
        Slider.value = 0.5
        Slider.addTarget(self, action: #selector(MusicSlider(_:)), for: .valueChanged)
        PlaceHold.addSubview(Slider)

    }
    
    @objc func DidPlayPauseButtonTapped(){
        if player?.isPlaying == true{
            player?.pause()
            PlayerPauseButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.MusicImageView.frame = CGRect(x: 30, y: 30, width: self.PlaceHold.frame.size.width - 60, height: self.PlaceHold.frame.size.width - 60)
            })

        }else{
            player?.play()
            PlayerPauseButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.MusicImageView.frame = CGRect(x: 10, y: 10, width: self.PlaceHold.frame.size.width - 20, height: self.PlaceHold.frame.size.width - 20)
            })
        }
    }
    
    @objc func DidNextButtonTapped(){
        if Position <  (songs.count - 1){
            Position = Position + 1
            player?.stop()
            for subView in PlaceHold.subviews{
                subView.removeFromSuperview()
            }
            PlayerPlayConfig()
        }
    }
    
    @objc func DidBackButtonTapped(){
        if Position > 0{
            Position = Position - 1
            player?.stop()
            for subView in PlaceHold.subviews{
                subView.removeFromSuperview()
            }
            PlayerPlayConfig()
        }
    }
    
    @objc func MusicSlider(_ Slider:UISlider){
        let value = Slider.value
        player?.volume = value
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let player = player{
            player.stop()
        }
    }
}
