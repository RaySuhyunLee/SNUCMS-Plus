module WikiPagesHelper

  def render_easy_link(text)
    result = text.gsub(@regex[:link]) do
      '[' + $1 + '](' + wiki_page_path($1) + ')'
    end
  end

  def render_latex_math(text)
    result = text.gsub(@regex[:latex]) do
      '<img src="http://latex.codecogs.com/svg.latex?' + $1 + '">'
    end
  end

end
