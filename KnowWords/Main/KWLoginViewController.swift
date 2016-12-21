//
//  KWLoginViewController.swift
//  KnowWords
//
//  Created by 一折 on 2016/12/20.
//  Copyright © 2016年 yizhe. All rights reserved.
//

import UIKit

class KWLoginViewController: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDefault()
        self.view.backgroundColor = inf.backColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefault(){
        if kwdata.object(forKey: "username") != nil{
            self.username.text = kwdata.object(forKey: "username") as?String
            self.password.text = kwdata.object(forKey: "password") as?String
        }
    }
    
    @IBAction func login(_ sender: Any) {
        guard !(self.username.text?.isEmpty)! && !(self.password.text?.isEmpty)! else {
            self.showHud(message: "请输入完整的用户名密码", confirm: "确定")
            return
        }
        netTool.login(username: self.username.text!, password: self.password.text!){
            let tab = self.storyboard?.instantiateViewController(withIdentifier: "KWMainViewController")
            self.present(tab!, animated: true, completion: nil)
        }
    }
    
    func showHud(message:String, confirm:String="", cancel:String=""){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        if !confirm.isEmpty{
            let confirmAction = UIAlertAction(title: confirm, style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(confirmAction)
        }
        if !cancel.isEmpty{
            let cancelAction = UIAlertAction(title: cancel, style: .default, handler: {
                _ in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(cancelAction)
        }
        self.present(alertController, animated: true, completion: nil)
        return
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
