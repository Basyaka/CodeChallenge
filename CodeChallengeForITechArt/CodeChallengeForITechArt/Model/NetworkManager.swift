//
//  NetworkManager.swift
//  CodeChallengeForITechArt
//
//  Created by Vlad Novik on 11/21/20.
//

import Foundation

class NetworkManager {
    
    var isPaginating = false
    var controlNetworkResponse = true
    
    func fetch(pagination: Bool = false, page: Int, completionHandler: @escaping ([TransferedDataModel]) -> Void) {
        if pagination {
            isPaginating = true
        }
        let urlString = "https://api.github.com/events?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if let data = data {
                if let transferedData = self.parseJSON(withData: data) {
                    completionHandler(transferedData)
                    if pagination {
                        self.isPaginating = false
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> [TransferedDataModel]? {
        var viewControllerDataModelArray: [TransferedDataModel] = []
        do {
            let jsonNetworkData = try JSONDecoder().decode([PersonElement].self, from: data)
            for jsonNetworkElement in jsonNetworkData {
                guard let transferedData = TransferedDataModel(PersonElement: jsonNetworkElement) else {
                    return nil
                }
                viewControllerDataModelArray.append(transferedData)
            }
            return viewControllerDataModelArray
        } catch {
            controlNetworkResponse = false
        }
        return nil
    }
    
}
