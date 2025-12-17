import UIKit

class MainViewController: UIViewController {
    private let settingsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .darkGray
        button.setImage(UIImage(named: "Settings"), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let infoButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .darkGray
        button.setImage(UIImage(named: "Information"), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.addSubview(settingsButton)
        view.addSubview(infoButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            settingsButton.widthAnchor.constraint(equalToConstant: 48),
            settingsButton.heightAnchor.constraint(equalToConstant: 48),
            
            infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoButton.widthAnchor.constraint(equalToConstant: 48),
            infoButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
