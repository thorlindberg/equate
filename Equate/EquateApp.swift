import SwiftUI

@main
struct EquateApp: App {
    
    let weights: [Equitable] = [
        Equitable(
            label: "kg", baseline: 0, modifier: 1
        ),
        Equitable(
            label: "lb", baseline: 0, modifier: 2.2046213
        ),
        Equitable(
            label: "st", baseline: 0, modifier: 0.157473044
        )
    ]
    
    let temperatures: [Equitable] = [
        Equitable(
            label: "°C", baseline: 0, modifier: 1
        ),
        Equitable(
            label: "°F", baseline: 32, modifier: 1.8
        ),
        Equitable(
            label: "°K", baseline: 273.15, modifier: 1
        )
    ]
    
    var body: some Scene {
        MenuBarExtra(
            "Equate",
            systemImage: "arrow.triangle.2.circlepath"
        ) {
            HStack(spacing: 15) {
                EquateView(
                    title: "Weight",
                    equitables: weights
                )
                EquateView(
                    title: "Temperature",
                    equitables: temperatures
                )
            }
            .padding(15)
        }
        .menuBarExtraStyle(.window)
    }
    
}

struct Equitable: Hashable {
    let label: String
    let baseline: Float
    let modifier: Float
}

struct EquateView: View {
    
    let title: String
    let equitables: [Equitable]
    
    @State var value: Float = 0
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 15 / 2
        ) {
            Text(title)
                .font(.footnote)
                .opacity(2 / 3)
            VStack(spacing: 15) {
                ForEach(equitables, id: \.self) { equitable in
                    MeasureView(
                        value: $value,
                        equitable: equitable
                    )
                }
            }
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(
                        Color(nsColor: .textColor).opacity(0.4),
                        lineWidth: 0.5
                    )
            )
            .background(Material.ultraThin)
            .cornerRadius(5)
            .shadow(
                color: .black.opacity(0.2),
                radius: 5, x: 0, y: 0
            )
        }
    }
    
}


struct MeasureView: View {
    
    @Binding var value: Float
    
    let equitable: Equitable
    var calculated: Float {
        equitable.baseline + value * equitable.modifier
    }
    
    var body: some View {
        HStack {
            TextField("0", text: Binding(
                get: { "\(calculated)" },
                set: {
                    value = $0.count < 10 ? ($0 as NSString).floatValue : value
                }
            ))
            .textFieldStyle(.plain)
            Text(equitable.label)
                .opacity(0.5)
        }

    }
    
}
