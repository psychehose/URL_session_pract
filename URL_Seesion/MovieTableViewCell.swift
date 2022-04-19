//
//  MovieTableViewCell.swift
//  URL_Seesion
//
//  Created by KIM HOSE on 2022/04/19.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  private let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = .gray
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Default TitleDDDDDDDDDDDDDD"
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = .black
    return label
  }()
  private let overviewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Default OverViewssssss"
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()
  
  var id: Int = .random(in: Int.min ... Int.max)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    makeUI()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MovieTableViewCell {
  private func makeUI() {
    contentView.addSubview(posterImageView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(overviewLabel)
    
    NSLayoutConstraint.activate([
      posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
      posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
      posterImageView.widthAnchor.constraint(equalToConstant: 80),
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),

      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
      titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),

      overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
      overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    ])
  }
  func bind(movie: Movie) {
    id = movie.id
    titleLabel.text = movie.title
    var prefixedString = movie.overview.prefix(60)
//    overviewLabel.text = movie.overview
    
    prefixedString.append(contentsOf: "...")
    
    
    overviewLabel.text = String(prefixedString)
  }
}
