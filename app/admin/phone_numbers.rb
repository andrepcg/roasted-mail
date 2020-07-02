# frozen_string_literal: true

ActiveAdmin.register PhoneNumber do
  COUNTRIES_LIST = ISO3166::Country.translations.values.zip(ISO3166::Country.translations.keys).freeze
  permit_params :number, :available, :country_iso3166

  controller do
    def find_resource
      scoped_collection.find_by(number: "+#{params[:id]}")
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :number
      f.input :country_iso3166, as: :select, collection: COUNTRIES_LIST
      f.input :available
    end
    f.actions
  end
end
