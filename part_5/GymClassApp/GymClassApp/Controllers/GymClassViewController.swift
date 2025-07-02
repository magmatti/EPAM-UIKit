import UIKit

final class GymClassViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var gymClassesByDate: [Date: [GymClass]] = [:]
    private var sortedDates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Wellness Classes"
        
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GymClassTableViewCell.self, forCellReuseIdentifier: GymClassTableViewCell.identifier)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadData() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        let sampleData: [GymClass] = [
            GymClass(id: UUID(), name: "Stretching", date: today, time: "10:00", duration: "55", trainerName: "John Doe", trainerImageName: "trainer1", isRegistered: false),
            
            GymClass(id: UUID(), name: "Pilates", date: today.addingTimeInterval(86400), time: "15:00", duration: "55", trainerName: "Adam Smith", trainerImageName: "trainer2", isRegistered: false),
            
            GymClass(id: UUID(), name: "Yoga", date: today.addingTimeInterval(2 * 86400), time: "09:00", duration: "45", trainerName: "Sara White", trainerImageName: "trainer3", isRegistered: false),
        ]

        gymClassesByDate = Dictionary(grouping: sampleData, by: { $0.date })
        sortedDates = gymClassesByDate.keys.sorted()
        tableView.reloadData()
    }
}

extension GymClassViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedDates.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = sortedDates[section]
        return gymClassesByDate[date]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = sortedDates[section]
        return DateFormatter.dayFormatter.string(from: date)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassTableViewCell.identifier, for: indexPath) as? GymClassTableViewCell else {
            return UITableViewCell()
        }

        let date = sortedDates[indexPath.section]
        let gymClass = gymClassesByDate[date]![indexPath.row]
        cell.configure(with: gymClass)

        cell.onActionButtonTap = { [weak self] in
            guard var currentClass = self?.gymClassesByDate[date]?[indexPath.row] else { return }
            currentClass.isRegistered.toggle()
            self?.gymClassesByDate[date]?[indexPath.row] = currentClass
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)

            let alertMessage = currentClass.isRegistered
                ? "You have registered to \(currentClass.name), see you there!"
                : "You have just cancelled \(currentClass.name) :("

            let alert = UIAlertController(title: nil, message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alert, animated: true)
        }

        return cell
    }
}

extension GymClassViewController: UITableViewDelegate {
   
    // swipe to delete implementation
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {

        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }
            let date = self.sortedDates[indexPath.section]
            self.gymClassesByDate[date]?.remove(at: indexPath.row)

            if self.gymClassesByDate[date]?.isEmpty == true {
                self.gymClassesByDate.removeValue(forKey: date)
                self.sortedDates.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }

            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }
}
