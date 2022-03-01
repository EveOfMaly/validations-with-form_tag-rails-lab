class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    #create a brand new author, not-yet-validated author object from the from 
    @author = Author.new(author_params)

    #run the validations without attempting to hit the databases, returning true if valid and false others
    if @author.valid? 
       @author.save #save to database
       #throw away @author and the show action read from the database
       redirect_to author_path(@author)
    else
      #if invalid hold on to @author which has erros and renter it to the :new page which knows how to display the erros 
      render :new
    end

  
  end

  def edit 
    @author = Author.find(params[:id])
  end


  def update
     if @author.update(author_params) 
      redirect_to author_path(@author)
     else 
      render :edit
     end
  end

  private

  def author_params
    params.permit(:name, :email, :phone_number)
  end
end
