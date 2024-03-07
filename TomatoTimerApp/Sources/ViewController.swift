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
    var timerOne = Timer()
    var restTime = 5.0
    var workTime = 25.0
    var currentTime = 0.0

    lazy var shapeView: UIImageView = {
        let imageView = UIImageView()
        if isWorkTime {
            imageView.image = UIImage(named: "Ellipse 1")
        } else {
            imageView.image = UIImage(named: "Ellipse 1-2")
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = isWorkTime ? String(workTime) : String(restTime)
        label.font = UIFont.systemFont(ofSize: 70, weight: .light)
        label.textColor = isWorkTime ? .red : .green
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        let buttonImage = UIImage(systemName: "play")
        let scaledImage = UIImage(cgImage: buttonImage!.cgImage!, scale: 1.0, orientation: .up)
        
        button.setImage(scaledImage, for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        updateUIForCurrentMode()
    }
    
    // MARK: - Setups
    
    private func setupView() {
        view.backgroundColor = .white
        currentTime = workTime
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
            
            startButton.centerXAnchor.constraint(equalTo: timerLabel.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 150)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func startButtonTapped() {
        if !isStarted {
            timerOne = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            
            let pauseImage = UIImage(systemName: "pause")
            let scaledPauseImage = UIImage(cgImage: pauseImage!.cgImage!, scale: 1.0, orientation: .up)
            startButton.setImage(scaledPauseImage, for: .normal)
        } else {
            timerOne.invalidate()
            let playImage = UIImage(systemName: "play")
            let scaledPlayImage = UIImage(cgImage: playImage!.cgImage!, scale: 1.0, orientation: .up)
            startButton.setImage(scaledPlayImage, for: .normal)
        }
        isStarted.toggle()
    }
    
    @objc private func timerAction() {
        currentTime -= 1
         
        if currentTime <= 0 {
            isWorkTime.toggle()
            currentTime = isWorkTime ? workTime : restTime
         }
        
        print(currentTime)
        timerLabel.text = String(format: "%.0f", currentTime)
     }
    
    private func updateUIForCurrentMode() {
        let imageName = isWorkTime ? UIImage(named: "Ellipse 1") : UIImage(named: "Ellipse 1-2")
        let textColor = isWorkTime ? UIColor.red : UIColor.green
        
        shapeView.image = imageName
        timerLabel.text = isWorkTime ? String(workTime) : String(currentTime)
        timerLabel.textColor = textColor
    }
}

