//
//  ViewController.swift
//  NASADemo
//
//  Created by Герман on 17.09.21.
//
import youtube_ios_player_helper
import UIKit

class ViewController: UIViewController, AstronomyViewModelDelegate{
    
    
    
    @IBOutlet weak var labelData: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var player: YTPlayerView!
    
    var astronomyModel : AstronomyViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        astronomyModel = AstronomyViewModel(delegate: self)
    
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        
        player.layer.masksToBounds = true
        player.layer.cornerRadius = 10
        
        astronomyModel?.getAstronomyPictureOfTheDay()
        
        reloadData()

    }

    func reloadData(){
        labelData.text = astronomyModel?.getDate()
        labelTitle.text = astronomyModel?.getTitleOfMedia()
        textView.text = astronomyModel?.getDescription()
        
        guard let textTypeOfMedia = astronomyModel?.getMediaType() else {return}
        
        
        if textTypeOfMedia == "video"{
            player.isHidden = false
            player.load(withVideoId: (astronomyModel?.getUrlContent()?.youtubeID)!)
            
        } else if textTypeOfMedia == "image"{
            image.isHidden = false
            image.image = astronomyModel?.getImage()
        }
    }
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: "404", preferredStyle: .alert)
        let buttonOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(buttonOk)
        present(alert, animated: true, completion: nil)
    }

}

extension String {
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"

        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)

        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }

        return (self as NSString).substring(with: result.range)
    }
}

