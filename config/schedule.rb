# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#

# https://github.com/javan/whenever/issues/656#issuecomment-239111064
# ENV.each { |k, v| env(k, v) }

every 1.hour do
  rake 'mailbox:remove_expired'
  rake 'sms:remove_expired'
end

# Learn more: http://github.com/javan/whenever
