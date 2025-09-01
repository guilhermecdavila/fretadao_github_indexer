class GithubUsersController < ApplicationController
  def index
    unless params[:filter].present?
      @filter = ::GithubUserSearchForm.new
    else
      @filter = ::GithubUserSearchForm.new(params[:filter])
      if @filter.valid?
        search = GithubUserSearch.new(@filter.query)
        @github_users = search.search.results
      end
    end
  end

  def show
    @github_user = GithubUser.find(params[:id])
  end

  def new
    @github_user = GithubUser.new
  end

  def create
    @github_user = GithubUser.new(github_user_params)
    if @github_user.save
      flash[:success] = "Usuário adicionado com sucesso."
      redirect_to github_user_path(@github_user)
    else
      flash.now[:error] = "Erro ao adicionar usuário. Verifique e tente novamente."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @github_user = GithubUser.find(params[:id])
  end

  def update
    @github_user = GithubUser.find(params[:id])
    if @github_user.update(github_user_params)
      flash[:success] = "Usuário atualizado com sucesso."
      redirect_to github_user_path(@github_user)
    else
      flash.now[:error] = "Erro ao atualizar usuário. Verifique e tente novamente."
      render :edit, status: :unprocessable_entity
    end
  end

  def rescanner
    @github_user = GithubUser.find(params[:id])
    @github_user.start_webscrapper

    flash[:success] = "Reanálise concluída com sucesso."
    redirect_to github_user_path(@github_user)
  end

  def destroy
    @github_user = GithubUser.find(params[:id])
    if @github_user.destroy
      flash[:success] = "Usuário excluido com sucesso."
      redirect_to root_path
    else
      flash.now[:error] = "Erro ao excluir usuário. Verifique e tente novamente."
      render root_path
    end
  end

  def github_user_params
    params.require(:github_user).permit(:github_url, :name)
  end
end
