# frozen_string_literal: true

module ActiveRecord
  # This is a thread locals registry for Active Record. For example:
  #
  #   ActiveRecord::RuntimeRegistry.sql_runtime
  #
  # returns the connection handler local to the current unit of execution (either thread of fiber).
  module RuntimeRegistry # :nodoc:
    extend self

    def sql_runtime
      ActiveSupport::IsolatedExecutionState[:active_record_sql_runtime] ||= 0.0
    end

    def sql_runtime=(runtime)
      ActiveSupport::IsolatedExecutionState[:active_record_sql_runtime] = runtime
    end

    def async_sql_runtime
      ActiveSupport::IsolatedExecutionState[:active_record_async_sql_runtime] ||= 0.0
    end

    def async_sql_runtime=(runtime)
      ActiveSupport::IsolatedExecutionState[:active_record_async_sql_runtime] = runtime
    end

    def reset
      rt, self.sql_runtime = sql_runtime, 0.0
      self.async_sql_runtime = 0.0
      rt
    end
  end
end

ActiveSupport::Notifications.monotonic_subscribe("sql.active_record") do |name, start, finish, id, payload|
  runtime = (finish - start) * 1_000.0

  if payload[:async]
    ActiveRecord::RuntimeRegistry.async_sql_runtime += (runtime - payload[:lock_wait])
  end
  ActiveRecord::RuntimeRegistry.sql_runtime += runtime
end
