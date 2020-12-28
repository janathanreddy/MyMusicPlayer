//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Janarthan Subburaj on 28/12/20.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var songs = [Song]()
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumMusic()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
    }

    func AlbumMusic(){
        songs.append(Song(Name: "AalaiyamDevan", AlbumName: "Christian", ArtistName: "Artist 1", ImageName: "mp3image1", TrackName: "AalaiyamDevan"))
        songs.append(Song(Name: "AandavaPrasannam", AlbumName: "Christian", ArtistName: "Artist 2", ImageName: "mp3image2", TrackName: "AandavaPrasannam"))
        songs.append(Song(Name: "AmenAlleluyaAaseervadham", AlbumName: "Christian", ArtistName: "Artist 3", ImageName: "mp3image3", TrackName: "AmenAlleluyaAaseervadham"))
        songs.append(Song(Name: "AalaiyamDevan", AlbumName: "Christian", ArtistName: "Artist 4", ImageName: "mp3image4", TrackName: "TamilJesusSongs-AalaiyamDevan"))
        songs.append(Song(Name: "AandavaPrasannam", AlbumName: "Christian", ArtistName: "Artist 5", ImageName: "mp3image5", TrackName: "TamilJesusSongs-AandavaPrasannam"))
        songs.append(Song(Name: "AathumamaeEn", AlbumName: "Christian", ArtistName: "Artist 6", ImageName: "mp3image6", TrackName: "TamilJesusSongs-AathumamaeEn"))
        songs.append(Song(Name: "AbrahamDevan", AlbumName: "Christian", ArtistName: "Artist 7", ImageName: "mp3image7", TrackName: "TamilJesusSongs-AalaiyamDevan"))
        songs.append(Song(Name: "AlelooyaGeedham", AlbumName: "Christian", ArtistName: "Artist 8", ImageName: "mp3image8", TrackName: "TamilJesusSongs-AlelooyaGeedham"))
        songs.append(Song(Name: "AnandhamaeJayaJaya", AlbumName: "Christian", ArtistName: "Artist 9", ImageName: "mp3image9", TrackName: "TamilJesusSongs-AnandhamaeJayaJaya"))
        songs.append(Song(Name: "EnDevanae", AlbumName: "Christian", ArtistName: "Artist 10", ImageName: "mp3image4", TrackName: "TamilJesusSongs-EnDevanae"))
        songs.append(Song(Name: "Illaram", AlbumName: "Christian", ArtistName: "Artist 11", ImageName: "mp3image2", TrackName: "TamilJesusSongs-Illaram"))


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MusicCell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell
        MusicCell.MusicName?.text = songs[indexPath.row].Name
        MusicCell.MusicName?.font = UIFont(name: "Helvetica-Bold", size: 18)
        MusicCell.MusicAlbumName?.text = songs[indexPath.row].AlbumName

        MusicCell.AlbumImage?.image = UIImage(named: songs[indexPath.row].ImageName)
        MusicCell.AlbumImage?.layer.masksToBounds = true
        MusicCell.AlbumImage?.layer.borderWidth = 0.5

        return MusicCell
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var Position = indexPath.row
        guard let VC = storyboard?.instantiateViewController(identifier: "Player") as? MusicPlayerViewController else{
            return
        }
        VC.Position = Position
        VC.songs = songs
        present(VC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
