//
//  ViewController.swift
//  Stock News App MVC
//
//  Created by Arda Çimen on 17.11.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
   


    @IBOutlet weak var table: UITableView!
    
    let apiUrl:String = "https://newsapi.org/v2/everything?q=stock&apiKey=05302349cd9b4dcab2ba859206d86377"
    
    var articles = Array<News>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        getRequest()

    }
    
    func getRequest(){
        
        let url = URL(string: self.apiUrl)
       
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){data, response, error in
                  guard let data = data else {
                      print("Request Error")
                      return }
                  do {
                      let news = try JSONDecoder().decode(Result.self, from: data)
                      self.articles = news.articles
                      DispatchQueue.main.async {
                          self.table.reloadData()
                          
                      }
                  } catch { print(error) }
              }
            
              task.resume()
              
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let article = articles[indexPath.row]
        
        cell.Author.text = article.author
        cell.Title.text = article.title
        cell.PublishDate.text = article.publishedAt
        
        
        return cell
    }
    //   UIApplication.shared.open(url)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let url = URL(string: article.url)!
        UIApplication.shared.open(url)
       }
       
    

   

}
