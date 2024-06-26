
require 'singleton'

module RedmineGitMirror
  module Settings
    DEFAULT = {
      :schemes => %w[http https scp],
      :gitlab_hook_enabled => false,
      :gitlab_token => nil,
      :github_hook_enabled => false,
      :github_secret_key => nil,
      :url_change_allowed => false,
      :prevent_multiple_clones => true,
      :custom_path => nil,
      :search_clones_in_all_schemes => true,
    }.freeze

    class << self
      def default_path
        File.expand_path(File.dirname(__FILE__) + '/../../repos/')
      end

      def custom_path
        self[:custom_path]
      end

      def path
        self.custom_path || self.default_path
      end

      def allowed_schemes
        self[:schemes] || []
      end

      def gitlab_hook_enabled?
        s = self[:gitlab_hook_enabled] || false

        s == true || s.to_s == '1'
      end

      def gitlab_token
        self[:gitlab_token]
      end

      def github_hook_enabled?
        s = self[:github_hook_enabled] || false

        s == true || s.to_s == '1'
      end

      def github_secret_key
        self[:github_secret_key]
      end

      def url_change_allowed?
        s = self[:url_change_allowed] || false

        s == true || s.to_s == '1'
      end

      def prevent_multiple_clones?
        s = self[:prevent_multiple_clones] || false

        s == true || s.to_s == '1'
      end

      def search_clones_in_all_schemes?
        s = self[:search_clones_in_all_schemes] || false

        s == true || s.to_s == '1'
      end

      private def [](key)
        key = key.intern if key.is_a?(String)
        settings = Setting[:plugin_redmine_git_mirror] || {}

        return settings[key] if settings.key?(key)
        return settings[key.to_s] if settings.key?(key.to_s)

        DEFAULT[key]
      end
    end
  end
end
