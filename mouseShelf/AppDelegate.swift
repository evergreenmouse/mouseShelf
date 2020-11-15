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
    
    var isReadyToShowCreatingView = true

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
    
    func configureMenu() {
        
            
        
    }
    
    @IBAction func showPreferences(_ sender: Any) {
        let preferencesViewController = PreferencesViewController()
        let window = NSWindow(contentViewController: preferencesViewController)
        window.makeKeyAndOrderFront(nil)
    }
    
    private func prepareForItemShow(item: NSMenuItem) {
        
    }
    
    private func showEmptyView(item: NSMenuItem) {
        let emptyView = EmptySettingsView(frame: NSRect(x: 0, y: 0, width: 276, height: 112))
        item.view = emptyView
    }
    
    private func showCreateView(item: NSMenuItem) {
        let createView = GenerateView(frame: NSRect(x: 0, y: 0, width: 276, height: 92))
        
        item.view = createView
    }
    
}

extension AppDelegate: NSMenuDelegate {
    func menuWillOpen(_ menu: NSMenu) {
        guard let _ = DataStorageService.instanse.fetchUserRootCatalog(),
              let _ = DataStorageService.instanse.fetchUserFolderStructure() else {
            isReadyToShowCreatingView = false
            return
        }
        isReadyToShowCreatingView = true
        
        if let item = firstMenuItem {
            if isReadyToShowCreatingView {
                showCreateView(item: item)
            } else {
                showEmptyView(item: item)
            }
        }
    }
}

