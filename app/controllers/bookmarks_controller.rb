class BookmarksController < ApplicationController

  def index
    if params[:search].present?
      @bookmarks = Bookmark.search_by(params[:search]).paginate(page: params[:page]).order(id: :desc)
    else
      @bookmarks = Bookmark.paginate(page: params[:page]).order(id: :desc)
    end
    @bookmark = Bookmark.new
  end

  def create
    bookmark_params = params[:bookmark].permit(:url, :tag_list)
    bookmark_params[:tag_list] = bookmark_params[:tag_list].split(' ').uniq
    Bookmark.create!(bookmark_params)
    redirect_to bookmarks_path
  end

  def destroy
    Bookmark.find(params[:id]).destroy!
  end
end
