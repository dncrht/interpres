class AppsController < ApplicationController
  before_action :set_app, only: [:edit, :update, :destroy, :download, :create_token]
  before_action :available_languages, only: [:new, :create, :edit, :update]

  # GET /apps
  def index
    @apps = App.all
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/set
  def set
    session[:current_app_id] = params[:id]
    redirect_to apps_path
  end

  # GET /apps/1/download/en.po
  def download
    language = Language.find_by(iso: params[:iso])

    respond_to do |format|
      format.po do
        headers['Content-Disposition'] = %(attachment; filename="#{language.iso}.po")
        render text: Translations::PoCompiler.new(@app).for_language(language)
      end
    end
  end

  # GET /apps/1/edit
  def edit; end

  # POST /apps
  def create
    @app = App.new(app_params)

    if @app.save
      @app.languages = languages
      redirect_to apps_path, notice: 'App was successfully created.'
    else
      render :new
    end
  end

  # PATCH /apps/1/token
  def create_token
    @app.update_column :token, SecureRandom.hex(32)

    flash[:show_token] = true

    redirect_to apps_path
  end

  # PATCH/PUT /apps/1
  def update
    if @app.update(app_params)
      @app.languages = languages
      redirect_to apps_path, notice: 'App was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /apps/1
  def destroy
    @app.destroy
    redirect_to apps_path, notice: 'App was successfully destroyed.'
  end

  private

  def languages
    return [] if params[:app].blank? || params[:app][:languages].blank?
    Array(params[:app][:languages]).map { |language_id| Language.find_by_id(language_id) }.compact
  end

  def available_languages
    @languages = Language.all
  end

  def set_app
    @app = App.find(params[:id])
  end

  def app_params
    params.require(:app).permit(:name)
  end
end
