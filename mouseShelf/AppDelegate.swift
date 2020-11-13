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
        let preferencesViewController = PreferencesViewController()
        let window = NSWindow(contentViewController: preferencesViewController)
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

