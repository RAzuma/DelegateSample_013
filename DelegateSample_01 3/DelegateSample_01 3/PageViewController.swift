//
//  PageViewController.swift
//  DelegateSample_01
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate, testDelegate {
    
    
    // ナビゲーションバーのNext/Backボタン
    @IBOutlet weak var navNextButton: UIBarButtonItem!
    @IBOutlet weak var navBackButton: UIBarButtonItem!
    
    
    // シーン移動の際に渡される値
    var selectedVC:Int = 0      // viewControllerで押されたセルのindex
    var selectedSVC: Int = 0    // SecondViewControllerで押されたセルのindex
    var arrayLength: Int = 0    // SVCの配列の要素数が作成ページ数となる
    var soundSetting: Int = 0   // 設定画面で設定する音設定
    var soundRate:Float = 1.0   // 設定画面で設定する音速度
    
    var pageIndex: Int = 0      // コンテンツVC作成時に各vcにセットするindex
    
    // ページングするviewControllerを格納する配列
    var contentVCs = [UIViewController]()
    //var contentVCs = [PageContentViewController]()        // ←こちらにするとpendingIndexなどでエラーがでる◆◆◆
    
    
    //  delegateメソッドで取得する値(pendingIndex/currentIndex)
    var pendingIndex: Int = 0
    var previousIndex: Int = 0
    
    // 現在indexのプロパティ
    var currentIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ナビゲーションバーの透過を無効にする。
        self.navigationController!.navigationBar.isTranslucent = false

        dataSource = self
        delegate = self
        
        // コンテンツViewControllerを作成
        for index in 0..<arrayLength {
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
            contentVC.pageIndex = index
            contentVC.selectedSVC = selectedSVC
            contentVC.selectedVC = selectedVC
            contentVC.soundSetting = soundSetting
            contentVC.soundRate = soundRate
            contentVCs.append(contentVC)
        }
        
        self.setViewControllers([contentVCs[selectedSVC]], direction: .forward, animated: true, completion: nil)
        
        // テーブルビューから遷移したらセルのindexを代入
        currentIndex = selectedSVC
        
        
    }  // viewDidLoad()を閉じる
    
    
    
    // 設定画面へセグエで遷移 (SecondSettingViewControllerへ)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondSettingVC = segue.destination as? SecondSettingViewController {
            secondSettingVC.soundSetting = soundSetting
            secondSettingVC.soundRate = soundRate
            secondSettingVC.testdelegate = self
        }
    }
    
    
    
      
    
    // MARK: - UIPageViewControllerDataSource
    // スワイプでページを戻る(Before)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contentVCs.index(of: viewController as! PageContentViewController), index > 0 else {
            return nil
        }
        let previousVC = contentVCs[index - 1]
        return previousVC
    }
    
    // スワイプでページを進む(After)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contentVCs.index(of: viewController as! PageContentViewController), index < contentVCs.count - 1 else {
            return nil
        }
        let nextVC = contentVCs[index + 1]
        return nextVC
    }
    
    
    // MARK: - UIPageViewControllerDelegate
    // 遷移する前に呼ばれる pendingViewControllers(遷移前に予定している次ページを取得）
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = contentVCs.index(of: pendingViewControllers.first!)!
        print("予定(pendiing)ページwill: \(pendingIndex)")
    }
    
    
    // 遷移した後に呼ばれる previousViewControllers(遷移後に前ページを取得）
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            print("現在(current)ページdid: \(currentIndex)")
        }
    }
    
    
    // ナビゲーションバーの [Next] ボタン
    @IBAction func navNextButton(_ sender: UIButton) {
        if currentIndex < 19 {
            currentIndex += 1
            let nextIndex = currentIndex
            if nextIndex < 20 {
                self.setViewControllers([contentVCs[nextIndex]], direction: .forward, animated: true, completion: nil)
                print("Nextボタンタップ: \(nextIndex)")
             }
        }
    }
    
    // ナビゲーションバーの [Back] ボタン
    @IBAction func navBackButton(_ sender: UIButton) {
        if currentIndex > 0 {
            currentIndex -= 1
            let previousIndex = currentIndex
            if previousIndex > -1 {
                self.setViewControllers([contentVCs[previousIndex]], direction: .reverse, animated: true, completion: nil)
                print("Backボタンタップ: \(previousIndex)")
            }
        }
    }
    
    // testDelegate
    func test(soundSetting: Int) {
        // 2018/09/18 r-azuma
        // delegateを使用する際の考え方としては正しいです。
        // あくまでも戻ってくるのはこの場所なのでここで操作できることを前提としてコードを書きます。
        // 今回の場合は設定値のようなものなのでdelegateを使う必要はあまりないかもしれません？
        // 他のクラスで何かしら処理が行われたときに処理を行いたい場合に使われることが多いです。
        // 設定値として使いたくない（あくまでアプリ起動してから操作されることによって処理させたい）のであればアリかもしれません。
        for content in contentVCs {
            let contents = content as? PageContentViewController        // 追加コード★★★
            contents?.setBackGroundColor(soundSetting: soundSetting)
            contents?.test1()
            contents?.test2(soundSetting: soundSetting)
            // 2018/09/18 r-azuma soundSettingを使う場合
            // viewWillAppearのtest1()とtest2()は復活させる。
            // 上のcontents?.test1()とcontents?.test2(soundSetting: soundSetting)はいらない代わりに
            // contents?.soundSetting = soundSetting
            // を設定してやる。
            print("テストデリゲート: \(contents)")
        }
    }

    
}   // class()を閉じる
