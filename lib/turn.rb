class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      return :mutually_assured_destruction
    end
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
      return :basic
    end
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      return :war
    end
  end

  def winner
    if type == :basic
      return [@player1,@player2].max_by do |player|
        player.deck.rank_of_card_at(0)
      end
    elsif type == :war
      return [@player1,@player2].max_by do |player|
        player.deck.rank_of_card_at(2)
      end
    else type == :mutually_assured_destruction
      return "No Winner!"
    end
  end

  def basic_winner?
    return [@player1,@player2].max_by do |player|
      player.deck.rank_of_card_at(0)
    end
  end


  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.cards.shift
      @spoils_of_war << @player2.deck.cards.shift
      @spoils_of_war = @spoils_of_war.flatten
    elsif type == :war
      @spoils_of_war << @player1.deck.cards.slice!(0..2)
      @spoils_of_war << @player2.deck.cards.slice!(0..2)
      @spoils_of_war = @spoils_of_war.flatten
    elsif type == :mutually_assured_destruction
      @spoils_of_war
    end
  end

  def award_spoils(winner)
    @spoils_of_war.each do |spoil|
      winner.deck.cards << spoil
    end
    @spoils_of_war = []
  end
end
