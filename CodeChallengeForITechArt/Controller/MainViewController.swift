//
//  MainViewController.swift
//  CodeChallengeForITechArt
//
//  Created by Vlad Novik on 11/21/20.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var networkManager  = NetworkManager()
    var dataModelArray: [TransferedDataModel] = []
    var numberOfPage = 0
    
    private func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spiner = UIActivityIndicatorView()
        spiner.center = footerView.center
        footerView.addSubview(spiner)
        spiner.startAnimating()
        
        return footerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.networkManager.fetch(page: numberOfPage) { (transferedModelArray) in
            DispatchQueue.main.async {
                self.dataModelArray = transferedModelArray
                self.tableView.reloadData()
            }
        }

    }
}

//MARK: - UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        guard networkManager.controlNetworkResponse else { return }
        if position > (tableView.contentSize.height-100-scrollView.frame.size.height) {
            guard !networkManager.isPaginating else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.tableFooterView = nil
            }
            self.tableView.tableFooterView = createSpinerFooter()
            numberOfPage += 1
            networkManager.fetch(pagination: true, page: numberOfPage) { (transferedModelArray) in
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                    for element in transferedModelArray {
                        self.dataModelArray.append(element)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.mainCell, for: indexPath) as! MainTableViewCell
        cell.nameLabel.text = self.dataModelArray[indexPath.row].login
        cell.dateLabel.text = self.dataModelArray[indexPath.row].dateForCell
        dataModelArray[indexPath.row].getAvatarImage(completion: { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                cell.imageView?.image = image
            }
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.toInfoVCSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! InfoViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.infoArray = dataModelArray[indexPath.row]
        }
    }
}

