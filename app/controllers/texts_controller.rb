class TextsController < ApplicationController
  before_action :set_current_app
  before_action :set_text, only: [:edit, :update, :destroy]

  # GET /texts
  def index
    @texts = @app.texts
  end

  # GET /texts/new
  def new
    @text = Text.new
  end

  # GET /texts/1/edit
  def edit; end

  # POST /texts
  def create
    @text = @app.texts.build(text_params)

    if TextTranslationsCreation.new(@text).save_with_translations(params[:translations])
      redirect_to texts_path, notice: 'Text was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /texts/1
  def update
    @text.attributes = text_params

    if TextTranslationsCreation.new(@text).save_with_translations(params[:translations])
      redirect_to texts_path, notice: 'Text was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /texts/1
  def destroy
    @text.destroy
    redirect_to texts_path, notice: 'Text was successfully destroyed.'
  end

  private

  def set_text
    @text = Text.find(params[:id])
  end

  def text_params
    params.require(:text).permit(:literal, :accepted)
  end

  def set_current_app
    @app = App.find_by_id(session[:current_app_id])
    redirect_to app_path unless @app
  end
end
