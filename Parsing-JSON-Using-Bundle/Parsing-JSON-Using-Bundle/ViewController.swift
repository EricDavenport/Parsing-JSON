//
//  ViewController.swift
//  Parsing-JSON-Using-Bundle
//
//  Created by Eric Davenport on 8/3/20.
//  Copyright © 2020 Eric Davenport. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  enum Section {
    case main // table view has only section
  }

  @IBOutlet weak var tableView: UITableView!
  
  typealias DataSource = UITableViewDiffableDataSource<Section, President>
  //  private var dataSource: UITableViewDiffableDataSource<Section, President>!
  private var dataSource: DataSource!    //using typealias
  // both the SectionItemIdentifier and the ItemIdentifier needs to conform to
  //    Hashable protocol

  override func viewDidLoad() {
    super.viewDidLoad()
    configureDataSource()
    fetchPresidents()
  }

  private func configureDataSource() {
    dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, president) -> UITableViewCell? in
      // inside on closure
      // configure the cell
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      cell.textLabel?.text = "\(president.number) - \(president.name)"
      cell.detailTextLabel?.text = "\(president.tookOffice) - \(president.leftOffice)"
      return cell
    })
    
    // setup initial snapshot
    var snapshot = NSDiffableDataSourceSnapshot<Section, President>()
    snapshot.appendSections([.main])
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  private func fetchPresidents() {
    var presidents: [President] = []
    do {
      presidents = try Bundle.main.parseJSON(with: "presidents")
    } catch {
      print("error: \(error)")
      // TODO: Present an alert
    }
    
    // update the snapshot
    var snapshot = dataSource.snapshot()  // query dataSource for the current snapshot - always has most current
    snapshot.appendItems(presidents, toSection: .main)
    
    dataSource.apply(snapshot, animatingDifferences: false)
  }

}

