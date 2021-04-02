import SwiftUI

public struct WHStack: View {
  
@usableFromInline var verticalAlignment: VerticalAlignment = .center
@usableFromInline var horizontalAlignment: HorizontalAlignment = .leading
@usableFromInline var spacing: CGFloat = 0
@usableFromInline let content: [AnyView]
@State private var height: CGFloat = 0

@usableFromInline init(_ verticalAlignment: VerticalAlignment?, _ horizontalAlignment: HorizontalAlignment?, _ spacing: CGFloat?, _ content: [AnyView]) {
  if let verticalAlignment = verticalAlignment {
    self.verticalAlignment = verticalAlignment
  }
  if let horizontalAlignment = horizontalAlignment {
    self.horizontalAlignment = horizontalAlignment
  }
  if let spacing = spacing {
    self.spacing = spacing
  }
  self.content = content
}

  // Work-around for https://bugs.swift.org/browse/SR-11628
@inlinable public init<Content: View>(verticalAlignment: VerticalAlignment? = nil, horizontalAlignment: HorizontalAlignment? = nil, spacing: CGFloat? = nil, content: () -> Content) {
    self.init(verticalAlignment, horizontalAlignment, spacing, [AnyView(content())])
  }

  @inlinable public init<Content: View>(verticalAlignment: VerticalAlignment? = nil, horizontalAlignment: HorizontalAlignment? = nil, spacing: CGFloat? = nil, content: () -> [Content]) {
    self.init(verticalAlignment, horizontalAlignment, spacing, content().map { AnyView($0) })
  }
  
  // Known issue: https://bugs.swift.org/browse/SR-11628
  @inlinable public init(verticalAlignment: VerticalAlignment? = nil, horizontalAlignment: HorizontalAlignment? = nil, spacing: CGFloat? = nil, @ViewArrayBuilder content: () -> [AnyView]) {
    self.init(verticalAlignment, horizontalAlignment, spacing, content())
  }
  
  public var body: some View {
    GeometryReader { p in
      WrapStack (
        width: p.frame(in: .global).width,
        verticalAlignment: self.verticalAlignment,
        horizontalAlignment: self.horizontalAlignment,
        spacing: self.spacing,
        content: self.content
      )
        .anchorPreference(
          key: SizePref.self,
          value: .bounds,
          transform: {
            p[$0].size
        }
      )
    }
    .frame(height: height)
    .onPreferenceChange(SizePref.self, perform: {
      self.height = $0.height
    })
  }
}

struct WHStack_Previews: PreviewProvider {
  
  @ViewArrayBuilder static func single() -> [AnyView] {
    Color.purple.frame(width: 50, height: 50)
  }
  
  static var previews: some View {
    ScrollView {
      VStack {
        Group {
          Text("Header")
          Spacer()
        }
        Group {
          WHStack { () -> [AnyView] in }

          // FIXME: https://bugs.swift.org/browse/SR-11628
          WHStack {
            Color.red
          }
        }
        Group {
          
          // FIXME: https://bugs.swift.org/browse/SR-11628
          WHStack(content: single)
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
            Color.orange.frame(width: 50, height: 50)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
            Color.orange.frame(width: 50, height: 50)
            Color.purple.frame(width: 50, height: 50)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
            Color.orange.frame(width: 50, height: 50)
            Color.purple.frame(width: 50, height: 50)
            Color.blue.frame(width: 50, height: 50)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
            Color.orange.frame(width: 50, height: 50)
            Color.purple.frame(width: 50, height: 50)
            Color.blue.frame(width: 50, height: 50)
            Color.black.frame(width: 50, height: 50)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
            Color.orange.frame(width: 50, height: 50)
            Color.purple.frame(width: 50, height: 50)
            Color.blue.frame(width: 50, height: 50)
            Color.black.frame(width: 50, height: 50)
            Color.pink.frame(width: 50, height: 50)
          }
          
          WHStack {
            Color.red
            Color.gray.frame(width: 80, height: 50)
            Color.green.frame(width: 150, height: 30)
            Color.yellow.frame(width: 150, height: 70)
            Color.orange.frame(width: 50, height: 50)
            Color.purple.frame(width: 50, height: 50)
            Color.blue.frame(width: 50, height: 50)
            Color.black.frame(width: 50, height: 50)
            Color.pink.frame(width: 50, height: 50)
            Color.white.frame(width: 50, height: 50)
          }
        }
        
        
        Group {
          WHStack(verticalAlignment: .bottom, spacing: 10) {[
            Color.red.frame(width: 100, height: 50),
            Color.gray.frame(width: 80, height: 50),
            Color.green.frame(width: 150, height: 30),
            Color.yellow.frame(width: 150, height: 70),
            Color.orange.frame(width: 50, height: 50),
            Color.purple.frame(width: 50, height: 50),
            Color.blue.frame(width: 50, height: 50),
            Color.black.frame(width: 50, height: 50),
            Color.pink.frame(width: 50, height: 50),
            Color.white.frame(width: 50, height: 50),
            ]}
            .frame(width: 350)
            .border(Color.black, width: 1)
        }
        Group {
          Spacer()
          Text("Footer")
        }
      }
    }
  }
}
