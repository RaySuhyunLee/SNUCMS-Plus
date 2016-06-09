class WikiPagesController < ApplicationController
  before_action :set_wiki_page, only: [:show, :edit, :edit_permission, :update, :destroy, :history, :revert_page]
  before_action :set_version, only: [:history, :revert_page]
  before_action :set_regex, only: [:show, :edit, :render_page]
  before_filter :set_paper_trail_whodunnit

  def index
    @pages = WikiPage.all
    @recent_pages = WikiPage.limit(5).order('updated_at desc')
  end

  def show
    @title = params[:title]
    @from = params[:from]
    @rev = params[:rev]

    if @page.nil?
      redirect_to empty_wiki_page_path(@title)
    else
      unless @rev.nil?
        @page = @page.versions[@rev.to_i].reify
      end

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

  def edit_permission
    time = params[:time]

    if @page.updated_at.to_s == time
      render json: { recent: @page.updated_at, result: 'available' }
    else
      render json: { recent: @page.updated_at, result: 'occupied' }
    end
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
  end

  def revert_page
    @rev = params[:rev]
    @page = @versions[@rev.to_i].reify
    @page.save
    redirect_to wiki_page_path(@page.title)
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

  def set_version
    @versions = @page.versions
  end

  def user_for_paper_trail
    current_user.nil? ? '익명' : current_user.name
  end

  def set_regex
    @regex =
    {
      link: /\[\[([^\]]*)\]\]/,
      redirect: /^redirect \[\[(.*)\]\]/,
      latex: /(?<!\\)\$(.*)\$/
    }
  end

end
