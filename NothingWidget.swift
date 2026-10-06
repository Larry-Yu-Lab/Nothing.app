//
//  NothingWidget.swift
//  NothingWidgetExtension
//
//  WidgetKit Extension providing Blank Negative Space & Minimalist Widgets
//

import WidgetKit
import SwiftUI

// MARK: - Timeline Provider
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        // Updates once daily
        let entries = [SimpleEntry(date: Date())]
        let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

// MARK: - Widget View
struct NothingWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            SmallNothingView()
        case .systemMedium:
            MediumNothingView()
        case .accessoryCircular:
            Text("0")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
        case .accessoryRectangular:
            VStack(alignment: .leading, spacing: 2) {
                Text("TODAY")
                    .font(.system(size: 9, weight: .bold))
                Text("Nothing scheduled.")
                    .font(.system(size: 12))
            }
        default:
            SmallNothingView()
        }
    }
}

// MARK: - Small Widget (nothing. or blank space)
struct SmallNothingView: View {
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .leading) {
                Text("WIDGET")
                    .font(.system(size: 8, weight: .bold, design: .monospaced))
                    .foregroundColor(Color(white: 0.3))
                Spacer()
                Text("nothing.")
                    .font(.system(size: 22, weight: .medium, design: .default))
                    .foregroundColor(.white)
                Text("today's agenda")
                    .font(.system(size: 11))
                    .foregroundColor(Color(white: 0.45))
            }
            .padding(14)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Medium Widget (Existential Agenda)
struct MediumNothingView: View {
    var body: some View {
        ZStack {
            Color.black
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("CALENDAR • NOTHING")
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(white: 0.4))
                    Spacer()
                    Text("ALL DAY")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(Color(white: 0.3))
                }
                
                HStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(white: 0.3))
                        .frame(width: 3, height: 32)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("No plans scheduled.")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Enjoy the peaceful silence of your empty screen.")
                            .font(.system(size: 11))
                            .foregroundColor(Color(white: 0.45))
                    }
                }
                Spacer()
            }
            .padding(14)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
    }
}

// MARK: - Main Widget Declaration
@main
struct NothingWidget: Widget {
    let kind: String = "NothingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NothingWidgetEntryView(entry: entry)
                .containerBackground(.black, for: .widget)
        }
        .configurationDisplayName("Nothing.")
        .description("Minimal negative space and zero-agenda aesthetic widgets.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular, .accessoryRectangular])
    }
}
