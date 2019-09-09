# frozen_string_literal: true

json.completed @status.completed?
json.promoted @status.promoted?
json.derived @status.derived?
