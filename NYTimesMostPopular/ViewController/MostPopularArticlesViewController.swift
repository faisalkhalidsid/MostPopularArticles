//
//  ViewController.swift
//  NYTimesMostPopular
//
//  Created by faisal khalid on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import UIKit

class MostPopularArticlesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mostPopularArticles:[Article] = []
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mostPopularArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       var cell = tableView.dequeueReusableCell(withIdentifier: "mostpopulararticlecell") as! MostPopularArticleTableViewCell
        
        cell.selectionStyle = .none
        let row = indexPath.row
        cell.abstract.text = mostPopularArticles[row].abstract
        cell.title.text = mostPopularArticles[row].title
        cell.thumbnail.image = nil

        if mostPopularArticles[row].media.count > 0 {
            if mostPopularArticles[row].media[0].mediaMetadata.count > 0 {
                let url = URL(string: mostPopularArticles[row].media[0].mediaMetadata[0].url)
                let data = try? Data(contentsOf: url!)
                cell.thumbnail.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var row = indexPath.row
        var controller = self.storyboard?.instantiateViewController(withIdentifier: "articledetailcontroller") as! ArticleDetailViewController
        controller.article = mostPopularArticles[row]
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: false)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addPullToRefresh()
        loadAndDisplayMostPopularArticles()
    
    }
    
    @objc func loadAndDisplayMostPopularArticles()  {
        print("pulled")
        
        var client = NYTimesWebClient()
        startAnimatingLoadingIndicator()

        tableview.refreshControl?.endRefreshing()
        
        client.getMostPopularArticles(section: MostPopularSectionType.allSections.rawValue, noOfDays: 1) {error,articles in
            
            self.stopAnimatingLoadingIndicator()
            
            if let error = error {
                self.displayError(error: error)
            }
            
            if let articles = articles {
                self.mostPopularArticles = articles
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                    
                }
            }
            
        }
    }
    
    func startAnimatingLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopAnimatingLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func addPullToRefresh(){
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
           self.tableview.refreshControl = refreshControl
        } else {
            self.tableview.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(loadAndDisplayMostPopularArticles), for: .valueChanged)

        
    }
    
    func displayError(error:Error){
        var alert = UIAlertController(title: "Error Occured", message: error.localizedDescription, preferredStyle: .alert)
        var ok = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }

}


