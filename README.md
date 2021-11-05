# CustomWaterFlow
 
# How to use 

   
    1- download or copy code from the file (WaterWaveView.swift)
    2- can use instance from the class 
    3- call func instance.setUpProgressInVeiwDidApper() in viewDidLoad
    4- call func instance.startWithAnimationAndActionWithViewDidApped() 
    


# Instance 
    
    // Must init with width the inital value = widthScrean / 2
    let waterWaveFlow = WaterWaveView(width:CGFloat) 
    
    // you can use any of any instance that have default value
    let waterWaveFlow = WaterWaveView(width: CGFloat, firstColorWave: UIColor, secondColorWave: UIColor, fontPercentSize: CGFloat, waveHeight: CGFloat)
 
    Width must be Entered
    You can have a custom value of another values
 
 # ViewDidLoad  
 
         waterWaveFlow.setUpProgressInVeiwDidApper() 
 
 # viewDidApper
 
 time default value = 10.0 s
 persent defaul value = 100 %
 
        // default time and persent
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear()
        // for change Time 
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear(time: 1)
        //for change Percent
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear(percent: 75)
        //for change Time and persent
        waterWaveFlow.startWithAnimationAndActionWithViewDidAppear(time: 5, percent: 50)
        
        
# Video 
 
 https://user-images.githubusercontent.com/76500072/140557685-0bcb405b-d1ce-496e-92db-563715d1e2a1.mov
       
       
