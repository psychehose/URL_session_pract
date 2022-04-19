//
//  ViewController.swift
//  URL_Seesion
//
//  Created by KIM HOSE on 2022/04/19.
//

import UIKit

final class ViewController: UIViewController {
  
  
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.separatorStyle = .none
    tableView.rowHeight = 80
    return tableView
  }()
  
  var movies: [Movie] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self

    view.addSubview(tableView)
    tableView.frame = self.view.bounds

    getMovieData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "Cell",
      for: indexPath
    ) as? MovieTableViewCell
    else {
      return UITableViewCell()
    }
    cell.bind(movie: movies[indexPath.row])
    return cell
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
}

extension ViewController {
  func getMovieData() {

    let session = URLSession(configuration: .default)

    guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=37db817227e219b1c4a33390ada3d6b5") else {
      return
    }

    let request = URLRequest(url: url)

    let task = session.dataTask(with: request) { data, response, error in
      
      guard error == nil else {
        debugPrint(error!)
        return
      }

      guard let response = response as? HTTPURLResponse,
            let data = data,
            200...299 ~= response.statusCode
      else {
        return
      }
      guard let movies = try? JSONDecoder().decode(MovieResposeDTO.self, from: data) else {
        return
      }

      self.movies = movies.results
    }
    task.resume()
  }
}

struct MovieResposeDTO: Decodable {
  let results: [Movie]
}

struct Movie: Decodable {
  let id: Int
  let title: String
  let posterPath: String
  let overview: String
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case posterPath = "poster_path"
    case overview
  }
}
