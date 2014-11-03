# require 'set'

class ReportsController < ApplicationController
  
  before_action :set_report, only: [:show, :edit, :update, :destroy, :save_corrections]
  skip_before_action :authorize, only: [:index, :show]

  # GET /reports
  # GET /reports.json
  def index
    # @department = determine_department
    # if @department
    #   @reports = Report.where(author: User.where(department: @department)).order(updated_at: :desc)
    # else
    #   @reports = Report.order(updated_at: :desc)
    # end

    @reports = Report.order(updated_at: :desc).page(params[:page]).per(10)
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.author = @current_user
    @report.generate_sentences

    if @report.save
      redirect_to @report, notice: 'Report posted'
    else
      render :new
    end
  end

  def save_corrections
    # generate sentence map
    sentence_map = {}
    @report.sentences.each do |s|
      sentence_map[s.id] = s
    end

    # filter corrections
    corrections = []
    params[:corrections].each do |id, c|
      sentence_key = id.to_i
      correction_data = {}
      if c[:modified] == 'true' and sentence_map.include? sentence_key
        correction_data[:sentence] = sentence_map[sentence_key]
        correction_data[:advice] = c[:advice]
        correction_data[:comment] = c[:comment]
        correction_data[:advisor] = @current_user
        corrections << correction_data
      end
    end

    if corrections.any?
      Report.transaction do
        # save correction log
        log = CorrectionLog.new
        log.report = @report
        log.advisor = @current_user
        log.save

        # save corrections
        corrections.each do |c|
          c[:correction_log] = log
          correction = Correction.new(c)
          correction.save
        end

        # update correction count in report
        @report.correction_count = CorrectionLog.where(report: @report).count
        @report.save
      end
    end
    redirect_to @report
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end

    # TODO regenerate sentences
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :language, :content)
    end

    def determine_department
      id = params[:department_id]

      if id == 'my' and @current_user
        @current_user.department
      elsif id
        begin
          Department.find(id)
        rescue ActiveRecord::RecordNotFound
        end
      end
    end

end
