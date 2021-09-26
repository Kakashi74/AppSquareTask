
import Foundation
import UIKit
import AudioToolbox

//MARK:- String
extension String
{
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

//MARK:- UIView 
public extension UIView {
    /// loads a full view from a xib file
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIView>() -> T {
            return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
        }
        return instantiateFromNib()
    }
}


public extension UIView {
    @IBInspectable var isCircled: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.cornerRadius = self.bounds.height / 2
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

extension UIView {
    func shake() {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.8
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        layer.add(animation, forKey: "shake")
    }
    
    func HideKeyboard() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Dissmiskeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func Dissmiskeyboard(){
        self.endEditing(true)
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension UIViewController {
    
    func poshWithoutData (identifire : String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifire)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func poshWithoutDataAndAnimation (identifire : String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifire)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    func poshWithData <T:UIViewController>(identifire : String , myView : T.Type ,completion:@escaping (T?) -> Void) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifire) as! T?
        completion(vc)
        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    func popVC () {
        navigationController?.popViewController(animated: true)
    }
    
    func present (identifire : String ) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifire)
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(vc!,animated: true, completion: nil)
    }
    
    func dismiss () {
        dismiss(animated: true, completion: nil)
    }
    
    func changeRoot (identifire : String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: identifire)
        self.view.window?.rootViewController = vc
    }
    
    @objc func dismissKeyboard () {
        view.endEditing(true)
    }
    
    
}
