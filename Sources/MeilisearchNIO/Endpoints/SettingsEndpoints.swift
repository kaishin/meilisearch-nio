import Foundation
import NIOHTTP1
import NIO
import AsyncHTTPClient

extension MeilisearchClient {
  public func getSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> Settings {
    try await send(
      .indexes / indexID / .settings,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSettings(
    with setting: Settings,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings,
      post(body: setting),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetSettings(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Synonyms
extension MeilisearchClient {
  public func getSynonyms(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String: [String]] {
    try await send(
      .indexes / indexID / .settings / .synonyms,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSynonyms(
    _ synonyms: [String: [String]],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .synonyms,
      post(body: synonyms),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetSynonyms(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .synonyms,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Stop Words
extension MeilisearchClient {
  public func getStopWords(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .stopWords,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateStopWords(
    _ words: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .stopWords,
      post(body: words),
      on: eventLoop
    )
  }

  public func resetStopWords(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .stopWords,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Ranking Rules
extension MeilisearchClient {
  public func getRankingRules(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .rankingRules,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateRankingRules(
    _ rules: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .rankingRules,
      post(body: rules),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetRankingRules(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .rankingRules,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Distinct Attribute
extension MeilisearchClient {
  public func getDistinctAttribute(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> String? {
    try await send(
      .indexes / indexID / .settings / .distinctAttribute,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateDistinctAttribute(
    _ attribute: String,
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .distinctAttribute,
      post(body: DistinctAttributePayload(distinctAttribute: attribute)),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetDistinctAttribute(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .distinctAttribute,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Searchable Attributes
extension MeilisearchClient {
  public func getSearchableAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .searchableAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSearchableAttributes(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .searchableAttributes,
      post(body: attributes),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetSearchableAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .searchableAttributes,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Displayed Attributes
extension MeilisearchClient {
  public func getDisplayedAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .displayedAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateDisplayedAttributes(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .displayedAttributes,
      post(body: attributes),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetDisplayedAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .displayedAttributes,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Filterable Attributes
extension MeilisearchClient {
  public func getFilterableAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .filterableAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateFilterableAttributes(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .filterableAttributes,
      post(body: attributes),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetFilterableAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .filterableAttributes,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}

// MARK: - Sortable Attributes
extension MeilisearchClient {
  public func getSortableAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> [String] {
    try await send(
      .indexes / indexID / .settings / .sortableAttributes,
      on: eventLoop
    )
  }

  @discardableResult
  public func updateSortableAttributes(
    _ attributes: [String],
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .sortableAttributes,
      post(body: attributes),
      on: eventLoop
    )
  }

  @discardableResult
  public func resetSortableAttributes(
    for indexID: String,
    on eventLoop: EventLoop? = nil
  ) async throws -> MeiliTask {
    try await send(
      .indexes / indexID / .settings / .sortableAttributes,
      requestMethod(.DELETE),
      on: eventLoop
    )
  }
}
