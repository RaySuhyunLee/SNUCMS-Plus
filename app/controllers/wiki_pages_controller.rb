class WikiPagesController < ApplicationController
  before_action :set_wiki_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = WikiPage.all
  end

  def show
    if @page.nil?
      redirect_to new_wiki_page_path # TODO
    end
  end

  def new
    @page = WikiPage.new
  end

  def create
    @page = WikiPage.new(wiki_page_params)

    if WikiPage.exists?(title: @page.title)
      redirect_to wiki_path # TODO
    elsif @page.save
      redirect_to wiki_page_path(@page.title)
    else
      render 'new'
    end
  end

  def edit
    @title = @page.title
  end

  def update
    if @page.update(wiki_page_params)
      redirect_to action: 'show', id: @page
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to action: 'index'
  end

  private

    def set_wiki_page
      @page = WikiPage.find_by(title: params[:title])
    end

    def wiki_page_params
      params.require(:wiki_page).permit(:title, :contents)
    end
end
