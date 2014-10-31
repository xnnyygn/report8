# require 'set'

class ReportsController < ApplicationController
  
  before_action :set_report, only: [:show, :edit, :update, :destroy, :save_corrections]
  skip_before_action :authorize, only: [:index, :show]

  # GET /reports
  # GET /reports.json
  def index
    # TODO add filter for language
    @department = determine_department
    if @department
      @reports = Report.where(author: User.where(department: @department))
    else
      @reports = Report.all
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @corrections = Correction.where(sentence: Sentence.where(report: @report))
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

    if @report.save
      redirect_to @report, notice: 'Report posted'
    else
      render :new
    end
  end

  def save_corrections
    correction_count = 0
    params[:corrections].each do |id, c|
      if c[:modified] == 'true'
        correction = Correction.new
        correction.sentence = Sentence.find(id)
        correction.advice = c[:advice]
        # correction.comment = c[:comment]
        correction.advisor = @current_user
        correction.save

        correction_count += 1
      end
    end
    # save correction count
    if correction_count > 0
      log = CorrectionLog.new
      log.report = @report
      log.advisor = @current_user
      log.save
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

    SENTENCE_MODIFIED_FLAG_PREFIX = 'sentence-modified-'

end
