/// Swap the documents, settings, and task history of two or more indexes. 
/// You can only swap indexes in pairs. However, a single request can swap as many index pairs as you wish.
/// Swapping indexes is an atomic transaction: either all indexes are successfully swapped, or none are.
/// Swapping indexA and indexB will also replace every mention of indexA by indexB and vice-versa in the task history. 
/// `enqueued` tasks are left unmodified.
/// [Official Documentation](https://docs.meilisearch.com/learn/core_concepts/indexes.html#swapping-indexes)
public struct SwapIndexes: Codable, Hashable {
  public let indexes: [String]

  public func pair() throws -> (String, String) {
    guard
      indexes.count == 2
    else {
      throw MeilisearchNIOError.invalidSwapIndexes
    }

    return (indexes[0], indexes[1])
  }
}
