//
// Copyright © 2022 Future Mind. All rights reserved.
//

enum DefaultFontTrait {
    case extrathin
    case extrathinItalic
    case thin
    case thinItalic
    case light
    case lightItalic
    case regular
    case regularItalic
    case semibold
    case semiboldItalic
    case bold
    case boldItalic
    case extrabold
    case extraboldItalic
    case black
    case blackItalic
}

extension DefaultFontTrait: FontTrait {
    var slant: Double {
        switch self {
        case .extrathin, .thin, .light, .regular, .semibold, .bold, .extrabold, .black:
            return 0
        case .extrathinItalic, .thinItalic, .lightItalic, .regularItalic, .semiboldItalic, .boldItalic, .extraboldItalic, .blackItalic:
            return 1
        }
    }

    var weight: Double {
        switch self {
        case .extrathin, .extrathinItalic:
            return -0.9
        case .thin, .thinItalic:
            return -0.55
        case .light, .lightItalic:
            return -0.3
        case .regular, .regularItalic:
            return 0
        case .semibold, .semiboldItalic:
            return 0.25
        case .bold, .boldItalic:
            return 0.5
        case .extrabold, .extraboldItalic:
            return 0.62
        case .black, .blackItalic:
            return 0.8
        }
    }
}
