module BasicDatabaseFunctions
  def index
    datas = database.all
    render json: datas
  end

  def show
    data = database.find(params[:id])
    authorize data

    render json: data
  end

  def new
    data = database.new
    render json: data
  end

  def create
    data = database.new(request_params)

    if data.save
      render json: data, status: :created
    else
      render json: data.errors, status: :unprocessable_entity
    end
  end

  def edit
    data = database.find(params[:id])
    render json: data
  end

  def update
    data = database.find(params[:id])
    authorize data

    if data.update(request_params)
      render json: data
    else
      render json: data.errors, status: :unprocessable_entity
    end
  end

  def destroy
    data = database.find(params[:id])
    data.destroy

    redirect_to root_path, status: :see_other
  end
end
