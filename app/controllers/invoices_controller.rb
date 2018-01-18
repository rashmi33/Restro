class InvoicesController < ApplicationController
	protect_from_forgery
  def index
    @invoices = Invoice.all
    respond_to do |format|
      format.json { render :json => { :invoices => @invoices }, status: :ok }
      format.html
    end
  end

  def new
    @invoice = Invoice.new
  end 
  
  def show
    begin
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :invoice => @invoice }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  
  def edit
    begin
      @invoice = Invoice.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :invoice => @invoice }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
 
  def create
  	@invoice = Invoice.new(invoice_params)
    if @invoice.save
      respond_to do |format|
        format.json { render :json => { :invoice => @invoice }, status: :ok }
        format.html { redirect_to invoices_path }
      end
    else
      respond_to do |format|
        format.json { render :json => { :invoice => @invoice.errors }, status: :unprocessable_entity }
        format.html { redirect_to new_invoice_path }
      end
    end
  end

  def update
    begin
      @invoice = Invoice.find(params[:id])
      if @invoice.update(invoice_params)
        redirect_to @invoice
      else
        respond_to do |format|
          format.json { render :json => { :invoice => @invoice.errors }, status: :unprocessable_entity }
          format.html { redirect_to edit_invoice_path }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
  
  def destroy
    begin
      @invoice = Invoice.find(params[:id])
      if @invoice.destroy
        respond_to do |format|
          format.json { render :json => { :message => 'Invoice was deleted successfully' }, status: :ok }
          format.html { redirect_to invoices_path }
        end
      else
        respond_to do |format|
          format.json { render :json => { :invoice => @invoice.errors }, status: :unprocessable_entity }
          format.html
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  private
  def invoice_params
    params.require(:invoice).permit(:code, :amount, :order_id)
  end
end