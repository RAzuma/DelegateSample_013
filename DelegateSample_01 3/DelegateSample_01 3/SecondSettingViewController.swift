//
//  SecondSettingViewController.swift
//  DelegateSample_01
//

import UIKit

protocol testDelegate: class {
    func test(soundSetting: Int)
}

class SecondSettingViewController: UIViewController {
    
    weak var testdelegate: testDelegate?
    
    // シーン移動の際に受け渡す
    var soundSetting:Int = 0
    var pageIndex:Int = 0
    var selectedVC:Int = 0
    var arrayLength:Int = 0
    var soundRate:Float = 1.0
    
    // スライダー関連
    let slider = UISlider()
    let sliderLeftLabel = UILabel()
    let sliderRightLabel = UILabel()
    let sliderCenterLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.85, green: 0.9, blue: 0.9, alpha: 1.0)
        
        
        // Viewを閉じる（VCへ戻る）dismisボタン作成
        let backDMButton = UIButton()
        backDMButton.frame = CGRect(x: 0, y: 20, width: 120, height: 30)
        backDMButton.center = CGPoint(x: self.view.frame.midX, y: 35)
        backDMButton.setTitle("dismiss戻り", for: .normal)
        backDMButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        backDMButton.setTitleColor(UIColor.white, for: .normal)
        backDMButton.setTitleColor(UIColor.white, for: .highlighted)
        backDMButton.backgroundColor = UIColor(red: 0.35, green: 0.5, blue: 0.5, alpha: 1.0)
        backDMButton.addTarget(self, action: #selector(backDMVC(sender:)), for: .touchUpInside)
        self.view.addSubview(backDMButton)
        
        
        // 音設定
        let soundSetLabel = UILabel()
        soundSetLabel.frame = CGRect(x: 57.5, y: 68, width: 60, height: 12)
        soundSetLabel.text = "音声設定"
        soundSetLabel.font = UIFont.systemFont(ofSize: 12)
        soundSetLabel.textColor = UIColor(red: 0.35, green: 0.5, blue: 0.4, alpha: 1.0)
        self.view.addSubview(soundSetLabel)

        
        
        // セグメントに設定するボタンを配列で作成
        let array : NSArray = ["OFF","ON"]
        let soundSegmentedControl: UISegmentedControl = UISegmentedControl(items: array as [AnyObject])
        soundSegmentedControl.frame = CGRect(x: 0, y: 0, width: 260, height: 30)
        soundSegmentedControl.center = CGPoint(x: self.view.frame.width/2, y: 100)
        soundSegmentedControl.selectedSegmentIndex = soundSetting
        soundSegmentedControl.backgroundColor = UIColor(red: 0.85, green: 0.9, blue: 0.9, alpha: 1.0)
        soundSegmentedControl.tintColor = UIColor.darkGray
        soundSegmentedControl.addTarget(self, action: #selector(self.segmentChanged(segcon:)), for: UIControlEvents.valueChanged)
        self.view.addSubview(soundSegmentedControl)
        
        
        
        // 音速度
        let soundRateLabel = UILabel()
        soundRateLabel.frame = CGRect(x: 57.5, y: 160, width: 60, height: 12)
        soundRateLabel.text = "音声速度"
        soundRateLabel.font = UIFont.systemFont(ofSize: 12)
        soundRateLabel.textColor = UIColor(red: 0.35, green: 0.5, blue: 0.4, alpha: 1.0)
        self.view.addSubview(soundRateLabel)

        
        // スライダーの作成
        slider.frame.size.width = 200
        slider.sizeToFit()
        slider.center = CGPoint(x:self.view.frame.midX, y:200)
        slider.addTarget(self, action: #selector(self.onChange), for: .valueChanged)
        slider.minimumValue = 0.5  // 最小値を変更する(デフォルトは0.0〜1.0)(rateの範囲は0.5〜2.0標準速度は1.0)
        slider.maximumValue = 1.5  // 最大値を変更する
        slider.value = soundRate  // 初期値を設定
        slider.tintColor = UIColor.darkGray
        self.view.addSubview(slider)
        
        
        // スライダー左側ラベル
        sliderLeftLabel.frame = CGRect(x: 60, y: 194, width: 30, height: 12)
        sliderLeftLabel.text = "遅い"
        sliderLeftLabel.font = UIFont.systemFont(ofSize: 12)
        sliderLeftLabel.textAlignment = .left
        sliderLeftLabel.textColor = UIColor.darkGray
        self.view.addSubview(sliderLeftLabel)
        
        // スライダー右側ラベル
        sliderRightLabel.frame = CGRect(x: 285, y: 194, width: 30, height: 12)
        sliderRightLabel.text = "早い"
        sliderRightLabel.font = UIFont.systemFont(ofSize: 12)
        sliderRightLabel.textAlignment = .right
        sliderRightLabel.textColor = UIColor.darkGray
        self.view.addSubview(sliderRightLabel)

        // スライダー中央ラベル
        sliderCenterLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 10)
        sliderCenterLabel.center = CGPoint(x: view.frame.midX, y: 230)
        sliderCenterLabel.font = UIFont.systemFont(ofSize: 10)
        sliderCenterLabel.textAlignment = .center
        roundRate()
        sliderCenterLabel.textColor = UIColor.darkGray
        self.view.addSubview(sliderCenterLabel)

        
        // スライダー標準に戻すボタン
        let sliderValueButton = UIButton()
        sliderValueButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        sliderValueButton.center = CGPoint(x: view.frame.midX, y: 170)
        sliderValueButton.setTitle("標準", for: .normal)
        sliderValueButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sliderValueButton.setTitleColor(UIColor.darkGray, for: .normal)
        sliderValueButton.setTitleColor(UIColor.white, for: .highlighted)
        //sliderValueButton.backgroundColor = UIColor.gray
        sliderValueButton.addTarget(self, action: #selector(sliderValueButtonSet(sender:)), for: .touchUpInside)
        self.view.addSubview(sliderValueButton)

        
    }  // viewDidLoadを閉じる
    
    
    
    
    // セグメントボタン押下時に実行するメソッド
    func segmentChanged(segcon: UISegmentedControl){
        switch segcon.selectedSegmentIndex {
        case 0:
            soundSetting = 0
            print("Tap 0")
        case 1:
            soundSetting = 1
            print("Tap 1")
        default:
            print("Error")
        }
    }
    
    
    // スライダーのイベント
    func onChange(_ sender: UISlider) {
        soundRate = sender.value
        roundRate()
    }

    
    // スライダーの値を計算して表示するイベント
    func roundRate() {
        // 四捨五入して小数第二位までにする
        var roundRate:Float = 1.00
        roundRate = round(soundRate * 100)
            //print("四捨五入Rate: \(roundRate)")
        roundRate = roundRate / 100
            //print("四捨五入後のRate: \(roundRate)")
        if soundRate == 1.00 {
            sliderCenterLabel.text = ""
        } else if soundRate == 0.50 {
            sliderCenterLabel.text = "遅い -50%"
        } else if soundRate == 1.50 {
            sliderCenterLabel.text = "早い +50%"
        } else {
            var setRate:Int = 1
            setRate = Int((roundRate*100)-100)
            if roundRate <= 1.00 {
            sliderCenterLabel.text = "遅い \(setRate)%"
            } else {
            sliderCenterLabel.text = "早い +\(setRate)%"
            }
        }
    }
    
    
    
    // スライダーの値を標準値に戻すイベント
    func sliderValueButtonSet(sender: AnyObject) {
        // 初期値を設定+アニメーション付き
        slider.setValue(1.00, animated: true)
        sliderCenterLabel.text = ""
        soundRate = 1.00
        print("標準戻し時のsoundRate: \(soundRate)")
    }
    
    
    // セグエで遷移した戻りのdismiss
    func backDMVC(sender: AnyObject) {
        
        // Navigation Controllerを取得
        let nav = self.presentingViewController  as! UINavigationController
        // pageViewControllerにパラメータを渡す
        let pageViewController = nav.topViewController as! PageViewController
        pageViewController.soundSetting = soundSetting
        pageViewController.soundRate = soundRate
        
        
        self.testdelegate?.test(soundSetting: soundSetting)   // デリゲート★★★
        self.dismiss(animated: true, completion: nil)
        
        print("戻る時のsoundSetting: \(soundSetting)")
        print("戻る時のsoundRate: \(soundRate)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
