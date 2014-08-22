class TextsController < ApplicationController
  before_action :set_current_app
  before_action :set_text, only: [:edit, :update, :destroy]

  # GET /texts
  def index
    @texts = @app.texts

    respond_to do |format|
      format.html
      format.po do
        language = Language.find_by(iso: params[:iso])
        render text: Translations::PoCompiler.new(@app).for_language(language)
      end
    end
  end

  # GET /texts/new
  def new
    @text = @app.texts.build
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
    @app = App.find_by(id: session[:current_app_id]) || App.find_by(token: params[:app_token])
    unless @app
      if params[:app_token] # request is from API
        render text: '403 Forbidden', status: 403
      else
        redirect_to(apps_path, notice: "Select an app from the dropdown to edit its text strings.<br>Don't have an app? Add one!")
      end
    end
  end
end
