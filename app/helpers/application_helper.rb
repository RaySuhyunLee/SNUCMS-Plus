module ApplicationHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      options = { encoding: 'utf-8', linenos: true }
      Pygments.highlight(code, lexer: language, options: options)
    end
  end

  RENDER_OPTIONS =
  {
    hard_wrap:            true, 
    link_attributes:      { rel: 'nofollow' }
    #with_toc_data:        true
  }

  EXTENTIONS =
  {
    autolink:             true,
    fenced_code_blocks:   true,
    lax_spacing:          true,
    no_intra_emphasis:    true,
    strikethrough:        true,
    space_after_headers:  true
  }

  def render_markdown(text)
    renderer = Redcarpet::Render::HTML.new(RENDER_OPTIONS)
    Redcarpet::Markdown.new(renderer, EXTENTIONS).render(text).html_safe
  end

  def render_toc(text)
    toc_renderer = Redcarpet::Render::HTML_TOC
    Redcarpet::Markdown.new(toc_renderer).render(text).html_safe
  end
end

