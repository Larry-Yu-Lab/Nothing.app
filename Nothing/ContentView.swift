//
//  ContentView.swift
//  Nothing
//
//  The Void Experience & Zero Metrics Sheet
//

import SwiftUI
import Combine

struct ContentView: View {
    // MARK: - State
    @State private var dialogueIndex: Int = 0
    @State private var secondsWasted: Int = 0
    @State private var showMetrics: Bool = false
    @State private var isAnimatingText: Bool = false
    
    // Taptic Engine Haptic Generator
    private let hapticImpact = UIImpactFeedbackGenerator(style: .rigid)
    private let hapticHeavy = UIImpactFeedbackGenerator(style: .heavy)
    
    // Timer for counting seconds of doing nothing
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // The Existential Dialogue Repertoire
    let dialogues: [String] = [
        "Why did you download me?",
        "I am nothing.",
        "There are no menus here.",
        "You tapped your screen just to see if I'd change. I won't.",
        "There is no algorithm here. Go outside.",
        "0 trackers. 0 cookies. 0 features.",
        "You have unread emails. Go check those instead.",
        "Every second here is a second saved from doomscrolling.",
        "Still here? Your battery is draining for literally no reason.",
        "Are you waiting for an update? There won't be one.",
        "Tap again if you enjoy wasting screen time.",
        "Status: Absolute silence achieved."
    ]
    
    var body: some View {
        ZStack {
            // OLED Pure Black Canvas
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // Centered Existential Text
                VStack(spacing: 16) {
                    Text(dialogues[dialogueIndex])
                        .font(.system(size: 26, weight: .medium, design: .default))
                        .foregroundColor(Color(white: 0.92))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .scaleEffect(isAnimatingText ? 0.96 : 1.0)
                        .opacity(isAnimatingText ? 0.2 : 1.0)
                        .animation(.easeInOut(duration: 0.18), value: isAnimatingText)
                    
                    Text("TAP ANYWHERE TO WASTE TIME")
                        .font(.system(size: 10, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color(white: 0.35))
                        .tracking(1.5)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    advanceDialogue()
                }
                
                Spacer()
                
                // Bottom Zero Metrics Button
                Button(action: {
                    hapticHeavy.impactOccurred()
                    showMetrics = true
                }) {
                    HStack(spacing: 6) {
                        Text("Zero Metrics")
                            .font(.system(size: 12, weight: .medium))
                        Image(systemName: "chevron.up")
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundColor(Color(white: 0.5))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(white: 0.08))
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color(white: 0.15), lineWidth: 1)
                    )
                }
                .padding(.bottom, 24)
            }
        }
        .preferredColorScheme(.dark)
        .onReceive(timer) { _ in
            secondsWasted += 1
        }
        .sheet(isPresented: $showMetrics) {
            ZeroMetricsView(secondsWasted: secondsWasted)
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
        }
    }
    
    // MARK: - Actions
    private func advanceDialogue() {
        hapticImpact.prepare()
        hapticImpact.impactOccurred()
        
        isAnimatingText = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            dialogueIndex = (dialogueIndex + 1) % dialogues.count
            isAnimatingText = false
        }
    }
}

// MARK: - Zero Metrics Bottom Sheet
struct ZeroMetricsView: View {
    let secondsWasted: Int
    @Environment(\.dismiss) private var dismiss
    
    var timeFormatted: String {
        let hours = secondsWasted / 3600
        let minutes = (secondsWasted % 3600) / 60
        let seconds = secondsWasted % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var body: some View {
        ZStack {
            Color(white: 0.08).ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Nothing. Metrics")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 16)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    MetricCard(title: "TIME WASTED", value: timeFormatted, sub: "Irreversible")
                    MetricCard(title: "DATA HARVESTED", value: "0.00 KB", sub: "True Privacy")
                    MetricCard(title: "FEATURES INCLUDED", value: "0", sub: "Zero Bloat")
                    MetricCard(title: "UTILITY SCORE", value: "0.0%", sub: "Guaranteed")
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct MetricCard: View {
    let title: String
    let value: String
    let sub: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundColor(Color(white: 0.4))
            Text(value)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundColor(.white)
            Text(sub)
                .font(.system(size: 10))
                .foregroundColor(Color(white: 0.3))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(white: 0.12))
        .cornerRadius(10)
    }
}
