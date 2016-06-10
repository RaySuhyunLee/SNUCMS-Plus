module ApplicationHelper
  require 'rouge/plugins/redcarpet'

  FORMATTER_OPTIONS =
  {
    line_numbers:         true
  }

  RENDER_OPTIONS =
  {
    hard_wrap:            true,
    no_styles:            true
  }

  EXTENTIONS =
  {
    footnotes:            true,
    highlight:            true,
    tables:               true,
    autolink:             true,
    fenced_code_blocks:   true,
    lax_spacing:          true,
    no_intra_emphasis:    true,
    strikethrough:        true,
    superscript:          true,
    space_after_headers:  true
  }

  class HTML < Redcarpet::Render::HTML
    def block_code(code, language)
      formatter = Rouge::Formatters::HTML.new(FORMATTER_OPTIONS)
      lexer = Rouge::Lexer.find(language || 'text').new

      formatter.format(lexer.lex(code))
    end

    def table(header, body)
      "<table class=\"ui celled table\"><thead>#{header}</thead><tbody>#{body}</tbody></table>"
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

    text.each_line do |line|
      if line.start_with?('```')
        inside_code_section = !inside_code_section
      end

      if !line.start_with?('#') || inside_code_section
        next
      end

      title = line.gsub('#', '').strip
      href = title.gsub(/(^[!.?:\(\)]+|[!.?:\(\)]+$)/, '').gsub(/[!.,?:; \(\)-]+/, '-').downcase

      bullet = spaces(line.count('#')) + "1."
      table_of_contents << '  ' * (line.count('#') - 1) + "#{bullet} [#{title}](\##{href})\n"
    end

    render_markdown(table_of_contents)
  end

  def spaces(num)
    s = ""
    num.times { s = s + " " }
    s
  end

  def render_easy_link(text)
    result = text.gsub(@regex[:link]) do
      "[#{$1}](#{wiki_page_path($1)})"
    end
  end

  def render_latex_math(text)
    result = text.gsub(@regex[:latex]) do
      "<img src=\"http://latex.codecogs.com/svg.latex?#{$1}\">"
    end
  end

  def escape_script_tag(text)
    result = text.gsub(@regex[:script]) do
      "&lt;script&gt;#{$1}&lt;&#x2F;script&gt;"
    end
  end

  def prettify_time(time)
    current_time = Time.now.utc

    if time.year < current_time.year
      (current_time.year - time.year).to_s + "년 전"
    elsif time.month < current_time.month
      (current_time.month - time.month).to_s + "달 전"
    elsif time.day < current_time.day
      (current_time.day - time.day).to_s + "일 전"
    elsif time.hour < current_time.hour
      (current_time.hour - time.hour).to_s + "시간 전"
    elsif time.min < current_time.min
      (current_time.min - time.min).to_s + "분 전"
    else
      (current_time.sec - time.sec).to_s + "초 전"
    end
  end

end
