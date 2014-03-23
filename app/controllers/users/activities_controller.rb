class Users::ActivitiesController < InheritedResources::Base
  respond_to :html, :js
  belongs_to :user

  has_scope :pending_today, type: :boolean do |ctrlr, scope|
    scope.pending.today
  end

  def index
    index! do |format|
      format.js { render 'index.js.erb', layout: false }
    end
  end

  def complete
    if resource.update permited_params.merge(status: :completed)
      respond_with(resource) do |format|
        format.html { render :next_activity }
        format.js   { render 'next_activity.js.erb', layout: false }
      end
    else
      flash.now[:danger] = "Something went wrong: #{resource.errors.full_messages.to_sentence}"
      respond_with(resource) do |format|
        format.html { render :show }
        format.js   { render 'shared/js/form_errors.js.erb', layout: false }
      end
    end
  end

  def fail
    if resource.update status: :failed
      respond_with(resource) do |format|
        format.html { render :next_activity }
        format.js   { render 'next_activity.js.erb', layout: false }
      end
    else
      flash.now[:danger] = 'Something went wrong'
      respond_with(resource) do |format|
        format.html { render :show }
        format.js   { render 'shared/js/flash_messages.js.erb', layout: false }
      end
    end
  end

  def create_responder(format)
    if action_successful?
      format.html { render :show }
      format.js   { render 'create.js', layout: false }
    else
      format.html { render :new }
      format.js   { render 'shared/js/form_errors.js.erb', layout: false }
    end
  end

  private

  def collection
    @q = apply_scopes(super).search(params[:q])
    ActivityDecorator.decorate_collection @q.result.page(params[:page])
  end

  permit_params :target_date, :completed_date, :type,
   :status, :notes, :address_id, :contact_id, :installation_id,
   installation_attributes: [:date, :kit_id, :contact_id, :address_id, :user_id]
end
