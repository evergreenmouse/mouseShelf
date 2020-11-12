//
//  AppDelegate.swift
//  mouseShelf
//
//  Created by Александр Ополовников on 12.11.2020.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var firstMenuItem: NSMenuItem!
    
    var statusItem: NSStatusItem?
    var generateView: GenerateView?

    func applicationDidFinishLaunching(_ aNotification: Notification) { }

    func applicationWillTerminate(_ aNotification: Notification) { }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        UserDefaults.standard.removeObject(forKey: "com.user.rootCatalog")
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        let itemImage = NSImage(named: "clock")
        itemImage?.isTemplate = true
        statusItem?.button?.image = itemImage
        
        if let menu = menu {
            statusItem?.menu = menu
            menu.delegate = self
        }
    }
    
    @IBAction func showPreferences(_ sender: Any) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: .init(stringLiteral: "preferencesID")) as? PreferencesViewController else { return }

        let check = PreferencesViewController()
        let window = NSWindow(contentViewController: check)
        window.makeKeyAndOrderFront(nil)
    }
    
    private func prepareForItemShow() {
        if let _ = firstMenuItem {

        }
    }
    
}

extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        prepareForItemShow()
    }
}

