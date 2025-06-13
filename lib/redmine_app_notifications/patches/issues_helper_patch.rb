# frozen_string_literal: true

module RedmineAppNotifications
  module Patches
    module IssuesHelperPatch
      extend ActiveSupport::Concern

      included do
        # Ensure helper methods that IssuesHelper relies on are available
        include CustomFieldsHelper unless included_modules.include?(CustomFieldsHelper)
        include ApplicationHelper unless included_modules.include?(ApplicationHelper)
      end
    end
  end
end 
