# frozen_string_literal: true

class ChangelogController < ApplicationController
  before_action :set_changelog, only: %i[show]
  def index
    @changelogs = Changelog.all.order(created_at: :desc)
  end

  def show; end

  private

  def set_changelog
    id = params[:id].split('-').first
    @changelog = Changelog.find(id)
  end
end
