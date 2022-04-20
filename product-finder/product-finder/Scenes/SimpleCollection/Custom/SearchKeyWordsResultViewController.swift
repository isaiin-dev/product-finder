//
//  SearchKeyWordsResultViewController.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import UIKit

protocol SearchKeyWordsResultViewControllerDelegate: AnyObject {
    func didSelect(keyword: String)
}

class SearchKeyWordsResultViewController: UIViewController {
    // MARK: - SubViews
    
    private lazy var table: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .clear
        table.register(UITableViewCell.self, forCellReuseIdentifier: "KEYWORD_RESULT_CELL")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    // MARK: - Properties
    
    var query: String = "" {
        didSet {
            guard !query.isEmpty, query.count > 2 else { return }
            let request = SimpleCollection.SearchKeywords.Request(search: query, country: "mx")
            SimpleCollectionWorker().searchSuggestedKeywords(
                request: request) { result in
                    switch result {
                    case .success(let response):
                        self.results = response.suggestedKeywords
                    case .failure(let error):
                        print(error)
                        self.results = [Constants.Content.KeywordsView.noData]
                    }
                }
        }
    }
    
    var results = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    weak var delegate: SearchKeyWordsResultViewControllerDelegate?

    // MARK: - Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        view.addSubview(table)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc func handleKeyboardShow(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            table.contentInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: keyboardHeight,
                right: 0)
        }
    }
}

// MARK: - TableView delegate & dataSource

extension SearchKeyWordsResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KEYWORD_RESULT_CELL", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .darkText
        cell.textLabel?.text = "\(results[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(keyword: results[indexPath.row])
    }
}
