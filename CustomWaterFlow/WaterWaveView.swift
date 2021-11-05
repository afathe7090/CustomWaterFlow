//
//  WaterWaveView.swift
//  CustomWaterFlow
//
//  Created by Ahmed Fathy on 05/11/2021.
//

import UIKit


let widthScreen = UIScreen.main.bounds.width


class WaterWaveView: UIView {
    
    //MARK: - Properties
    
    private let firstLayer = CAShapeLayer()
    private let secondLayer = CAShapeLayer()
    
    private var firstColor: UIColor = .clear
    private var secondColor: UIColor = .clear
    
    private let towPY: CGFloat = .pi*2
    private var offset: CGFloat = 0.0

    
    
    private var width = widthScreen * 0.5
    
    private var showSignalWave = false
    private var start = false
    
    private var progress: CGFloat = 0.0
    private var waveHeight: CGFloat = 0.0
    
    
    private let perecntLbl = UILabel()
    
    //MARK: - Initalize
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    init(width: CGFloat,
         firstColorWave: UIColor = .orange
        ,secondColorWave:UIColor = .orange.withAlphaComponent(0.3),
         fontPercentSize: CGFloat = 35.0,
         waveHeight: CGFloat = 8.0){
        
        super.init(frame: .zero)
        
        self.width = width
        setUpViews(firstColorWave: firstColorWave, secondColorWave: secondColorWave, fontPercentSize: fontPercentSize, waveHeight: waveHeight)
        
    }
    
    required init?(coder: NSCoder) {super.init(coder: coder)}
    
}



extension WaterWaveView {
    
    //MARK: - Set Progress value of View
    func setUpProgressInVeiwDidApper(_ pro: CGFloat? = 0.0){
        
        guard let pro = pro else {return}
        progress = pro
        perecntLbl.text = String(format: "%ld%%", NSNumber(value: Float(pro*100)).intValue)
        let top: CGFloat = pro * bounds.size.height
        firstLayer.setValue(width - top, forKeyPath: "position.y")
        secondLayer.setValue(width - top, forKeyPath: "position.y")
        if !start {
            DispatchQueue.main.async {
                self.startAnimating()
            }
        }
    }
    
    
    //MARK: - Start Animating in ViewDidApper with time and percent
    func startWithAnimationAndActionWithViewDidAppear(time: TimeInterval? = 10 ,percent: CGFloat? = 100){
        var timer: Timer?
        let dr: TimeInterval = time!
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            
            let dr = CGFloat(1.0 / (dr/0.01))
            self.progress += dr
            self.setUpProgressInVeiwDidApper(self.progress)
            
            print(self.progress)
            
            let percentInterval = percent!/100
            if self.progress >= percentInterval {
                print(self.progress)
                timer?.invalidate()
                timer = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.percentAnimating()
                }
            }
        })
    }
    
    
    
    
    //MARK: - Set Water Wave View Design
    private func setUpViews(firstColorWave: UIColor = .orange
                            ,secondColorWave:UIColor = .orange.withAlphaComponent(0.3),
                            fontPercentSize: CGFloat = 35.0,
                            waveHeight: CGFloat = 8.0){
        bounds = CGRect(x: 0.0, y: 0.0, width: min(width ,width), height: min(width, width))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
        self.layer.cornerRadius = width / 2
        
        self.waveHeight = waveHeight
        firstColor = firstColorWave
        secondColor = secondColorWave
        creatFirstLayer()
        
        if !showSignalWave {
            creatSecondLayer()
        }
        createPercentLabel(fontSize: fontPercentSize)
    }
    
    
    //MARK: - Set Percent Label
    private func createPercentLabel(fontSize: CGFloat = 35.0){
        perecntLbl.translatesAutoresizingMaskIntoConstraints = false
        perecntLbl.font = UIFont.boldSystemFont(ofSize: fontSize)
        perecntLbl.textAlignment = .center
        perecntLbl.text = ""
        perecntLbl.textColor = .darkGray
        addSubview(perecntLbl)
        
        perecntLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        perecntLbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    //MARK: - Creat First Layer
    private func creatFirstLayer() {
        firstLayer.frame = bounds
        firstLayer.anchorPoint = .zero
        firstLayer.fillColor = firstColor.cgColor
        layer.addSublayer(firstLayer)
    }
    
    
    //MARK: - Creat Second Layer
    private func creatSecondLayer() {
        secondLayer.frame = bounds
        secondLayer.anchorPoint = .zero
        secondLayer.fillColor = secondColor.cgColor
        layer.addSublayer(secondLayer)
    }
    
    //MARK: - Percent label animation view
    private func percentAnimating(){
        let animat = CABasicAnimation(keyPath: "opacity")
        animat.duration = 1.5
        animat.fromValue = 0.0
        animat.toValue = 1.0
        animat.repeatCount = .infinity
        animat.isRemovedOnCompletion = false
        
        perecntLbl.layer.add(animat, forKey: nil)
    }
    

    
    //MARK: - start animating
    private func startAnimating(){
        start = true
        startAnimatingWaterWave()
    }
    
    
    
    
    
    //MARK: - start Animating Water wave
    private func startAnimatingWaterWave(){
        
        //creat diminsion width and height
        let height = bounds.size.height
        let width = bounds.size.width
        
        // create path...
        let bezier = UIBezierPath()
        let path = CGMutablePath()
        
        // start offset/postion of y
        let startOffsetY = waveHeight * CGFloat(sinf(Float(offset * towPY / width)))
        var originOffsetY: CGFloat = 0.0
        
        // move the path with points
        path.move(to: CGPoint(x: 0.0, y: startOffsetY), transform: .identity)
        bezier.move(to: CGPoint(x: 0.0, y: startOffsetY))
        
        
        
        for item in stride(from: 0.0,to: width * 1000 ,by: 1){
            originOffsetY = waveHeight * CGFloat(sinf(Float(towPY / width * item + offset * towPY / width)))
            bezier.addLine(to: CGPoint(x: item, y: originOffsetY))
        }
        
        // add line for bezier
        bezier.addLine(to: CGPoint(x: width*1000, y: originOffsetY))
        bezier.addLine(to: CGPoint(x: width*1000, y: height))
        bezier.addLine(to: CGPoint(x: 0.0, y: height))
        bezier.addLine(to: CGPoint(x: 0.0  , y: startOffsetY))
        bezier.close()
              
        
        // set animation....
        let animat = CABasicAnimation(keyPath: "transform.translation.x")
        animat.duration = 2.0
        animat.fromValue = -width*0.5
        animat.toValue = -width - width*0.5
        animat.repeatCount = .infinity
        animat.isRemovedOnCompletion = false
        
        firstLayer.fillColor = firstColor.cgColor
        firstLayer.path = bezier.cgPath
        firstLayer.add(animat, forKey: nil)
        
        
        // set animation of second layer
        if !showSignalWave {
            let bezier = UIBezierPath()
            
            let startOffsetY = waveHeight * CGFloat(sinf(Float(offset * towPY / width)))
            var originOffsetY: CGFloat = 0.0
            
            bezier.move(to: CGPoint(x: 0.0, y: startOffsetY))
            
            for item in stride(from: 0.0,to: width * 1000 ,by: 1){
                originOffsetY = waveHeight * CGFloat(cosf(Float(towPY / width * item + offset * towPY / width)))
                bezier.addLine(to: CGPoint(x: item, y: originOffsetY))
            }
            bezier.addLine(to: CGPoint(x: width*1000, y: originOffsetY))
            bezier.addLine(to: CGPoint(x: width*1000, y: height))
            bezier.addLine(to: CGPoint(x: 0.0, y: height))
            bezier.addLine(to: CGPoint(x: 0.0  , y: startOffsetY))
            bezier.close()
            
            
            secondLayer.fillColor = secondColor.cgColor
            secondLayer.path = bezier.cgPath
            secondLayer.add(animat, forKey: nil)
        }
    }
    
    
}
