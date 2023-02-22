import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  /// Get the settings of an index.
  ///
  /// SeeAlso: [Official Documentation](https://docs.meilisearch.com/reference/api/settings.html#all-settings)
  public func getSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Settings {
    try await send(
      .indexes / indexID / .settings,
      on: eventLoop
    )
  }

  /// Update the settings of an index.
  ///
  /// Passing null to an index setting will reset it to its default value.
  ///
  /// Updates in the settings route are partial. This means that any parameters not provided in the body will be left unchanged.
  ///
  /// SeeAlso: [Official Documentation](https://docs.meilisearch.com/reference/api/settings.html#all-settings)
  @discardableResult
  public func updateSettings(
    with setting: Settings,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings,
      on: eventLoop
    ) {
      patch(body: setting)
    }
  }

  /// Reset all the settings of an index to their default value.
  @discardableResult
  public func resetSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Faceting
extension MeilisearchClient {
  public func getFacetingSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Settings.Faceting {
    try await send(
      .indexes / indexID / .settings / .faceting,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateFacetingSettings(
    _ faceting: Settings.Faceting,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .faceting,
      on: eventLoop
    ) {
      patch(body: faceting)
    }
  }

  @discardableResult
  public func resetFacetingSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .faceting,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Pagination
extension MeilisearchClient {
  public func getPaginationSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Settings.Pagination {
    try await send(
      .indexes / indexID / .settings / .pagination,
      on: eventLoop
    )
  }

  @discardableResult
  public func updatePaginationSettings(
    _ pagination: Settings.Pagination,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .pagination,
      on: eventLoop
    ) {
      patch(body: pagination)
    }
  }

  @discardableResult
  public func resetPaginationSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .pagination,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Typo Tolerance
extension MeilisearchClient {
  public func getTypoToleranceSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Settings.TypoTolerance {
    try await send(
      .indexes / indexID / .settings / .typoTolerance,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateTypoToleranceSettings(
    _ typoTolerance: Settings.TypoTolerance,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .typoTolerance,
      on: eventLoop
    ) {
      patch(body: typoTolerance)
    }
  }

  @discardableResult
  public func resetTypoToleranceSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .typoTolerance,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Synonyms
extension MeilisearchClient {
  public func getSynonymsSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String: [String]] {
    try await send(
      .indexes / indexID / .settings / .synonyms,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSynonymsSettings(
    _ synonyms: [String: [String]],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .synonyms,
      on: eventLoop
    ) {
      put(body: synonyms)
    }
  }

  @discardableResult
  public func resetSynonymsSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .synonyms,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Stop Words
extension MeilisearchClient {
  public func getStopWordsSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .stopWords,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateStopWordsSettings(
    _ words: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .stopWords,
      on: eventLoop
    ) {
      put(body: words)
    }
  }

  public func resetStopWordsSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .stopWords,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Ranking Rules
extension MeilisearchClient {
  public func getRankingRulesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .rankingRules,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateRankingRulesSettings(
    _ rules: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .rankingRules,
      on: eventLoop
    ) {
      put(body: rules)
    }
  }

  @discardableResult
  public func resetRankingRulesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .rankingRules,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Distinct Attribute
extension MeilisearchClient {
  public func getDistinctAttributeSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> String? {
    try await send(
      .indexes / indexID / .settings / .distinctAttribute,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateDistinctAttributeSettings(
    _ attribute: String,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .distinctAttribute,
      on: eventLoop
    ) {
      put(body: Settings.DistinctAttribute(attribute))
    }
  }

  @discardableResult
  public func resetDistinctAttributeSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .distinctAttribute,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Searchable Attributes
extension MeilisearchClient {
  public func getSearchableAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .searchableAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSearchableAttributesSettings(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .searchableAttributes,
      on: eventLoop
    ) {
      put(body: attributes)
    }
  }

  @discardableResult
  public func resetSearchableAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .searchableAttributes,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Displayed Attributes
extension MeilisearchClient {
  public func getDisplayedAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .displayedAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateDisplayedAttributesSettings(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .displayedAttributes,
      on: eventLoop
    ) {
      put(body: attributes)
    }
  }

  @discardableResult
  public func resetDisplayedAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .displayedAttributes,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Filterable Attributes
extension MeilisearchClient {
  public func getFilterableAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .filterableAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateFilterableAttributesSettings(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .filterableAttributes,
      on: eventLoop
    ) {
      put(body: attributes)
    }
  }

  @discardableResult
  public func resetFilterableAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .filterableAttributes,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}

// MARK: - Sortable Attributes
extension MeilisearchClient {
  public func getSortableAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .sortableAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSortableAttributesSettings(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .sortableAttributes,
      on: eventLoop
    ) {
      put(body: attributes)
    }
  }

  @discardableResult
  public func resetSortableAttributesSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> OperationTask.Reference {
    try await send(
      .indexes / indexID / .settings / .sortableAttributes,
      on: eventLoop
    ) {
      requestMethod(.DELETE)
    }
  }
}
