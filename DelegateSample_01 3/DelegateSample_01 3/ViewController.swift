//
//  ViewController.swift
//  DelegateSample_01
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //セルに表示するデータ
    let sectionTitle = ["2018年"]
    let section0 = ["4月","5月","6月","7月","8月","9月"]
    
    // テーブルビュー
    @IBOutlet var tableView: UITableView!
    
    // 設定画面へ移動するボタン
    @IBOutlet weak var goSetting: UIBarButtonItem!
 
    
    // シーン移動の際の受け渡す値
    var soundSetting:Int = 0
    var soundRate:Float = 1.0
    
    
    // 選択されたセルを覚える変数
    var chosenCell: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.16, green: 0.52, blue: 0.63, alpha: 1.0)
        // ナビゲーションバーのアイテムの色
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションアイテムの色変更
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
    }
    
    
    
    
    //セクションの個数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    
    // セクションタイトルの表示で背景色やフォント種類などを変更する
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // ヘッダーのviewを作成
        let headerView = UIView()
        headerView.backgroundColor = UIColor.gray
        // ヘッダーのviewに追加するラベルを作成
        let label = UILabel()
        label.frame = CGRect(x: 15, y: 0, width: 360, height: 30)
        label.text = sectionTitle[section]
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.gray
        headerView.addSubview(label)
        return headerView
    }
    
    // セクションタイトルの高さを決める
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    // セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section0.count
    }
    
    // 各セルの要素を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_01", for: indexPath)
        cell.textLabel?.text = section0[indexPath.row]
        return cell
    }
    
    // セルが選択された時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCell = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "toSecondViewController",sender: nil)
    }
    
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let secVC = (segue.destination as? SecondViewController)!
        secVC.selectedVC = chosenCell
        secVC.soundSetting = soundSetting
        secVC.soundRate = soundRate
        print("svcへ渡す: \(soundSetting)")
    }
    
    
    // 設定画面へ遷移(settingViewControllerへ)
    @IBAction func goSetting(_ sender: Any) {
        let setting = storyboard!.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        setting.modalTransitionStyle = .coverVertical
        setting.soundSetting = soundSetting
        setting.soundRate = soundRate
        self.present(setting,animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

