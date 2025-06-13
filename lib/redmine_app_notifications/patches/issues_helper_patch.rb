# frozen_string_literal: true

module RedmineAppNotifications
  module Patches
    module IssuesHelperPatch
      extend ActiveSupport::Concern

      included do
        # Ensure ApplicationHelper methods are available
        include ApplicationHelper
      end
    end
  end
end 
