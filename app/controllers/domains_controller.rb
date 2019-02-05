class DomainsController < ApplicationController
  
  def show
    @domain = Domain.find(params[:id])
    @bookmarks = @domain.bookmarks.paginate(page: params[:page]).order(id: :desc)
  end
end
