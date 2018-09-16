//
//  SecondViewController.swift
//  DelegateSample_01
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sectionTitle = ["4月","5月","6月","7月","8月","9月"]
    
    let section0 = [("1week","1day"),("","2day"),("","3day"),("","4day"),("","5day"),
                    ("2week","6day"),("","7day"),("","8day"),("","9day"),("","10day"),
                    ("3week","11day"),("","12day"),("","13day"),("","14day"),("","15day"),
                    ("4week","16day"),("","17day"),("","18day"),("","19day"),("","20day")]
    
    
    
    // テーブルビュー
    @IBOutlet var secondTableView: UITableView!
    
    // シーン移動の際に渡される値
    var selectedVC: Int!
    var soundSetting:Int = 0
    var soundRate:Float = 1.0
    
    // 選択されたセルを覚える変数
    var chosenCell: Int!
    
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondTableView.delegate = self
        secondTableView.dataSource = self
        
    }
    
    
    
    //セクションの個数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //セクションのタイトルを決める
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[selectedVC]
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
        let cell = secondTableView.dequeueReusableCell(withIdentifier: "cell_02", for: indexPath)
        let cellData = section0[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
    }
    
    // セルが選択された時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCell = indexPath.row
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "toPageViewController",sender: nil)
    }
    
    
    // セグエで遷移する前に値を渡す準備をする
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewController {
            pageViewController.selectedSVC = chosenCell
            pageViewController.selectedVC = selectedVC
            pageViewController.arrayLength = section0.count
            pageViewController.soundSetting = soundSetting
            pageViewController.soundRate = soundRate
            print("pvcへ渡す: \(soundSetting)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
