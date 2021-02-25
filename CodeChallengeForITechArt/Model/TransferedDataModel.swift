//
//  DataModel.swift
//  CodeChallengeForITechArt
//
//  Created by Vlad Novik on 11/21/20.
//

import UIKit

struct TransferedDataModel {
    let id: String
    let login: String
    let name: String
    let url: String
    private let createdAt: String
    private let avatarURL: String
    
    var dateForCell: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterSend = DateFormatter()
        dateFormatterSend.dateFormat = "MM/dd/yyyy"
        
        let date: Date = dateFormatterGet.date(from: createdAt)!
        return dateFormatterSend.string(from: date)
    }
    
    var dateForInfo: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterSend = DateFormatter()
        dateFormatterSend.dateFormat = "EEEE, MMM d, yyyy HH:mm"
        
        let date: Date = dateFormatterGet.date(from: createdAt)!
        return dateFormatterSend.string(from: date)
    }
    
    func getAvatarImage(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let url = URL(string: avatarURL)
            if let url = url {
                if let data = try? Data(contentsOf: url) {
                    completion(UIImage(data: data)!)
                }
            }
            completion(nil)
        }
    }
    
    var avatarImage: UIImage? {
        let url = URL(string: avatarURL)
        if let url = url {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    init?(PersonElement: PersonElement) {
        id = PersonElement.id
        createdAt = PersonElement.createdAt
        login = PersonElement.actor.login
        avatarURL = PersonElement.actor.avatarURL
        name = PersonElement.repo.name
        url = PersonElement.repo.url
    }
}
