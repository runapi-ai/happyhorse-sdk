# frozen_string_literal: true

require "runapi/core"
require_relative "happyhorse/types"
require_relative "happyhorse/contract_gen"
require_relative "happyhorse/resources/edit_video"
require_relative "happyhorse/resources/image_to_video"
require_relative "happyhorse/resources/text_to_video"
require_relative "happyhorse/client"

module RunApi
  module HappyHorse
    AuthenticationError = RunApi::Core::AuthenticationError
    RateLimitError = RunApi::Core::RateLimitError
    InsufficientCreditsError = RunApi::Core::InsufficientCreditsError
    NotFoundError = RunApi::Core::NotFoundError
    ValidationError = RunApi::Core::ValidationError
    TaskFailedError = RunApi::Core::TaskFailedError
    TaskTimeoutError = RunApi::Core::TaskTimeoutError
  end
end
