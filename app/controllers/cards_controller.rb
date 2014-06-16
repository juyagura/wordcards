class CardsController < ApplicationController
  before_action(:set_card, :only => [:show, :defshow, :edit, :update, :learned, :unlearn, :destroy])
  before_action(:signed_in_user_must_be_creator, :only => [:edit, :update, :learned, :unlearn, :destroy])

  def set_card
    @card = Card.find(params[:id])
  end

  def signed_in_user_must_be_creator
    if @card.user_id != current_user.id
      redirect_to root_url, :alert => "You do not have the permission for the action."
    end
  end

  def index
    @cards = current_user.cards.where({ :learned => "0" })
  end

  def learned_list
    @cards = current_user.cards.where({ :learned => "1" })
    render 'index'
  end

  def show
  end

  def defshow
  end

  def random
    unlearned_cards = current_user.cards.where({ :learned => "0" })
    @card = unlearned_cards.offset(rand(unlearned_cards.count)).first
    redirect_to "/cards/#{@card.id}"
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new
    @card.word = params[:word]
    @card.definition = params[:definition]
    @card.learned = params[:learned]
    @card.user_id = params[:user_id]

    if @card.save
      redirect_to "/cards", :notice => "Card created successfully."
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    @card.word = params[:word]
    @card.definition = params[:definition]
    @card.learned = params[:learned]
    @card.user_id = params[:user_id]

    if @card.save
      redirect_to "/cards", :notice => "Card updated successfully."
    else
      render 'edit'
    end
  end

  def learned
    @card.learned = "1"
    @card.save
    redirect_to :back, :notice => "Card updated successfully."
  end

  def unlearn
    @card.learned = "0"
    @card.save
    redirect_to :back, :notice => "Card updated successfully."
  end

  def destroy

    @card.destroy

    redirect_to "/cards", :notice => "Card deleted."
  end
end
