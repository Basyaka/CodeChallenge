//
//  InfoViewController.swift
//  CodeChallengeForITechArt
//
//  Created by Vlad Novik on 11/21/20.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var avatarImageLabel: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var infoArray: TransferedDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.loadInfo()
        }
    }
    
    private func loadInfo() {
        avatarImageLabel.image = infoArray?.avatarImage
        idLabel.text = infoArray?.id
        loginLabel.text = infoArray?.login
        nameLabel.text = infoArray?.name
        dateLabel.text = infoArray?.dateForInfo
        urlLabel.text = infoArray?.url
    }
}
