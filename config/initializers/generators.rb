# frozen_string_literal: true

# Making sure every new table will have a uuid format identifier
Rails.application.config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid
  end
  