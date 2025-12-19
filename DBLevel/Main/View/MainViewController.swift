import UIKit
import LMGaugeViewSwift
import AVFAudio

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
    
    private let gaugeView: GaugeView = {
        let gauge = GaugeView()
        gauge.minValue = 0
        gauge.maxValue = 150
        gauge.value = 00
        gauge.limitValue = 70
        gauge.ringThickness = 20
        gauge.ringBackgroundColor = .darkGray
        gauge.divisionsColor = .lightGray
        gauge.unitOfMeasurement = "db-a"
        gauge.translatesAutoresizingMaskIntoConstraints = false
        return gauge
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
        view.addSubview(gaugeView)
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
            
            gaugeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gaugeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gaugeView.widthAnchor.constraint(equalToConstant: 311),
            gaugeView.heightAnchor.constraint(equalToConstant: 311)
            
        ])
    }
}
