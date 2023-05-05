//
//  First.swift
//  Kenny'yiYakala
//
//  Created by 'toMAC on 6.02.2023.
//

import UIKit

class First: UIViewController {

    //Bu bölümde ilk ekrandan ikinci ekrana bilgi aktarımı yaptık
    
    /*
     - altaki kod ile bastığım butonların identifier değerine göre diğer sayfanın bilgilerini değiştiriyor
     - kolays komutu ViewController sayfasındaki saniyeyi 1.5 yapıyor
     - normals komutu ..... 1 yapıyor
     - zor komutu ...... 0.4 yapıyor
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "kolays" {
            let kly = segue.destination as! ViewController
            kly.saniye = 1.5
        }else if segue.identifier == "normals" {
            let kly = segue.destination as! ViewController
            kly.saniye = 1
        }else if segue.identifier == "zors" {
            let kly = segue.destination as! ViewController
            kly.saniye = 0.3
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    @IBAction func kolay(_ sender: Any) {
    }
    
    
    @IBAction func normal(_ sender: Any) {
    }
    
    
    @IBAction func zor(_ sender: Any) {
    }
    
    
}
