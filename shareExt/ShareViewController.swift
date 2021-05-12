import UIKit
import Social
import MobileCoreServices

///share view controller
class ShareViewController: SLComposeServiceViewController {
    
    var imageType = ""
    override func isContentValid() -> Bool {
        return true
    }
    
    //MARK:- did select post
    override func didSelectPost() {
        print("In Did Post")
        if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem{
            print("Item \(item)")
            for ele in item.attachments!{
                print("item.attachments!======&gt;&gt;&gt; \(ele as! NSItemProvider)")
                let itemProvider = ele as! NSItemProvider
                print(itemProvider)
                if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg"){
                    imageType = "public.jpeg"
                }
                if itemProvider.hasItemConformingToTypeIdentifier("public.png"){
                    imageType = "public.png"
                }
                print("imageType\(imageType)")
                
                if itemProvider.hasItemConformingToTypeIdentifier(imageType){
                    print("True")
                    itemProvider.loadItem(forTypeIdentifier: imageType, options: nil, completionHandler: { (item, error) in
                        
                        var imgData: Data!
                        if let url = item as? URL{
                            imgData = try! Data(contentsOf: url)
                        }
                        
                        if let img = item as? UIImage{
                            imgData = img.pngData()
                        }
                        print("Item ===\(item)")
                        print("Image Data=====. \(imgData))")
                        let dict: [String : Any] = ["imgData" :  imgData, "name" : self.contentText]
                        let savedata =  UserDefaults.init(suiteName: "group.com.YourAppBundleID")
                        savedata?.set(dict, forKey: "img")
                        savedata?.synchronize()
                        print("ImageData \(String(describing: savedata?.value(forKey: "img")))")
                    })
                }
            }
            
        }
    }
}
