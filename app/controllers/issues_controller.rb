class IssuesController < ApplicationController
  before_filter :set_project
  before_filter :set_issue, only: [:destroy]
  before_filter :set_new_issue, only: [:create]

  def create
    if @issue.save
      redirect_to :back, notice: 'created new issue'
    else
      redirect_to :back, notice: @issue.errors.full_messages.join(',')
    end
  end

  def destroy
    if @issue.destroy
      redirect_to :back, notice: 'deleted new issue'
    else
      redirect_to :back, notice: @issue.errors.full_messages.join(',')
    end
  end

  private

  def set_project
    @project = Project.find_by(key: params[:project_key])
  end

  def set_issue
    @issue = @project.issues.find(params[:id])
  end

  def set_new_issue
    @issue = @project.issues.build(issue_params)
  end

  def issue_params
    params.require(:issue).permit(:title, :status)
  end
end