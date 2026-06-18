# frozen_string_literal: true

Dir.chdir(__dir__) do

  Gem::Specification.new do |spec|
    spec.name = "runapi-happyhorse"
    spec.version = "0.2.6"
    spec.authors = ["RunAPI"]
    spec.email = ["contact@runapi.ai"]

    spec.summary = "HappyHorse API Ruby SDK for RunAPI"
    spec.description = "The happyhorse ai api Ruby SDK is the language-specific package for HappyHorse on RunAPI. Use this package for text, image, and edit-video workflows that need JSON request bodies, task status lookup, and consistent RunAPI errors in Ruby."
    spec.homepage = "https://runapi.ai/models/happyhorse"
    spec.license = "Apache-2.0"
    spec.required_ruby_version = ">= 3.1.0"
    spec.metadata["homepage_uri"] = "https://runapi.ai/models/happyhorse"
    spec.metadata["documentation_uri"] = "https://github.com/runapi-ai/happyhorse-sdk/blob/main/ruby/README.md"
    spec.metadata["source_code_uri"] = "https://github.com/runapi-ai/happyhorse-sdk"
    spec.metadata["changelog_uri"] = "https://github.com/runapi-ai/happyhorse-sdk/blob/main/CHANGELOG.md"



    spec.files = Dir.glob("lib/**/*") + %w[LICENSE README.md]
    spec.extra_rdoc_files = ["README.md"]
        spec.require_paths = ["lib"]

    spec.add_dependency "runapi-core", "~> 0.2.6"
  end
end
