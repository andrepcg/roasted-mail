# frozen_string_literal: true

ActiveAdmin.register Changelog do
  permit_params :title, :slug, :text

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs do
      f.input :title
      f.input :text, as: :quill_editor
    end
    f.actions
  end
end
