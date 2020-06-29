# frozen_string_literal: true

Fabricator(:changelog) do
  title { Faker::Lorem.sentence }
  text  { Faker::Lorem.paragraphs(number: 4).join('\n') }
end
