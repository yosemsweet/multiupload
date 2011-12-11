class BucketsController < ApplicationController
  # GET /buckets
  # GET /buckets.json
  def index
    @buckets = Bucket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buckets }
    end
  end

  # GET /buckets/1
  # GET /buckets/1.json
  def show
    @bucket = Bucket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/new
  # GET /buckets/new.json
  def new
    @bucket = Bucket.new
		@bucket.assets.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bucket }
    end
  end

  # GET /buckets/1/edit
  def edit
    @bucket = Bucket.find(params[:id])
  end

  # POST /buckets
  # POST /buckets.json
  def create
    @bucket = Bucket.new(params[:bucket])

    respond_to do |format|
      if @bucket.save
        format.html { redirect_to @bucket, notice: 'Bucket was successfully created.' }
        format.json { render json: @bucket, status: :created, location: @bucket }
      else
        format.html { render action: "new" }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buckets/1
  # PUT /buckets/1.json
  def update
    @bucket = Bucket.find(params[:id])

    respond_to do |format|
      if @bucket.update_attributes(params[:bucket])
        format.html { redirect_to @bucket, notice: 'Bucket was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bucket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buckets/1
  # DELETE /buckets/1.json
  def destroy
    @bucket = Bucket.find(params[:id])
    @bucket.destroy

    respond_to do |format|
      format.html { redirect_to buckets_url }
      format.json { head :ok }
    end
  end
end
