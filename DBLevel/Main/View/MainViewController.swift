import UIKit
import LMGaugeViewSwift
import AVFAudio

class MainViewController: UIViewController {
    private let settingsButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .backgroundBlack
        button.setImage(UIImage(named: "Settings"), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let infoButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .backgroundBlack
        button.setImage(UIImage(named: "Information"), for: .normal)
        button.layer.cornerRadius = 24
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let gaugeView: GaugeView = {
        let gauge = GaugeView()
        gauge.minValue = 0
        gauge.maxValue = 150
        gauge.value = 0
        gauge.valueTextColor = .white
        gauge.limitValue = 70
        gauge.ringThickness = 20
        gauge.ringBackgroundColor = .backgroundBlack
        gauge.divisionsColor = .lightGray
        gauge.unitOfMeasurement = "db-a"
        gauge.translatesAutoresizingMaskIntoConstraints = false
        return gauge
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .backgroundBlack
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let minutesLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let separationLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statsStackView: UIStackView = {
        let minView = makeStatView(title: "MIN", value: "0", unit: "db-a")
        let avgView = makeStatView(title: "AVG", value: "0", unit: "db-a")
        let maxView = makeStatView(title: "MAX", value: "0", unit: "db-a")

        let stack = UIStackView(arrangedSubviews: [minView, avgView, maxView])
        stack.axis = .horizontal
        stack.spacing = 24
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 58
        view.backgroundColor = .lightPinkExtColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .pincExtColor
        button.layer.cornerRadius = 45
        button.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold)
        let image = UIImage(systemName: "play.fill", withConfiguration: config)
        button.setImage(image, for: .normal)

        button.tintColor = .white

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
        view.addSubview(gaugeView)
        view.addSubview(timeView)
        view.addSubview(statsStackView)
        view.addSubview(buttonView)
        
        timeView.addSubview(minutesLabel)
        timeView.addSubview(separationLabel)
        timeView.addSubview(secondLabel)
        
        buttonView.addSubview(startPauseButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            settingsButton.widthAnchor.constraint(equalToConstant: 48),
            settingsButton.heightAnchor.constraint(equalToConstant: 48),
            
            timeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            timeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeView.heightAnchor.constraint(equalToConstant: 37),
            timeView.widthAnchor.constraint(equalToConstant: 68),
            
            separationLabel.centerXAnchor.constraint(equalTo: timeView.centerXAnchor),
            separationLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            
            minutesLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            minutesLabel.trailingAnchor.constraint(equalTo: separationLabel.trailingAnchor, constant: -5),
            
            secondLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor),
            secondLabel.leadingAnchor.constraint(equalTo: separationLabel.leadingAnchor, constant: 5),
            
            infoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            infoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoButton.widthAnchor.constraint(equalToConstant: 48),
            infoButton.heightAnchor.constraint(equalToConstant: 48),
            
            gaugeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gaugeView.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 60),
            gaugeView.widthAnchor.constraint(equalToConstant: 311),
            gaugeView.heightAnchor.constraint(equalToConstant: 311),
            
            statsStackView.topAnchor.constraint(equalTo: gaugeView.bottomAnchor, constant: 10),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            buttonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 112),
            buttonView.widthAnchor.constraint(equalToConstant: 112),
            
            startPauseButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            startPauseButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            startPauseButton.heightAnchor.constraint(equalToConstant: 90),
            startPauseButton.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    private func makeStatView(title: String, value: String, unit: String) -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        titleLabel.textAlignment = .center

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        valueLabel.textAlignment = .right

        let unitLabel = UILabel()
        unitLabel.text = unit
        unitLabel.textColor = .lightGray
        unitLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        unitLabel.textAlignment = .left

        let valueStack = UIStackView(arrangedSubviews: [valueLabel, unitLabel])
        valueStack.axis = .horizontal
        valueStack.spacing = 4
        valueStack.alignment = .lastBaseline

        let mainStack = UIStackView(arrangedSubviews: [titleLabel, valueStack])
        mainStack.axis = .vertical
        mainStack.spacing = 4
        mainStack.alignment = .center

        return mainStack
    }
}
