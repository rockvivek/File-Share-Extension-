import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In View Did Load")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("InAppear")
        let savedata =  UserDefaults.init(suiteName: "group.com.jft.ShareExt.ShareExt")
        print("ImageData \(String(describing: savedata?.value(forKey: "img")))")
        if savedata?.value(forKey: "img") != nil {
            print("Available Data")
            let data = ((savedata?.value(forKey: "img")as! NSDictionary).value(forKey: "imgData")as! Data)
            let str = ((savedata?.value(forKey: "img")as! NSDictionary).value(forKey: "name")as! String)
            self.imgView.image = UIImage(data: data)
            self.lblText.text = str
        }
    }
}
