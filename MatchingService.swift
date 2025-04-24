//
//  MatchingService.swift
//  LostAndFoundHub
//
//  Created by Purvang Khonde on 4/4/25.
//
//
//import Foundation
//
//class MatchingService {
//    
//    // Returns a list of found items that "match" a given lost item
//    static func findMatches(for lostItem: LostItem, in foundItems: [FoundItem]) -> [FoundItem] {
//        let lostTitle = lostItem.title?.lowercased() ?? ""
//        let lostDesc = lostItem.desc?.lowercased() ?? ""
//        let lostLocation = lostItem.location?.lowercased() ?? ""
//        
//        return foundItems.filter { found in
//            let foundTitle = found.title?.lowercased() ?? ""
//            let foundDesc = found.desc?.lowercased() ?? ""
//            let foundLocation = found.location?.lowercased() ?? ""
//            
//            let titleMatch = foundTitle.contains(lostTitle) || lostTitle.contains(foundTitle)
//            let locationMatch = foundLocation == lostLocation
//            let descOverlap = hasKeywordOverlap(lostDesc, foundDesc)
//            
//            return (titleMatch && locationMatch) || descOverlap
//        }
//    }
//    
//    // Returns true if there are any overlapping words between descriptions
//    private static func hasKeywordOverlap(_ desc1: String, _ desc2: String) -> Bool {
//        let words1 = Set(desc1.components(separatedBy: CharacterSet.whitespacesAndNewlines))
//        let words2 = Set(desc2.components(separatedBy: CharacterSet.whitespacesAndNewlines))
//        let overlap = words1.intersection(words2)
//        return !overlap.isEmpty
//    }
//}

// MatchingService.swift
// ————————————————————————————————

import Foundation

class MatchingService {

    /// Returns a scored list of found items that “match” a given lost item.
    static func findMatches(
        for lostItem: LostItem,
        in foundItems: [FoundItem],
        minimumScore: Double = 0.3
    ) -> [FoundItem] {
        // Prepare token sets
        let lostTitleWords = normalizeAndTokenize(lostItem.title)
        let lostDescWords  = normalizeAndTokenize(lostItem.desc)
        let lostLocation   = lostItem.location?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Score each candidate
        let scored: [(item: FoundItem, score: Double)] = foundItems.compactMap { found in
            guard let foundTitle  = found.title,
                  let foundDesc   = found.desc,
                  let foundLoc    = found.location
            else { return nil }

            let foundTitleWords = normalizeAndTokenize(foundTitle)
            let foundDescWords  = normalizeAndTokenize(foundDesc)
            let foundLocation   = foundLoc.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

            // 1. Location score (1 or 0)
            let locationScore: Double = (lostLocation == foundLocation && lostLocation != nil) ? 1.0 : 0.0

            // 2. Title similarity: intersection / union
            let titleOverlap = lostTitleWords.intersection(foundTitleWords)
            let titleUnion   = lostTitleWords.union(foundTitleWords)
            let titleScore   = titleUnion.isEmpty ? 0 : Double(titleOverlap.count) / Double(titleUnion.count)

            // 3. Description overlap
            let descOverlap = lostDescWords.intersection(foundDescWords)
            let descUnion   = lostDescWords.union(foundDescWords)
            let descScore   = descUnion.isEmpty ? 0 : Double(descOverlap.count) / Double(descUnion.count)

            // Weighted sum
            // You can tweak weights here:
            let score =  0.5 * locationScore
                       + 1.5 * titleScore
                       + 1.0 * descScore

            return (item: found, score: score)
        }

        // Filter + sort
        return scored
            .filter { $0.score >= minimumScore }
            .sorted { $0.score > $1.score }
            .map { $0.item }
    }

    /// Normalize a string into a set of “words” (lowercased, alpha-only, stopwords removed).
    private static func normalizeAndTokenize(_ input: String?) -> Set<String> {
        guard let input = input?.lowercased() else { return [] }
        // Remove punctuation, split on whitespace
        let words = input
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { $0.count >= 2 }   // drop 1-letter “a”, “I”
        return Set(words)
    }
}
