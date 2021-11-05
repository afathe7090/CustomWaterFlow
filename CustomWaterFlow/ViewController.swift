//
//  ViewController.swift
//  CustomWaterFlow
//
//  Created by Ahmed Fathy on 05/11/2021.
//

import UIKit


class ViewController: UIViewController {
    
    let  waterWaveFlow = WaterWaveView(width:  widthScreen * 0.7, fontPercentSize: 35)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureWaterWaveView()
        
        waterWaveFlow.layer.borderColor = UIColor.blue.withAlphaComponent(0.8).cgColor
        waterWaveFlow.setUpProgressInVeiwDidApper()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear()
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear(time: 1)
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear(percent: 75)
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear(time: 5, percent: 50)
    }
        
    
    
    private func configureWaterWaveView(){
        view.addSubview(waterWaveFlow)
        NSLayoutConstraint.activate([
            waterWaveFlow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            waterWaveFlow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            waterWaveFlow.widthAnchor.constraint(equalToConstant: widthScreen * 0.7),
            waterWaveFlow.heightAnchor.constraint(equalToConstant: widthScreen * 0.7)
        ])
    }
    
    
    
}

