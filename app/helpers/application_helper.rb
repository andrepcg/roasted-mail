# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  COLORS = %w[primary success danger warning secondary info].freeze

  def random_color
    COLORS.sample
  end

  def mailbox_session_url(mailbox)
    mailbox_login_url(mailbox, mailbox.token)
  end

  def format_linebreaks(text)
    safe_text = h(text)
    paragraphs = split_paragraphs(safe_text).map(&:html_safe)

    html = ''.html_safe
    paragraphs.each do |paragraph|
      html << tag.p(paragraph)
    end
    html
  end

  def github_commit_url(commit_sha)
    "https://github.com/andrepcg/roasted-mail/commit/#{commit_sha}"
  end
end
