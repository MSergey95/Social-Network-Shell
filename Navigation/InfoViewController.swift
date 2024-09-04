//
//  InfoViewController.swift
//  Navigation
//
import UIKit

final class InfoViewController: UIViewController, UITableViewDataSource {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private let orbitalPeriodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var residents: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        tableView.dataSource = self

        // Регистрация ячейки
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            orbitalPeriodLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orbitalPeriodLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: orbitalPeriodLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        loadPlanetData()
    }

    private func loadPlanetData() {
        let planetURL = URL(string: "https://swapi.dev/api/planets/1/")!
        NetworkService.requestPlanet(from: planetURL) { [weak self] planet in
            if let planet = planet {
                DispatchQueue.main.async {
                    self?.titleLabel.text = planet.name
                    self?.orbitalPeriodLabel.text = "Orbital Period: \(planet.orbitalPeriod) days"
                    self?.loadResidents(residentURLs: planet.residents)
                }
            } else {
                print("Failed to load planet data")
            }
        }
    }

    private func loadResidents(residentURLs: [String]) {
        let dispatchGroup = DispatchGroup()

        for urlString in residentURLs {
            guard let url = URL(string: urlString) else { continue }
            dispatchGroup.enter()

            NetworkService.requestResident(from: url) { [weak self] resident in
                if let resident = resident {
                    self?.residents.append(resident.name)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = residents[indexPath.row]
        return cell
    }
}
