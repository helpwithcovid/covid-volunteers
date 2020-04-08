AlgoliaSearch.configuration = {
  application_id: ENV['ALGOLIASEARCH_APPLICATION_ID'],
  api_key: ENV['ALGOLIASEARCH_API_KEY']
}

module AlgoliaSearch
  module Utilities
    class << self
      def get_model_classes
        Zeitwerk::Loader.eager_load_all # instead of  Rails.application.eager_load!
        AlgoliaSearch.instance_variable_get :@included_in
      end
    end
  end
end
