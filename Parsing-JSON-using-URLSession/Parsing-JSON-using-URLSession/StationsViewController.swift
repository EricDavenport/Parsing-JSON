//
//  ViewController.swift
//  Parsing-JSON-using-URLSession
//
//  Created by Eric Davenport on 8/4/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit
import Combine

class StationsViewController: UIViewController {
  
  // TODO: use the "region-id" to create multiple sections
  // create enum to represent table view sections
  enum Section {
    case primary
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  private var dataSource: DataSource!   // subclass of UITableviewDiffable...source
  
  let apiClient = APIClient()
  
  private var subscriptions: Set<AnyCancellable> = []

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Citi Bike Stations"
    configureDataSource()
    fetchData()
  }
  
  private func fetchData() {
    // results type has two values
    // 1. .failure() or 2. .success()
    apiClient.fetchData { [weak self] (result) in
      switch result {
      case .failure(let appError):
        print(appError)
        // TODO: present an alert
      case .success(let stations):
        DispatchQueue.main.async {   // updating UI on the main thread
          self?.updateSnapshot(with: stations)
        }
      }
    }
  }
  
  // MARK: COMBINE
//  private func fetchDataUsingCombine() {
//    /*
//     .sink -> recieves values
//     .assign -> binds a value of a property or UI element
//     */
//    do {
//      let publisher = try apiClient.fetchData()
//        .sink(receiveCompletion: { (completion) in
//          print(completion)
//        }, receiveValue: { [weak self] (stations) in
//          self?.updateSnapshot(with: stations)
//        })
//      .store(in: &subscriptions)
//    } catch {
//      print(error)
//    }
//  }
  
  private func updateSnapshot(with stations: [Station]) {
    var snapshot = dataSource.snapshot()
    snapshot.appendItems(stations, toSection: .primary)
    dataSource.apply(snapshot, animatingDifferences: true)
    
  }
  
  private func configureDataSource() {
    dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, station) -> UITableViewCell? in
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = station.name
      cell.detailTextLabel?.text = "Capacity: \(station.capacity)"
      return cell
    })
    
    //setup initial snapshop
    var snapshot = NSDiffableDataSourceSnapshot<Section, Station>()
    snapshot.appendSections([.primary])
    dataSource.apply(snapshot, animatingDifferences: false)
  }
}

// TODO: continue to implement in order to show the sections
//       header titles
//       place in its own file
// subclass UITableViewDiffableSource
class DataSource: UITableViewDiffableDataSource<StationsViewController.Section, Station> {
  // imolement protocol UITableViewDataSource methods here
}

