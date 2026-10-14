import SwiftUI

struct ContentView: View {

    @State private var dragStart: CGPoint = .zero
    @State private var dragOffset: CGSize = .zero
    @State private var targetOffset: CGSize = .zero

    private let imageSize: CGFloat = 230
    private let influenceRadius: CGFloat = 180

    var body: some View {

        Image("Ditto")
            .resizable()
            .scaledToFit()
            .frame(
                width: imageSize,
                height: imageSize
            )
            .distortionEffect(
                ShaderLibrary.jelly(
                    .float2(
                        Float(imageSize),
                        Float(imageSize)
                    ),
                    .float2(
                        Float(dragStart.x),
                        Float(dragStart.y)
                    ),
                    .float2(
                        Float(dragOffset.width*2.5),
                        Float(-dragOffset.height*2.5)
                    ),
                    .float(Float(influenceRadius))
                ),
                maxSampleOffset: CGSize(
                    width: influenceRadius,
                    height: influenceRadius
                )
            )
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        dragStart = CGPoint(
                            x: value.startLocation.x,
                            y: imageSize - value.startLocation.y
                        )

                        targetOffset = value.translation

                        withAnimation(.interactiveSpring(
                            response: 0.25,
                            dampingFraction: 0.8,
                            blendDuration: 0.15
                        )) {
                            dragOffset = targetOffset
                        }
                    }
                    .onEnded { _ in
                        targetOffset = .zero

                        withAnimation(.spring(
                            response: 0.5,
                            dampingFraction: 0.65
                        )) {
                            dragOffset = .zero
                        }
                    }
            )
    }
}
