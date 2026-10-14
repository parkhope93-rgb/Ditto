//
//  AppDelegate.swift
//  MyApp
//
//  Created by 박소망 on 10/14/26.
//

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow?

    func applicationDidFinishLaunching(
        _ notification: Notification
    ) {

        guard let screen = NSScreen.main else {
            return
        }

        // 메타몽 윈도우 크기
        let size = NSSize(
            width: 250,
            height: 250
        )

        // 화면 오른쪽 아래에 배치
        let origin = NSPoint(
            x: screen.visibleFrame.maxX - size.width - 40,
            y: screen.visibleFrame.minY + 40
        )

        let frame = NSRect(
            origin: origin,
            size: size
        )

        // 테두리 없는 윈도우
        let window = NSWindow(
            contentRect: frame,
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )

        // 배경 투명화
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.isMovableByWindowBackground = true

        // 다른 일반 윈도우와 같은 표시 레벨
        window.level = .normal

        // 여러 데스크톱 공간에서 표시
        window.collectionBehavior = [
            .canJoinAllSpaces,
            .fullScreenAuxiliary
        ]

        // 메타몽 이미지 표시
        let hostingView = NSHostingView(
            rootView: ContentView()
                .frame(
                    width: size.width,
                    height: size.height
                )
        )

        window.contentView = hostingView

        // 윈도우 표시
        window.orderFrontRegardless()

        self.window = window
    }
}
