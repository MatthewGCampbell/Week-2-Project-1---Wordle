//
//  HapticsCoordinator.swift
//  Wordle
//
//  Created by Matthew Campbell on 8/31/25.
//


import UIKit

protocol Haptics {
    func primeForTyping()
    func keyTap()
    func invalidGuess()
    func submit()
    func revealTick()
    func win()
    func loose()
}


class HapticsCoordinator {
    private let tapImpact = UIImpactFeedbackGenerator(style: .light)
    private let submitImpact = UIImpactFeedbackGenerator(style: .medium)
    private let rigidImpact = UIImpactFeedbackGenerator(style: .rigid)
    private let selection = UISelectionFeedbackGenerator()
    private let notificaiton = UINotificationFeedbackGenerator()
    
    private var lastInvalidAt: TimeInterval = 0
    private let invalidCooldown: TimeInterval = 0.35
    
    func primeForTyping() {
        tapImpact.prepare()
    }
    
    func keyTap() {
        tapImpact.impactOccurred()
    }
    
    func invalidGuess() {
        let now = Date().timeIntervalSince1970
        if now - lastInvalidAt > invalidCooldown {
            rigidImpact.prepare()
            rigidImpact.impactOccurred()
            lastInvalidAt = now
        }
    }
    
    func submit() {
        submitImpact.prepare()
        submitImpact.impactOccurred()
    }
    
    func revealTick() {
        guard !UIAccessibility.isReduceMotionEnabled else { return }
        selection.selectionChanged()
    }
    
    func win() {
        notificaiton.notificationOccurred(.success)
    }
    
    func loose() {
        notificaiton.notificationOccurred(.error)
    }
    
}
