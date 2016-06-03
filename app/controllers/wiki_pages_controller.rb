class WikiPagesController < ApplicationController
  before_action :set_wiki_page, only: [:show, :edit, :update, :destroy, :history]
  before_action :set_regex, only: [:show, :edit, :render_page]

  def index
    @pages = WikiPage.all
  end

  def show
    @title = params[:title]
    @from = params[:from]

    if @page.nil?
      redirect_to empty_wiki_page_path(@title)
    else
      redirect_path = @regex[:redirect].match(@page.contents)

      if not redirect_path.nil? and @title != $1 and @from.nil?
        redirect_to wiki_page_path(title: $1, from: @title)
      end
    end
  end

  def empty
    @title = params[:title]
  end

  def new
    @page = WikiPage.new
    @page.title = params[:title]

    unless @page.save
      redirect_to wiki_path
    else
      redirect_to edit_wiki_page_path(@page.title)
    end
  end

  def edit
  end

  def update
    if @page.update(wiki_page_params)
      redirect_to wiki_page_path(@page.title)
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to wiki_path
  end

  def history
    ver = @page.versions
  end

  def render_page
    data = params[:contents]
    render partial: 'render_page', locals: {data: data}
  end

  private

  def set_wiki_page
    @page = WikiPage.find_by(title: params[:title])
  end

  def wiki_page_params
    params.require(:wiki_page).permit(:title, :contents)
  end

  def set_regex
    @regex =
    {
      link: /\[\[(.*)\]\]/,
      redirect: /^redirect \[\[(.*)\]\]/,
      latex: /(?<!\\)\$(.*)\$/
    }
  end

end
