//
//  CaseIterable+Next.swift
//  
//
//  Created by Yaroslav Babalich on 18.09.2022.
//

public extension CaseIterable where Self: Equatable {

    mutating func next() {
        let allCases = Self.allCases
        // just a sanity check, as the possibility of a enum case to not be
        // present in `allCases` is quite low
        guard let selfIndex = allCases.firstIndex(of: self) else { return }
        let nextIndex = Self.allCases.index(after: selfIndex)
        self = allCases[nextIndex == allCases.endIndex ? allCases.startIndex : nextIndex]
    }
}

