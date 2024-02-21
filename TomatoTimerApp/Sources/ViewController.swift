//
//  ViewController.swift
//  TomatoTimerApp
//
//  Created by Bema on 21/2/24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UI
    var isWorkTime = true {
        didSet {
            updateUIForCurrentMode()
        }
    }
    var isStarted = false
    
    lazy var shapeView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: isWorkTime ? "circle.tomato" : "circle.green")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = isWorkTime ? "25:00" : "05:00"
        label.font = UIFont.systemFont(ofSize: 70, weight: .light)
        label.textColor = isWorkTime ? .red : .green
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(named: "play")
        let scaledImage = UIImage(cgImage: buttonImage!.cgImage!, scale: 1.0, orientation: .up)
        
        button.setImage(scaledImage, for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Timer
    
    var timerOne = Timer()
    var duration = 25
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubview(shapeView)
        shapeView.addSubview(timerLabel)
        view.addSubview(startButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            shapeView.heightAnchor.constraint(equalToConstant: 300),
            shapeView.widthAnchor.constraint(equalToConstant: 300),
            
            timerLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: shapeView.centerYAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 610)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func startButtonTapped() {
        if !isStarted {
            timerOne = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
            let pauseImage = UIImage(named: "pause")
            let scaledPauseImage = UIImage(cgImage: pauseImage!.cgImage!, scale: 1.0, orientation: .up)
            startButton.setImage(scaledPauseImage, for: .normal)
        } else {
            timerOne.invalidate()
            let playImage = UIImage(named: "play")
            let scaledPlayImage = UIImage(cgImage: playImage!.cgImage!, scale: 1.0, orientation: .up)
            startButton.setImage(scaledPlayImage, for: .normal)
        }
        isStarted = !isStarted
    }
    
    @objc
    private func timerAction() {
        duration -= 1
        let seconds = duration
        timerLabel.text = String(format: "%02d:%02d", seconds)
        print(duration)
        
        if duration == 0 {
            toggleMode()
        }
    }
    
    private func toggleMode() {
        isWorkTime = !isWorkTime
        duration = isWorkTime ? 25 : 5
        updateUIForCurrentMode()
    }
    
    private func updateUIForCurrentMode() {
        let imageName = isWorkTime ? "circle.tomato" : "circle.green"
        let textColor = isWorkTime ? UIColor.red : UIColor.green
        
        shapeView.image = UIImage(named: imageName)
        timerLabel.text = isWorkTime ? "25:00" : "05:00"
        timerLabel.textColor = textColor
    }
}

