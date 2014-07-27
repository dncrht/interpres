class AppsController < ApplicationController
  before_action :set_app, only: [:edit, :update, :destroy]

  # GET /apps
  def index
    @apps = App.all
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/edit
  def edit; end

  # POST /apps
  def create
    @app = App.new(app_params)

    if @app.save
      redirect_to apps_path, notice: 'App was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /apps/1
  def update
    if @app.update(app_params)
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

  def set_app
    @app = App.find(params[:id])
  end

  def app_params
    params.require(:app).permit!
  end
end
