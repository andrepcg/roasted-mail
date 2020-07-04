# frozen_string_literal: true

# Name of the files that define the current version
FILE_NAMES = %w[VERSION BRANCH COMMIT TIMESTAMP].freeze

# Get the file paths of the previous files
file_paths = FILE_NAMES.map { |file_name| File.join(Rails.root, file_name) }
                       .select { |file_path| File.exists?(file_path) }

COMMIT = begin
           File.read(File.join(Rails.root, 'COMMIT'))
         rescue StandardError => e
         end
# Read the files, concatenate and assign to a variable
VERSION = file_paths.map { |file_path| File.read(file_path) }
                    .join(' - ')
                    .delete!("\n")
