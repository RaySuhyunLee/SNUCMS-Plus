class WikiPagesController < ApplicationController
  before_action :set_wiki_page, only: [:show, :edit, :update, :destroy]


  def index
    @pages = WikiPage.all
  end

  def show
    # TODO
    @regex =
      {
        link: /\[\[(.*)\]\]/,
        redirect: /#redirect \[\[(.*)\]\]/
      }

    if @page.nil?
      redirect_to empty_wiki_page_path(params[:title])
    else
      redirect_page = @regex[:redirect].match(@page.contents)
      unless redirect_page.nil? or params[:title] == $1 # TODO
        redirect_to wiki_page_path($1)
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

  private

    def set_wiki_page
      @page = WikiPage.find_by(title: params[:title])
    end

    def wiki_page_params
      params.require(:wiki_page).permit(:title, :contents)
    end
end
