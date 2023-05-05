//
//  ViewController.swift
//  Kenny'yiYakala
//
//  Created by 'toMAC on 5.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //tanımlamalar
    var timer = Timer()
    var counter = 0
    var scr = 0
    var kennyArray = [UIImageView]()
    var hiddenkedy = Timer()
    var highScore = 0
    var saniye : Double = 0.0

    //kedy resimlerin hepsini tanımladık
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var kedy1: UIImageView!
    @IBOutlet weak var kedy2: UIImageView!
    @IBOutlet weak var kedy3: UIImageView!
    @IBOutlet weak var kedy4: UIImageView!
    @IBOutlet weak var kedy5: UIImageView!
    @IBOutlet weak var kedy6: UIImageView!
    @IBOutlet weak var kedy7: UIImageView!
    @IBOutlet weak var kedy8: UIImageView!
    @IBOutlet weak var kedy9: UIImageView!
    @IBOutlet weak var highsc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Kayıtlı olabilmesi için anahtar değerindeki metni tanımladık
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        //eğer başlangıçta highscor tablosunun bir değeri yok ise 0 yazdık
        if storedHighScore == nil {
            highScore = 0
            highsc.text = "HighScore \(highScore)"
        }
        
        //Eğer highscore tanımlanacak bir değer geliyorsa yani int geliyorsa
        //Highscore değerini göstererek açıl
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highsc.text = "HighScore: \(highScore)"
        }
        
        //view açılışında scr a değerini atatık
        score.text = "Score: \(scr)"
        
        //kedy resimlerin hepsini görünür yaptık
        kedy1.isUserInteractionEnabled = true
        kedy2.isUserInteractionEnabled = true
        kedy3.isUserInteractionEnabled = true
        kedy4.isUserInteractionEnabled = true
        kedy5.isUserInteractionEnabled = true
        kedy6.isUserInteractionEnabled = true
        kedy7.isUserInteractionEnabled = true
        kedy8.isUserInteractionEnabled = true
        kedy9.isUserInteractionEnabled = true
        
        //9 tane dokunma jest hareketleri tanımladık
        //Bunların görevleri dokununca myscore fonksiyonlarını çağırmak
        let gestureRec1 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec2 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec3 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec4 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec5 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec6 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec7 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec8 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        let gestureRec9 = UITapGestureRecognizer(target: self, action: #selector(myscore))
        
        //kedy resimlerine uygun jest hareketlerini tanımladık
        kedy1.addGestureRecognizer(gestureRec1)
        kedy2.addGestureRecognizer(gestureRec2)
        kedy3.addGestureRecognizer(gestureRec3)
        kedy4.addGestureRecognizer(gestureRec4)
        kedy5.addGestureRecognizer(gestureRec5)
        kedy6.addGestureRecognizer(gestureRec6)
        kedy7.addGestureRecognizer(gestureRec7)
        kedy8.addGestureRecognizer(gestureRec8)
        kedy9.addGestureRecognizer(gestureRec9)

        //kedy resimleri arry formatına koyduk
        //bunu yapma nedenimiz resimleri tek tek dönmemiz gerekiyordu
        kennyArray = [kedy1,kedy2,kedy3,kedy4,kedy5,kedy6,kedy7,kedy8,kedy9]

        //başlangıç view inde sayacı 10 dan başlattık
        counter = 10
        
        //başlangıç viewinde sayaç değerini ilgili alana yazdırdık
        time.text = String(counter)
        
        //Oyun zamanı için genel bir timer tanımladık
        //Bu timer 1 saniyede bir timerUp fonksiyonu çağırıyor
        //timerUp fonksiyonun görevi sayacı bir düşürüp bunu sayaçın olduğu alana yazmak ve 1 saniyede bir çalışıyor
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUp), userInfo: nil, repeats: true)
        
        //random değerleri zaman boyunca değerini değiştirmek için zamanlayıcı ekledik
        //her 0.5 saniyede bir zamanlayıcı kedyHidden fonksiyonu çağırıyor
        /*kedyHidden fonksiyonu sıraya
        - for ile kedy arryini gezdi
        - tüm kedy görsellerini hidden yaptı
        - random değer fonksiyonunu çağırdı
        - random değeri int değere çevirdi
        - kedy arrayinden random değerden bir değer çağırıp gizliden çıkarttı
        - ve bu şekilde her 0.5 sn de bu fonk çalıştığından 0.5 sn de bir bir alanda kedi görseli gözüktü random şekilde
         */
        
        hiddenkedy = Timer.scheduledTimer(timeInterval: saniye, target: self, selector: #selector(kedyHidden), userInfo: nil, repeats: true)
        
    }
    
    @objc func kedyHidden(){
        for keddy in kennyArray{
            keddy.isHidden = true
        }
        
        let random =  Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    @objc func timerUp(){
        counter -= 1
        time.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hiddenkedy.invalidate()
            
            for keddy in kennyArray{
                keddy.isHidden = true
            }
            
            //süre bittikten sonra
            //Eğer scr highscore dan yüksek ise bu alana giriyoruz
            /*
             highscoru normal skor ile eşitledik
             bunu highscore tablosuna yazdık
             UserDefault ile tek girişli kayıt işlemi yaptık
             anahtar değeri highscore yaptık
             */
            if self.scr > highScore {
                self.highScore = self.scr
                highsc.text = "HighScore: \(highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            //Alert
            //bu uyarı zamanlıyıcı 0 olduğunda geliyor
            let alert = UIAlertController(title: "Time's up", message: "Tekrar Denemek İster misin" , preferredStyle: UIAlertController.Style.alert)
            
            //alert geldikten sonra aktif bir button tanımladık
            //ok dedikten sonra alert sayesinde scre fonksiyonu çağırıyoruz
            // scr fonksiyonu sıkoru sıfırlıyor
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { UIAlertAction in
                //ok diyince
                self.scre()
            }
            
            //alert geldikten sonra oyunu tekrar oynamak için bir button tanımladık
            // rep dedikten sonra alert sayesinde rep fonksiyonu çağırıyoruz
            // rep fonksiyonu sayesinde en yüksek değer kayıt ediliyor ve sıkor sıfırlanıp oyun tekrar başlıyor
            let repButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in //replay basınca bir şey olmasını istiyoruz
                // replay func
                self.scr = 0
                self.score.text = "Score: \(self.scr)"
                
                self.counter = 10
                self.time.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerUp), userInfo: nil, repeats: true)
                self.hiddenkedy = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.kedyHidden), userInfo: nil, repeats: true)
                
            }
            
            //alert içine bu iki butonu tanımladık. Yan yana durmaya başladılar
            alert.addAction(okButton)
            alert.addAction(repButton)
            
            //bu view için alertleri aktif ettik ve animasyonu açtık
            self.present(alert,animated: true,completion: nil)
        }
    }

    @objc func myscore(){
        scr += 1
        score.text = "Score: \(scr)"
    }

    func scre(){
        scr = 0
        score.text = "Score \(scr)"
    }
    
   
}

