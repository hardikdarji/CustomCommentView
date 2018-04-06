# CustomCommentView

## Description:
Customized comment view, one can be used to manage add comments UI. Easy to apply in existing code with just initialization var and add it as subview.

## Sample:
![simulator screen shot - iphone 8 - 2018-04-05 at 17 08 19](https://user-images.githubusercontent.com/3232087/38364583-e3543358-38f6-11e8-94db-f9138429b94f.png)

## Demo:
![img_1374](https://user-images.githubusercontent.com/3232087/38365028-6fc5ec68-38f8-11e8-97c1-fa9bc39455a0.GIF)

### Requirements:
- Swift 4.0
- XCode 9.0
- iOS 10.0 (Min SDK)

## Usage:
```Swift
    class ViewController: UIViewController 
    {
        //DECLARATION
        var viewCommentView: CommentView = CommentView()

        override func viewDidLoad() {
            super.viewDidLoad()
            // ADD AS SUBVIEW, INIT SETUP AND LET DELEGATE OF COMMENTVIEW TO SELF
            self.view.addSubview(self.viewCommentView)
            self.viewCommentView.initCommentSetup(parentView: self.view)
            self.viewCommentView.delegate = self

        }
        // BUTTON TOUCH EVENT WHERE TO START COMMENT VIEW... WILL APPEAR WITH KEYBOARD AND COMMENT VIEW ABOEVE KEYBOARD...
        @objc func buttonCommentsTouched(sender:UIButton)
        {
            self.viewCommentView.startCommentView(tableView: self.tableViewComment!, sender: sender)
        }
    }

    // DELEGATE METHOD TO HANDLE SEND COMMENT AND DESELECT TABLEVIEW CELL...
    ViewController: handleCommentHeightDelegate{
    func commentSendCompletionHandler(isSuccess: Bool, indexPath: IndexPath?, commentText: String?) {
        if isSuccess
        {
            print("Success: ...)")
            // ADD COMMENT TO ARRAY...
            self.arrComment[(indexPath?.row)!].commentCount += 1
        }
        // DESELEC AND RELOAD ROW
        self.tableViewComment?.deselectRow(at: indexPath!, animated: true)
        self.tableViewComment?.reloadRows(at: [indexPath!], with: .automatic)
        self.view.layoutIfNeeded()
    }
}
```
## Author
hardikdarji: hardikdarji.mca@gmail.com

## License
CustomCommentView is available under the MIT license. See the LICENSE file for more info.
