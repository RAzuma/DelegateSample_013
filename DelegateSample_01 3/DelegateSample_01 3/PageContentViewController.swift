//
//  PageContentViewController.swift
//  DelegateSample_01
//

import UIKit
import AVFoundation

class PageContentViewController: UIViewController, AVAudioPlayerDelegate {
    
    // ２枚目のテーブルビューに表示されている項目の数分の配列を各配列内に作る
    let aprilArray = [["time4_1","","",""],["time4_2","","",""],["time4_3","","",""],["time4_4","","",""],["time4_5","","",""],["time4_6","","",""],["time4_7","","",""],["time4_8","","",""],["time4_9","","",""],["time4_10","","",""],["time4_11","","",""],["time4_12","","",""],["time4_13","","",""],["time4_14","","",""],["time4_15","","",""],["time4_16","","",""],["time4_17","","",""],["time4_18","","",""],["time4_19","","",""],["time4_20","","",""]]
    
    let mayArray = [["time5_1","","",""],["time5_2","","",""],["time5_3","","",""],["time5_4","","",""],["time5_5","","",""],["time5_6","","",""],["time5_7","","",""],["time5_8","","",""],["time5_9","","",""],["time5_10","","",""],["time5_11","","",""],["time5_12","","",""],["time5_13","","",""],["time5_14","","",""],["time5_15","","",""],["time5_16","","",""],["time5_17","","",""],["time5_18","","",""],["time5_19","","",""],["time5_20","","",""]]
    
    let juneArray = [["time6_1","","",""],["time6_2","","",""],["time6_3","","",""],["time6_4","","",""],["time6_5","","",""],["time6_6","","",""],["time6_7","","",""],["time6_8","","",""],["time6_9","","",""],["time6_10","","",""],["time6_11","","",""],["time6_12","","",""],["time6_13","","",""],["time6_14","","",""],["time6_15","","",""],["time6_16","","",""],["time6_17","","",""],["time6_18","","",""],["time6_19","","",""],["time6_20","","",""]]
    
    let julyArray = [["time7_1","","",""],["time7_2","","",""],["time7_3","","",""],["time7_4","","",""],["time7_5","","",""],["time7_6","","",""],["time7_7","","",""],["time7_8","","",""],["time7_9","","",""],["time7_10","","",""],["time7_11","","",""],["time7_12","","",""],["time7_13","","",""],["time7_14","","",""],["time7_15","","",""],["time7_16","","",""],["time7_17","","",""],["time7_18","","",""],["time7_19","","",""],["time7_20","","",""]]
    
    let augustArray = [["time8_1","","",""],["time8_2","","",""],["time8_3","","",""],["time8_4","","",""],["time8_5","","",""],["time8_6","","",""],["time8_7","","",""],["time8_8","","",""],["time8_9","","",""],["time8_10","","",""],["time8_11","","",""],["time8_12","","",""],["time8_13","","",""],["time8_14","","",""],["time8_15","","",""],["time8_16","","",""],["time8_17","","",""],["time8_18","","",""],["time8_19","","",""],["time8_20","","",""]]
    
    let septemberArray = [["time9_1","","",""],["time9_2","","",""],["time9_3","","",""],["time9_4","","",""],["time9_5","","",""],["time9_6","","",""],["time9_7","","",""],["time9_8","","",""],["time9_9","","",""],["time9_10","","",""],["time9_11","","",""],["time9_12","","",""],["time9_13","","",""],["time9_14","","",""],["time9_15","","",""],["time9_16","","",""],["time9_17","","",""],["time9_18","","",""],["time9_19","","",""],["time9_20","","",""]]
    
    
    
    //シーン移動の際に設定されるデータ
    var pageIndex:Int = 0
    var selectedVC:Int = 0
    var selectedSVC:Int = 0
    var arrayLength:Int = 0
    
    var soundSetting:Int = 0
    var soundRate:Float = 1.0

    
    // 配列
    var labels = [UILabel]()
    var selectedArray = [Array<String>]()
    
    
    // index確認用ラベル
    let pageIndexLabel = UILabel()
    let selectedVCLabel = UILabel()
    let selectedSVCLabel = UILabel()
    // 設定値確認用ラベル
    let soundSettingLabel = UILabel()
    let soundRateLabel = UILabel()
    
    
    // 画面下部のページ移動ボタン
    let nextButton = UIButton()
    let backButton = UIButton()
    
    
    
    // sound関係
    let soundArray = ["sound01","sound02"]  // 音ファイル名を格納
    var soundButtons = [UIButton]()         // 音声を鳴らすボタンを格納する
    
    var audioUrls:[URL?] = []               // soundArrayの要素からパスとurlを作成し格納する
    var audioPlayer:AVAudioPlayer!          // urlから音声データにして格納する
    var audioPlayers:[AVAudioPlayer?] = []  // 音声データを格納する
    
    var currentPlayer:AVAudioPlayer?    // 現在再生中のPlayer
    var currentButtonIndex:Int?         // 現在再生中の音のButton

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 上部３つのラベル
        selectedVCLabel.frame = CGRect(x: 20, y: 20, width: 335, height: 30)
        selectedVCLabel.text = "selectedVC:  \(selectedVC)"  //VCで選択したセルのindex
        selectedVCLabel.backgroundColor = UIColor.orange
        self.view.addSubview(selectedVCLabel)
        
        selectedSVCLabel.frame = CGRect(x: 20, y: 60, width: 335, height: 30)
        selectedSVCLabel.text = "selectedSVC:  \(selectedSVC)"  //SVCで選択したセルのindex
        selectedSVCLabel.backgroundColor = UIColor.green
        self.view.addSubview(selectedSVCLabel)
        
        pageIndexLabel.frame = CGRect(x: 20, y: 100, width: 335, height: 30)
        pageIndexLabel.text = "pageIndex:  \(pageIndex)"  //各ページに割り当てたindex
        pageIndexLabel.backgroundColor = UIColor.cyan
        self.view.addSubview(pageIndexLabel)
        
        
        // １枚目のテーブルビューで選択されたセルによって表示する配列を選別
        switch selectedVC {
        case 0:
            selectedArray = aprilArray
        case 1:
            selectedArray = mayArray
        case 2:
            selectedArray = juneArray
        case 3:
            selectedArray = julyArray
        case 4:
            selectedArray = augustArray
        case 5:
            selectedArray = septemberArray
        default:
            break
        }
        
        
        // 配列の要素を表示するラベルを作成
        for index in 0..<4 {
            let label = UILabel()
            label.frame = CGRect(x: 20, y: 150 + (30 * index), width: 335, height: 30)
            label.backgroundColor = UIColor.lightGray
            if index % 2 == 0 {label.backgroundColor = UIColor(red:0.8, green:0.8, blue:0.8, alpha:1.0)}
            if index % 2 == 1 {label.backgroundColor = UIColor(red:0.64, green:0.64, blue:0.64, alpha:1.0)}
            label.text = selectedArray[pageIndex][index]
            labels.append(label)
            self.view.addSubview(label)
        }
        
        
        // 確認用soundSettingラベル
        soundSettingLabel.frame = CGRect(x: 20, y: 300, width: 335, height: 30)
        soundSettingLabel.text = "soundSetting:  \(soundSetting)"
        soundSettingLabel.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 1.0, alpha: 1.0)
        soundSettingLabel.textColor = UIColor.white
        self.view.addSubview(soundSettingLabel)
        
        // 確認用soundRateラベル
        soundRateLabel.frame = CGRect(x: 20, y: 340, width: 335, height: 30)
        soundRateLabel.text = "soundRate:  \(soundRate)"
        soundRateLabel.backgroundColor = UIColor(red: 0.5, green: 0.6, blue: 1.0, alpha: 1.0)
        soundRateLabel.textColor = UIColor.white
        self.view.addSubview(soundRateLabel)
        
        
        // 音ボタン
        for index in 0..<soundArray.count {
            let soundButton = UIButton()
            soundButton.frame = CGRect(x: (view.frame.width-100)/2, y: CGFloat(400+(index*50)) , width: 100, height: 50)
            soundButton.backgroundColor = UIColor.white
            soundButton.titleLabel?.font = UIFont.systemFont(ofSize: 40)
            soundButton.setTitle("▶", for: .normal)
            soundButton.setTitleColor(UIColor.darkGray, for: .normal)
            soundButton.setTitleColor(UIColor.lightGray, for: .highlighted)
            soundButton.tag = index
            soundButton.addTarget(self, action: #selector(soundEvent(sender:)), for: .touchDown)
            soundButtons.append(soundButton)
            self.view.addSubview(soundButton)
        }
        
        
        
        // next▶ ボタン
        nextButton.frame = CGRect(x: 300, y: 540, width: 50, height: 30)
        nextButton.setTitle("next▶", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        nextButton.setTitleColor(UIColor.white, for: .normal)
        nextButton.backgroundColor = .green
        nextButton.layer.cornerRadius = 15.0
        nextButton.layer.borderWidth = 2.0
        nextButton.layer.borderColor = UIColor.green.cgColor
        nextButton.addTarget(self, action: #selector(buttonEventNext(sender:)), for: .touchUpInside)
        self.view.addSubview(nextButton)
        
        
        // ◀back ボタン
        backButton.frame = CGRect(x:245, y:540, width: 50, height: 30)
        backButton.setTitle("◀back", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.backgroundColor = .cyan
        backButton.layer.cornerRadius = 15.0
        backButton.layer.borderWidth = 2.0
        backButton.layer.borderColor = UIColor.cyan.cgColor
        backButton.addTarget(self, action: #selector(buttonEventBack(sender:)), for: .touchUpInside)
        self.view.addSubview(backButton)

        
    }  // viewDidLoadを閉じる
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 再生中の音を停止してボタンの色を戻す
        if currentPlayer != nil {
            if (currentPlayer?.isPlaying)! {
                currentPlayer?.stop()
                currentPlayer?.currentTime = 0
                soundButtons[currentButtonIndex!].setTitleColor(UIColor.darkGray, for: .normal)
            }
        }
        currentPlayer = nil
        currentButtonIndex = nil
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextbackHidden()
        test1()
        test2(soundSetting: soundSetting)
        
        print("pcvcのAppear S: \(soundSetting)")
        print("pcvcのAppear R: \(soundRate)")
    }
    
    // デリゲートメソッド                                  // 追加コード★★★
    func setBackGroundColor(soundSetting: Int) {
        if soundSetting == 0 {
            self.view.backgroundColor = UIColor.red
        }
        if soundSetting == 1 {
            self.view.backgroundColor = UIColor.brown
        }
        if soundSetting == 2 {
            self.view.backgroundColor = UIColor.yellow
        }
    }

    
    // デリゲートメソッド
    func test1() {
        // soundSettingとRateのラベルの表示を更新する
        soundSettingLabel.text = "soundSetting:  \(soundSetting)"
        soundRateLabel.text = "soundRate:  \(soundRate)"
        print("test1メソッドに入ったsS: \(soundSetting)")
    }
    
    func test2(soundSetting: Int) {
        // 再生ボタンを非表示にし、viewの背景色を赤にする
        if soundSetting == 0 {
            for i in 0..<soundArray.count {
                self.view.backgroundColor = UIColor.red
                soundButtons[i].isHidden = true
                print("test2メソッドに入ったsS: \(soundSetting)")
            }
        }
        if soundSetting == 1 {
            // 再生ボタンを表示させ、viewの背景色を茶色にする
            for i in 0..<soundArray.count {
                self.view.backgroundColor = UIColor.brown
                soundButtons[i].isHidden = false
                print("test2メソッドに入ったsS: \(soundSetting)")
            }
        }
    }

    
    // 音を鳴らすイベント
    func soundEvent(sender: UIButton) {
        // ボタンのtag番号を変数indexに代入
        let index = sender.tag
        let audioPath = Bundle.main.path(forResource: "\(soundArray[index])", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.enableRate = true
            audioPlayer.rate = soundRate
        } catch {
            print("エラー")
        }
        if currentPlayer != nil {
            if (currentPlayer?.isPlaying)! {   // 再生中の音があるなら
                if currentButtonIndex == index {  // 同じボタンを再度押下
                    currentPlayer?.stop()
                    currentPlayer?.currentTime = 0
                    soundButtons[index].setTitleColor(UIColor.darkGray, for: .normal)
                    currentPlayer = nil
                } else {  // 再生中のボタンと別ボタンを押下
                    // 再生中の音を停止
                    currentPlayer?.stop()
                    currentPlayer?.currentTime = 0
                    soundButtons[currentButtonIndex!].setTitleColor(UIColor.darkGray, for: .normal)
                    // 押されたボタンの音を再生する
                    audioPlayer.play()
                    currentPlayer = audioPlayer
                    currentButtonIndex = index
                    soundButtons[index].setTitleColor(UIColor.magenta, for: .normal)
                }
            }
        } else {  // currentPlayerがnilのとき（ページに移動したばかりor音が再生終了した後）
            audioPlayer.play()
            currentPlayer = audioPlayer
            currentButtonIndex = index
            soundButtons[index].setTitleColor(UIColor.magenta, for: .normal)
        }
        audioPlayer.volume = 1.0  // デフォルトは1.0
    }
    
    
    
    // 音楽再生が成功した時に呼ばれるメソッド
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        currentPlayer = nil
        soundButtons[currentButtonIndex!].setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    // デコード中にエラーが起きた時に呼ばれるメソッド
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("デコードエラー")
    }

    
    
    
    // ページ移動させるボタンの表示/非表示メソッド
    func nextbackHidden() {
        
        let pageViewController = self.parent as! PageViewController
        
        // ナビバーのNextボタンをpageIndexの値が19（最後のページ）のときは無効にし、alpha値を０にして消す
        if pageIndex == 19 {
            pageViewController.navNextButton.tintColor = UIColor(white: 0, alpha: 0)
            pageViewController.navNextButton.isEnabled = false
        } else {
            pageViewController.navNextButton.tintColor = .green
            pageViewController.navNextButton.isEnabled = true
        }
    
        // ナビバーのBackボタンをpageIndexの値が0（最初のページ）のときは無効にし、alpha値を０にして消す
        if pageIndex == 0  {
            pageViewController.navBackButton.tintColor = UIColor(white: 0, alpha: 0)
            pageViewController.navBackButton.isEnabled = false
        } else {
            pageViewController.navBackButton.tintColor = .cyan
            pageViewController.navBackButton.isEnabled = true
        }
    
        // nextButtonをpageIndexの値が19（最後のページ）なら非表示にする
        if pageIndex == 19 {
            nextButton.isHidden = true
        }
    
        // backButtonをpageIndexの値が0（最初のページ）なら非表示にする
        if pageIndex == 0 {
            backButton.isHidden = true
        }
    }
    
    
    // nextボタンタップイベント
    func buttonEventNext(sender: AnyObject) {
        let pageViewController = self.parent as! PageViewController
        let nextIndex = pageIndex + 1
        pageViewController.setViewControllers([pageViewController.contentVCs[nextIndex]], direction: .forward, animated: true, completion: nil)
        pageViewController.currentIndex += 1  // navNextButton用
     }
    
    
    // backボタンタップイベント（ページの送りを左開きにするには direction: .reverse にする）
    func buttonEventBack(sender: AnyObject) {
        let pageViewController = self.parent as! PageViewController
        let previousIndex = pageIndex - 1
        pageViewController.setViewControllers([pageViewController.contentVCs[previousIndex]], direction: .reverse, animated: true, completion: nil)
        pageViewController.currentIndex -= 1  // navBacktButton用
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
