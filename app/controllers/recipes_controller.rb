class RecipesController < ApplicationController
  include ApplicationHelper
  include SessionsHelper
  include RecipesHelper

  def new
    @recipe = Recipe.new
    get_category
  end

  def create
    @recipe = get_category.recipes.new(recipe_params)
    current_user.recipes << @recipe

    if @recipe.save
      flash.notice = "Your recipe has been added!"

      redirect_to "/categories/#{@category.name}", notice: "You recipe was successfully added!"
    else
      render :new
    end
  end

  def show
    if get_recipe
      if logged_in
        get_recipe
        render :show
      else
        render :show
      end
    else
      render file: 'public/404.html'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if recipe_owner?(@recipe) || admin?
      @category = Category.find(@recipe.category_id)
      if current_user.id != @recipe.user_id
        flash[:no_access] = "You do not have permission to edit this recipe."
        redirect_to @recipe
      end
    else
      render file: 'public/404.html'
    end
  end

  def destroy
    get_recipe
    if recipe_owner?(@recipe) || admin?
      @category = @recipe.category
      Recipe.destroy(@recipe)
      flash[:notice] = "The recipe has been deleted."
      redirect_to "/categories/#{@category.name}"
    else
      render file: 'public/404.html'
    end
  end


  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end


  private

  def recipe_params
    params.require(:recipe).permit(:title, :category_id, :user_id, :directions, :time, :difficulty)
  end


  def get_recipe
    @recipe ||= Recipe.find_by(id: params[:id])
  end

   def get_category
    @category ||= Category.find_by(id: params[:category_id])
  end
end
