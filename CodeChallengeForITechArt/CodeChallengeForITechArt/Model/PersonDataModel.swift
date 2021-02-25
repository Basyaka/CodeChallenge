//
//  JSONDataModel.swift
//  CodeChallengeForITechArt
//
//  Created by Vlad Novik on 11/21/20.
//

import Foundation

struct PersonElement: Codable {
    let id: String
    let actor: Actor
    let createdAt: String
    let repo: Repo
    
    enum CodingKeys: String, CodingKey {
        case actor, repo, id
        case createdAt = "created_at"
    }
}

struct Repo: Codable {
    let name: String
    let url: String
}

struct Actor: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

