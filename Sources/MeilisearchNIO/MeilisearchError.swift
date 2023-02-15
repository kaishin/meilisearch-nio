import Foundation

public enum MeilisearchNIOError: Error, Hashable{
  case missingConfiguration(String)
  case missingResponseData
  case malformedRequestURL
  case serverNotFound
  case invalidHost
  case invalidJSON
  case invalidSwapIndexes
  case timeOut(timeOut: Double)
}

public struct ErrorResponse: Error, Codable, Hashable {
  public enum Code: String, Codable, Hashable {
    case apiKeyNotFound = "api_key_not_found"
    case badParameter = "bad_parameter"
    case badRequest = "bad_request"
    case databaseSizeLimitReached = "database_size_limit_reached"
    case documentNotFound = "document_not_found"
    case dumpAlreadyProcessing = "dump_already_processing"
    case dumpNotFound = "dump_not_found"
    case dumpProcessFailed = "dump_process_failed"
    case immutableApiKeyActions = "immutable_api_key_actions"
    case immutableApiKeyIndexes = "immutable_api_key_indexes"
    case immutableApiKeyUid = "immutable_api_key_uid"
    case immutableCreatedAt = "immutable_created_at"
    case immutableExpiresAt = "immutable_expires_at"
    case immutableIndexCreatedAt = "immutable_index_created_at"
    case immutableIndexUid = "immutable_index_uid"
    case immutableIndexUpdatedAt = "immutable_index_updated_at"
    case immutableUpdatedAt = "immutable_updated_at"
    case indexAlreadyExists = "index_already_exists"
    case indexCreationFailed = "index_creation_failed"
    case indexNotFound = "index_not_found"
    case indexPrimaryKeyAlreadyPresent = "index_primary_key_already_present"
    case internalError = "internal_error"
    case invalidApiKey = "invalid_api_key"
    case invalidApiKeyActions = "invalid_api_key_actions"
    case invalidApiKeyDescription = "invalid_api_key_description"
    case invalidApiKeyExpiresAt = "invalid_api_key_expires_at"
    case invalidApiKeyIndexes = "invalid_api_key_indexes"
    case invalidApiKeyLimit = "invalid_api_key_limit"
    case invalidApiKeyOffset = "invalid_api_key_offset"
    case invalidContentType = "invalid_content_type"
    case invalidDocumentFields = "invalid_document_fields"
    case invalidDocumentGeoField = "invalid_document_geo_field"
    case invalidDocumentId = "invalid_document_id"
    case invalidDocumentLimit = "invalid_document_limit"
    case invalidDocumentOffset = "invalid_document_offset"
    case invalidIndexLimit = "invalid_index_limit"
    case invalidIndexOffset = "invalid_index_offset"
    case invalidIndexPrimaryKey = "invalid_index_primary_key"
    case invalidIndexUid = "invalid_index_uid"
    case invalidSearchAttributesToCrop = "invalid_search_attributes_to_crop"
    case invalidSearchAttributesToHighlight = "invalid_search_attributes_to_highlight"
    case invalidSearchAttributesToRetrieve = "invalid_search_attributes_to_retrieve"
    case invalidSearchCropLength = "invalid_search_crop_length"
    case invalidSearchCropMarker = "invalid_search_crop_marker"
    case invalidSearchFacets = "invalid_search_facets"
    case invalidSearchFilter = "invalid_search_filter"
    case invalidSearchHighlightPostTag = "invalid_search_highlight_post_tag"
    case invalidSearchHighlightPreTag = "invalid_search_highlight_pre_tag"
    case invalidSearchHitsPerPage = "invalid_search_hits_per_page"
    case invalidSearchLimit = "invalid_search_limit"
    case invalidSearchMatchingStrategy = "invalid_search_matching_strategy"
    case invalidSearchOffset = "invalid_search_offset"
    case invalidSearchPage = "invalid_search_page"
    case invalidSearchQ = "invalid_search_q"
    case invalidSearchShowMatchesPosition = "invalid_search_show_matches_position"
    case invalidSearchSort = "invalid_search_sort"
    case invalidSettingsDisplayedAttributes = "invalid_settings_displayed_attributes"
    case invalidSettingsDistinctAttributes = "invalid_settings_distinct_attributes"
    case invalidSettingsFaceting = "invalid_settings_faceting"
    case invalidSettingsFilterableAttributes = "invalid_settings_filterable_attributes"
    case invalidSettingsPagination = "invalid_settings_pagination"
    case invalidSettingsRankingRules = "invalid_settings_ranking_rules"
    case invalidSettingsSearchableAttributes = "invalid_settings_searchable_attributes"
    case invalidSettingsSortableAttributes = "invalid_settings_sortable_attributes"
    case invalidSettingsStopWords = "invalid_settings_stop_words"
    case invalidSettingsSynonyms = "invalid_settings_synonyms"
    case invalidSettingsTypoTolerance = "invalid_settings_typo_tolerance"
    case invalidState = "invalid_state"
    case invalidStoreFile = "invalid_store_file"
    case invalidSwapDuplicateIndexFound = "invalid_swap_duplicate_index_found"
    case invalidSwapIndexes = "invalid_swap_indexes"
    case invalidTaskAfterEnqueuedAt = "invalid_task_after_enqueued_at"
    case invalidTaskAfterFinishedAt = "invalid_task_after_finished_at"
    case invalidTaskAfterStartedAt = "invalid_task_after_started_at"
    case invalidTaskBeforeEnqueuedAt = "invalid_task_before_enqueued_at"
    case invalidTaskBeforeFinishedAt = "invalid_task_before_finished_at"
    case invalidTaskBeforeStartedAt = "invalid_task_before_started_at"
    case invalidTaskCanceledBy = "invalid_task_canceled_by"
    case invalidTaskFilters = "invalid_task_filters"
    case invalidTaskFrom = "invalid_task_from"
    case invalidTaskIndexUids = "invalid_task_index_uids"
    case invalidTaskLimit = "invalid_task_limit"
    case invalidTaskStatuses = "invalid_task_statuses"
    case invalidTaskTypes = "invalid_task_types"
    case invalidTaskUids = "invalid_task_uids"
    case ioError = "io_error"
    case malformedPayload = "malformed_payload"
    case maxFieldsLimitExceeded = "max_fields_limit_exceeded"
    case missingApiKeyActions = "missing_api_key_actions"
    case missingApiKeyExpiresAt = "missing_api_key_expires_at"
    case missingApiKeyIndexes = "missing_api_key_indexes"
    case missingAuthorizationHeader = "missing_authorization_header"
    case missingContentType = "missing_content_type"
    case missingDocumentId = "missing_document_id"
    case missingIndexUid = "missing_index_uid"
    case missingMasterKey = "missing_master_key"
    case missingPayload = "missing_payload"
    case missingSwapIndexes = "missing_swap_indexes"
    case missingTaskFilters = "missing_task_filters"
    case noSpaceLeftOnDevice = "no_space_left_on_device"
    case payloadTooLarge = "payload_too_large"
    case primaryKeyInferenceFailed = "primary_key_inference_failed"
    case searchError = "search_error"
    case taskNotFound = "task_not_found"
    case tooManyOpenFiles = "too_many_open_files"
    case unretrievableDocument = "unretrievable_document"
    case unsupportedMediaType = "unsupported_media_type"
  }

  public enum ErrorType: String, Codable, Hashable {
    case invalidRequest = "invalid_request"
    case `internal`
    case auth
    case system
  }

  public let message: String
  public let code: Code
  public let type: ErrorType
  public let link: String
}
