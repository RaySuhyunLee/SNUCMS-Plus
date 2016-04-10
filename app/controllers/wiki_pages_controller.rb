class WikiPagesController < ApplicationController
  before_action :set_wiki_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = WikiPage.all
  end

  def show
    if @page.nil?
      redirect_to new_wiki_page_path
    end
  end

  def new
    if WikiPage.exists?(title: params[:title])
      redirect_to wiki_page_path(params[:title])
    else
      @page = WikiPage.new
      @page.title = params[:title]

      if not @page.save
        redirect_to wiki_path
      end
    end
  end

  def edit
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
