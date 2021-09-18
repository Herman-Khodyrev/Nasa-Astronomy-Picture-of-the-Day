//
//  AstronomyViewModel.swift
//  NasaApiDemo
//
//  Created by Герман on 17.09.21.
//

import UIKit
import Foundation

protocol AstronomyViewModelDelegate: class{
    
    func reloadData()
    
    func showError(error: String)
    
}

class AstronomyViewModel{
    
    weak var delegate: AstronomyViewModelDelegate?
    
    private var astronomy: Astronomy?
    
    init(delegate: AstronomyViewModelDelegate){
        self.delegate = delegate
    }
    
    func getAstronomyPictureOfTheDay(){
        
        APIManager.shared.getContent{
            
            (astronomy, error) in
            
            if let error = error{
                self.delegate?.showError(error: error)
            } else if let astronomy = astronomy{
                self.astronomy = astronomy
                self.delegate?.reloadData()
            }
            
        }
        
    }
    
    func getDate() -> String?{
        return astronomy?.date ?? "Дата недоступна"
    }
    
    func getDescription() -> String? {
        return astronomy?.explanation ?? "Описание недоступно"
    }
    
    func getMediaType() -> String?{
        return astronomy?.media_type ?? "Медиа недоступно"
    }
    
    func getTitleOfMedia() -> String?{
        return astronomy?.title ?? "Контент недоступен"
    }
    
    func getUrlContent() -> String?{
        return astronomy?.url ?? ""
    }
    
    func getImage() -> UIImage?{
        
        guard let url = URL(string: getUrlContent() ?? "") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }
}
