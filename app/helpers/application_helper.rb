module ApplicationHelper
  require 'rouge/plugins/redcarpet'

  FORMATTER_OPTIONS =
  {
    line_numbers:         true
  }

  RENDER_OPTIONS =
  {
    hard_wrap:            true
  }

  EXTENTIONS =
  {
    tables:               true,
    autolink:             true,
    fenced_code_blocks:   true,
    lax_spacing:          true,
    no_intra_emphasis:    true,
    strikethrough:        true
  }

  class HTML < Redcarpet::Render::HTML
    def block_code(code, language)
      formatter = Rouge::Formatters::HTML.new(FORMATTER_OPTIONS)
      lexer = Rouge::Lexer.find(language || 'text').new

      formatter.format(lexer.lex(code))
    end
  end

  def render_markdown(text)
    linked_text = ""
    inside_code_section = false

    text.each_line do |line|
      if line.start_with?('```')
        inside_code_section = !inside_code_section
      end

      if !line.start_with?('#') || inside_code_section
        linked_text << line
        next
      end

      title = line.gsub('#', '').strip
      href = title.gsub(/(^[!.?:\(\)]+|[!.?:\(\)]+$)/, '').gsub(/[!.,?:; \(\)-]+/, '-').downcase

      linked_text << "<a id=\"#{href}\" href=\"#\"></a>\n" + line
    end

    renderer = HTML.new(RENDER_OPTIONS)
    Redcarpet::Markdown.new(renderer, EXTENTIONS).render(linked_text).html_safe
  end

  def render_toc(text)
    table_of_contents = ""
    inside_code_section = false
    i_section = 0

    text.each_line do |line|
      if line.start_with?('```')
        inside_code_section = !inside_code_section
      end

      if !line.start_with?('#') || inside_code_section
        next
      end

      title = line.gsub('#', '').strip
      href = title.gsub(/(^[!.?:\(\)]+|[!.?:\(\)]+$)/, '').gsub(/[!.,?:; \(\)-]+/, '-').downcase

      bullet = line.count('#') > 1 ? ' *' : "#{i_section += 1}."
      table_of_contents << '  ' * (line.count('#') - 1) + "#{bullet} [#{title}](\##{href})\n"
    end

    render_markdown(table_of_contents)
  end

end
