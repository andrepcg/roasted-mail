# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  COLORS = %w[primary success danger warning secondary info]

  def random_color
    COLORS.sample
  end

  def mailbox_session_url(mailbox)
    mailbox_login_url(mailbox, mailbox.token)
  end

  def format_linebreaks(text)
    safe_text = h(text)
    paragraphs = split_paragraphs(text).map(&:html_safe)

    html = ''.html_safe
    paragraphs.each do |paragraph|
      html << content_tag(:p, paragraph)
    end
    html
  end
end
